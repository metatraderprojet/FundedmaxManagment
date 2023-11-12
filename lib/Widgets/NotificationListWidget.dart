import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/GetNotificationResult.dart';

class NotificationListWidget extends StatelessWidget {
  final List<Datum>? notifications;
  final Function(Datum?) onDelete; // Callback function for onDelete

  NotificationListWidget({required this.notifications, required this.onDelete});

  Color getColorBySeverity(int severity) {
    switch (severity) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.red;
      default:
        return Colors.grey; // You can set a default color for unknown severity
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications?.length,
      itemBuilder: (context, index) {
        Datum? notification = notifications?[index];
        String formattedExpireDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(notification?.expireDate ?? DateTime.now().toUtc());
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            // Call the onDelete callback from the parent widget
            onDelete(notification);
          },
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16.0),
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: Card(
            color: getColorBySeverity(notification?.severity ?? 0),
            child: ListTile(
              title: Text(notification?.header ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification?.body ?? ''),
                  Text('Valid until: $formattedExpireDate'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
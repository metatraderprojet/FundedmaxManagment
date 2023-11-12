import 'package:flutter/material.dart';
import 'package:fundedmax_managment/Models/GetNotificationResult.dart';
import 'package:fundedmax_managment/Services/RestService.dart';
import 'package:fundedmax_managment/Views/AddNotificationPage.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Widgets/NotificationListWidget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(context) {
    return FutureBuilder<GetNotificationResult>(
      future: RestService.GetNotifications(),
      builder: (context, AsyncSnapshot<GetNotificationResult> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Notifications'),
            ),
            body: LiquidPullToRefresh(
              onRefresh: _handleRefresh,
              child: NotificationListWidget(notifications: snapshot.data?.data, onDelete: (p0) async {
                var result = await RestService.DeleteNotification(p0!.id);
                snapshot.data!.data.remove(p0);
                if (result != true){
                  await Alert(
                    context: context,
                    type: AlertType.error,
                    title: "Failed",
                    desc: "There was an error removing the notifications",
                  ).show();
                }
                setState(() {

                });
              }, ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotificationPage()));
              },
              child: Icon(Icons.add), // Change the icon as needed
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {
      // Add your refresh logic here
      // For example, you can fetch new data
    });
  }
}
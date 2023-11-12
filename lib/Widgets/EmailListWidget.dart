import 'package:flutter/material.dart';

import '../Models/GetMarketingEmailsResult.dart'; // Replace with the actual path to your models

class EmailListWidget extends StatelessWidget {
  final GetMarketingEmailsResult emailList;
  final Function(String) onDelete;

  EmailListWidget({required this.emailList, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: emailList.result.length,
      itemBuilder: (context, index) {
        Result email = emailList.result[index];
        return Dismissible(
          key: Key(email.id), // Use a unique key for each email
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {
            // Call the onDelete callback when the email is dismissed
            onDelete(email.id);
          },
          child: EmailCard(email: email),
        );
      },
    );
  }
}

class EmailCard extends StatelessWidget {
  final Result email;

  EmailCard({required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Customize card based on email data
      child: ListTile(
        title: Text(email.emailAddress),
        subtitle: Text('ID: ${email.id}'),
        // Add other widgets based on your requirements
      ),
    );
  }
}
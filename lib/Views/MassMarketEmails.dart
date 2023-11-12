import 'package:flutter/material.dart';
import 'package:fundedmax_managment/Models/GetMarketingEmailsResult.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Services/RestService.dart';
import '../Widgets/EmailListWidget.dart';
import 'AddMarketingEmail.dart';
import 'AddNotificationPage.dart';

class MassMarketEmails extends StatefulWidget {
  const MassMarketEmails({super.key});

  @override
  State<MassMarketEmails> createState() => _MassMarketEmailsState();
}

class _MassMarketEmailsState extends State<MassMarketEmails> {
  @override
  Widget build(context) {
    return FutureBuilder<GetMarketingEmailsResult>(
      future: RestService.GetMassMarketingEmails(),
      builder: (context, AsyncSnapshot<GetMarketingEmailsResult> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Mass Marketing Email'),
            ),
            body: LiquidPullToRefresh(
              onRefresh: _handleRefresh,
              child: EmailListWidget(
                emailList: snapshot.data!,
                onDelete:  (p0) async  {
                  var result = await RestService.DeleteMassMarketEmail(p0);
                  snapshot.data!.result.removeWhere((element) => element.id == p0);
                  if (result != true) {
                    await Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Failed",
                      desc: "There was an error removing the mass marketing email",
                    ).show();
                  }
                  setState(() {});
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddEmailPage()));
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

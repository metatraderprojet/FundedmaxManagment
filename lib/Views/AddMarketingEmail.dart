import 'package:flutter/material.dart';
import 'package:fundedmax_managment/Services/RestService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddEmailPage extends StatefulWidget {
  @override
  _AddEmailPageState createState() => _AddEmailPageState();
}

class _AddEmailPageState extends State<AddEmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String emailAddress = _emailController.text;
      // Call the function to add the email address
      var result = await  RestService.AddMassMarketingEmail(emailAddress);
      if (!result){
        await Alert(
          context: context,
          type: AlertType.error,
          title: "Failed",
          desc: "THere was an error adding the notification",
        ).show();
      }
      Navigator.pop(
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the email address';
                  }
                  // You can add more validation if needed
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
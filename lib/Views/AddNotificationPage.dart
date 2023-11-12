import 'package:flutter/material.dart';
import 'package:fundedmax_managment/Services/RestService.dart';
import 'package:fundedmax_managment/Views/HomePage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddNotificationPage extends StatefulWidget {
  @override
  _AddNotificationPageState createState() => _AddNotificationPageState();
}

class _AddNotificationPageState extends State<AddNotificationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _bodyController;
  late TextEditingController _headerController;
  late DateTime _expirationDateTime;
  int _severity = 0;

  @override
  void initState() {
    super.initState();
    _bodyController = TextEditingController();
    _headerController = TextEditingController();
    _expirationDateTime = DateTime.now();
  }

  @override
  void dispose() {
    _bodyController.dispose();
    _headerController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
    var result  = await RestService.addNotification(header: _headerController.text, body: _bodyController.text, expireDate: _expirationDateTime, severity: _severity);
    if (result){
      Navigator.pop(
        context
      );
     }else{
      await Alert(
        context: context,
        type: AlertType.error,
        title: "Failed",
        desc: "THere was an error adding the notification",
      ).show();
    }
    }
  }

  Future<void> _selectDateTime() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _expirationDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_expirationDateTime),
      );

      if (selectedTime != null) {
        setState(() {
          _expirationDateTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _bodyController,
                decoration: InputDecoration(labelText: 'Notification Body'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the notification body';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _headerController,
                decoration: InputDecoration(labelText: 'Notification Header'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the notification header';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text('Expiration Date: $_expirationDateTime'),
              ElevatedButton(
                onPressed: _selectDateTime,
                child: Text('Select Expiration Date and Time'),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<int>(
                value: _severity,
                onChanged: (value) {
                  setState(() {
                    _severity = value!;
                  });
                },
                items: [
                  DropdownMenuItem<int>(
                    value: 0,
                    child: Text('Info'),
                  ),
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text('Warning'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text('High'),
                  ),
                ],
                decoration: InputDecoration(labelText: 'Severity'),
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
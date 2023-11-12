import 'package:flutter/material.dart';
import 'package:fundedmax_managment/Services/RestService.dart';
import 'package:fundedmax_managment/Views/HomePage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Services/StaticServices.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Logo or Image
              Image.asset(
                'assets/fundedmax.jpg', // Replace with the path to your image
                width: 150, // Set your desired width
                height: 150, // Set your desired height
              ),

              // Space
              SizedBox(height: 20.0),

              // Username TextField
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),

              // Space
              SizedBox(height: 20.0),

              // Password TextField
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),

              // Space
              SizedBox(height: 20.0),

              // Login Button
              ElevatedButton(
                onPressed: () async {
                  // Add your login logic here
                  String username = usernameController.text;
                  String password = passwordController.text;

                  try {
                    var token = await RestService.Login(username, password);
                    await AppStorage.write('token', token);
                    await Alert(
                      context: context,
                      type: AlertType.success,
                      title: "Login Succeed",
                      desc: "Welcome",
                    ).show();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );

                  }catch (e){
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Login Failed",
                      desc: "Make sure username and password belongs to admin",
                    ).show();
                  }

                  // You can replace this with your authentication logic
                },
                child: Text('Login'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

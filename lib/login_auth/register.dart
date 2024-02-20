// Importing necessary Flutter packages and authentication service
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_saver/Pages/home.dart';
import 'package:life_saver/login_auth/firebase_auth/auth.dart';
import 'package:life_saver/shared/loading.dart';

// StatefulWidget for the RegistrationPage
class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

// State class for RegistrationPage
class _RegistrationPageState extends State<RegistrationPage> {

  // GlobalKey for the Form widget to identify and manipulate the form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variables to store email, password, and confirm password entered by the user
  String _emailReg = '';
  String _passwordReg = '';
  bool loading = false;

  // Controllers for email, password, and confirm password text fields
  final TextEditingController _mailText = TextEditingController();
  final TextEditingController _passText = TextEditingController();
  final TextEditingController _passcText = TextEditingController();

  // Instance of the AuthService class for authentication
  final AuthService auth = AuthService();

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ),
    );
  }

  // Build method to define the structure of the RegistrationPage
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      // Scaffold widget, a basic material design visual structure
      appBar: AppBar(
        // AppBar at the top of the screen with the title 'Register'
        title: const Text('Register'),
      ),
      body: Form(
        // Form widget to encapsulate form-related functionalities
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // TextFormField for email input
              TextFormField(
                key: Key('emailField'),
                controller: _mailText,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required.';
                  } else if (!RegExp(r"^[a-zA-Z0-9.+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$").hasMatch(value)) {
                    return 'Invalid email format.';
                  }
                  return null;
                },
                onSaved: (value) => _emailReg = value!,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              // TextFormField for password input
              TextFormField(
                key: Key('passwordField'),
                controller: _passText,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required.';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long.';
                  } else if (!RegExp(r"[a-zA-Z0-9!@#$%^&*()_+-={};':./<>?|~]").hasMatch(value)) {
                    return 'Password must contain a mix of letters, numbers, and special characters.';
                  }
                  return null;
                },
                onSaved: (value) => _passwordReg = value!,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),

              // TextFormField for confirming password
              TextFormField(
                key: Key('confirmPassword'),
                controller: _passcText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password confirmation is required.';
                  } else if (value != _passText.text) {
                    return 'Passwords do not match.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
              ),

              // ElevatedButton for the 'Register' action
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    setState(() => loading = true);
                    // _mailText.clear();
                    // _passText.clear();
                    // _passcText.clear();
                    // Calling the createUser method from the AuthService class
                    UserCredential? userCredential = await auth.createUser(_emailReg, _passwordReg, context);

                    // If userCredential is not null, sign-in was successful
                    if (userCredential != null) {
                      setState(() => loading = false);
                      // Navigate to the HomePage
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      setState(() => loading = false);
                      // Handle other logic or show a message if needed
                      _showErrorSnackBar(context, 'Sign-in failed. Please try again.');
                      // (e.g., userCredential is null if sign-in failed)
                    }
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Importing necessary Flutter packages and authentication service
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_saver/Pages/home.dart';
import 'package:life_saver/login_auth/firebase_auth/auth.dart';
import 'package:life_saver/shared/loading.dart';

// StatefulWidget for the SigninPage
class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

// State class for SigninPage
class _SigninPageState extends State<SigninPage> {

  // GlobalKey for the Form widget to identify and manipulate the form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variables to store email and password entered by the user
  String _email = '';
  String _password = '';

  bool loading = false;

  // Instance of the AuthService class for authentication
  final AuthService auth = AuthService();

  // Controllers for email and password text fields
  final TextEditingController _mailText = TextEditingController();
  final TextEditingController _passText = TextEditingController();

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ),
    );
  }


  // Build method to define the structure of the SigninPage
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.green.shade100,
      // Scaffold widget, a basic material design visual structure
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10,),

                Form(
                  // Form widget to encapsulate form-related functionalities
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // TextFormField for email input
                        TextFormField(
                          key: Key('emailField'),
                          keyboardType: TextInputType.emailAddress,
                          controller: _mailText,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            isDense: true,
                            filled: true,
                            fillColor: Colors.grey[200],
                            labelStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey), // Grey border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green), // Green border when focused
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required.';
                            } else if (!RegExp(r"^[a-zA-Z0-9.+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$").hasMatch(value)) {
                              return 'Invalid email format.';
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value!,
                        ),
                        SizedBox(height: 15.0),
                        // TextFormField for password input
                        TextFormField(
                          key: Key('passwordField'),
                          controller: _passText,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            isDense: true,
                            filled: true,
                            fillColor: Colors.grey[200],
                            labelStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey), // Grey border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green), // Green border when focused
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required.';
                            } else if (value.length < 8) {
                              return 'Password must be at least 8 characters long.';
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value!,
                        ),
                        SizedBox(height: 15.0),
                        // ElevatedButton for the 'Sign In' action
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() => loading = true);
                              // _mailText.clear();
                              // _passText.clear();
                              // Calling the signIn method from the AuthService class
                              UserCredential? userCredential = await auth.signIn(_email, _password, context);
                              // Checking if sign-in was successful
                              if (userCredential != null) {
                                setState(() => loading = false);
                                // Navigating to the HomePage on successful sign-in
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                );
                              } else {
                                setState(() => loading = false);
                                // Handle sign-in failure (e.g., display error message)
                                _showErrorSnackBar(context, 'Sign-in failed. Please try again.');
                              }
                            }
                          },
                          child: const Text('Sign In'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

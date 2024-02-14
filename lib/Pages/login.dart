// Importing necessary Flutter packages and custom authentication pages
import 'package:flutter/material.dart';
import 'package:life_saver/login_auth/register.dart';
import 'package:life_saver/login_auth/signin.dart';

// StatefulWidget for the main homepage of the application
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// State class for MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  // Button style to be used for ElevatedButtons
  ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    textStyle: TextStyle(fontSize: 16),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  );

  // Build method to define the structure of the homepage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold widget, a basic material design visual structure
      appBar: AppBar(
        // AppBar at the top of the screen with the title 'LIFESAVER'
        title: Text('LIFESAVER'),
      ),
      body: Center(
        // Center widget to center its child widgets
        child: Column(
          // Column to arrange child widgets vertically
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text widget displaying a multiline message
            Text(
              'We\nCare\nYour\nLife.',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 20), // SizedBox for spacing

            // Row widget to arrange buttons horizontally
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ElevatedButton for the 'Login' action
                ElevatedButton(
                  child: Text('Login'),
                  style: elevatedButtonStyle,
                  onPressed: () {
                    // Navigating to the SigninPage when the 'Login' button is pressed
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SigninPage()),
                    );
                  },
                ),
                SizedBox(width: 20), // SizedBox for spacing

                // ElevatedButton for the 'Sign up' action
                ElevatedButton(
                  child: Text('Sign up'),
                  style: elevatedButtonStyle,
                  onPressed: () {
                    // Navigating to the RegistrationPage when the 'Sign up' button is pressed
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

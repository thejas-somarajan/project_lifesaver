// Importing necessary Flutter packages and custom authentication pages
import 'package:flutter/material.dart';
import 'package:life_saver/login_auth/register.dart';
import 'package:life_saver/login_auth/signin.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

// State class for MyHomePage
class _MyLoginPageState extends State<MyLoginPage> {
  // Button style to be used for ElevatedButtons

  // Build method to define the structure of the homepage
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Scaffold widget, a basic material design visual structure
      body: Column (
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(25,25, 0,40),
                child: Image.asset(
                  'lib/assets/heart.png', // Replace 'assets/image.png' with your image path
                  width: 200.0, // Adjust width as needed
                  height: 200.0,
                ),
              )
            ],
          ),
          // Text widget displaying a multiline message
          Column(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(106, 6, 14,25),
                    child: Text(
                      'We\nCare\nYour\nLife.',
                      style: TextStyle(fontSize: 40,
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'lib/assets/watch.png', // Replace 'assets/image.png' with your image path
                      width: 120.0, // Adjust width as needed
                      height: 200.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15), // SizedBox for spacing

              // Row widget to arrange buttons horizontally
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // ElevatedButton for the 'Login' action
                  Column(
                    children: [
                      ElevatedButton(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white,fontSize: 20),),
                        style: ButtonStyle(
                          // Gradient background
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent.shade400),
                          // Rounded rectangle shape with border radius 5
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              // You can also provide additional border properties if needed
                              side: BorderSide(color: Colors.green, width: 2.0), // Border side
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Navigating to the Sign in Page when the 'Login' button is pressed
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SigninPage()),


                          );
                        },
                      ),
                      SizedBox(height: 15,),
                      Text('First time here?',
                        style: TextStyle(color: Colors.black38,fontSize: 15),),
                      SizedBox(height: 10,),// SizedBox for spacing

                      // ElevatedButton for the 'Sign up' action
                      ElevatedButton(
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white,fontSize: 20),),
                        style: ButtonStyle(
                          // Gradient background
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent.shade400),
                          // Rounded rectangle shape with border radius 5
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              // You can also provide additional border properties if needed
                              side: BorderSide(color: Colors.green, width: 2.0), // Border side
                            ),
                          ),
                        ),
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
            ],
          ),
        ],
      ),
    );
  }
}


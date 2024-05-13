// Importing the necessary Flutter packages
import 'package:flutter/material.dart';
import 'package:life_saver/Pages/welcome.dart';
import 'Pages/login.dart'; // Importing the login page
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Importing Firebase configuration options

// Main function to start the Flutter application
void main() async {
  // Ensures that Flutter bindings are initialized before runApp()
  WidgetsFlutterBinding.ensureInitialized();

  // Initializing Firebase app
  await initializeFirebaseApp();

  // Running the Flutter application
  runApp(MyApp());
}

// Asynchronous function to initialize the Firebase app
Future<void> initializeFirebaseApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

// Flutter application class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp widget, which is the root of the Flutter application
    return MaterialApp(
      home: WelcomePage(), // Setting the home page to MyHomePage()
    );
  }
}

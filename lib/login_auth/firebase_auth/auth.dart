// Importing necessary Flutter packages and Firebase authentication
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_saver/Pages/login.dart';


// AuthService class responsible for authentication
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to display an error Snackbar with a specified message
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ),
    );
  }

  // Method for email and password sign-in
  Future<UserCredential?> signIn(String email, String password, BuildContext context) async {
    try {
      // Attempting to sign in with provided email and password
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handling specific error codes for better user feedback
      if (e.code == 'user-not-found') {
        _showErrorSnackBar(context, 'User not found.');
      } else if (e.code == 'wrong-password') {
        _showErrorSnackBar(context, 'Wrong password');
      } else {
        _showErrorSnackBar(context, 'An error occurred.');
      }
      // Handle other potential errors
    }
  }

  // Method for user registration with email and password
  Future<UserCredential?> createUser(String email, String password, BuildContext context) async {
    try {
      // Attempting to create a new user with provided email and password
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handling specific error codes for better user feedback
      _showErrorSnackBar(context, 'Sign-up failed. Please try again.');
    }
  }

  //sign-out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      // Navigate to the login or home page after sign-out
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyLoginPage()),
      );
    } catch (e) {
      // Handle errors during sign-out
      print('Error signing out: $e');
      _showErrorSnackBar(context, 'Error signing out. Please try again.');
    }
  }

}

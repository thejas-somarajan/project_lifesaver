import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData {
  // Future<String?> getStoredUserId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? encryptedUserId = prefs.getString('userId');
  //   // Decrypt using secure methods if applicable
  //   // Return extracted userId or null if invalid or not found
  // }

  Future<String?> getCurrentUserId() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    } else {
      print('User id is not available');
    }
  }
}
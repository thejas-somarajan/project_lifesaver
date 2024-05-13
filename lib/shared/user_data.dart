import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData {

  Future<String?> getCurrentUserId() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    } else {
      print('User id is not available');
    }
  }
}
import 'package:flutter/material.dart';
import 'package:life_saver/Pages/profile.dart';
import 'package:life_saver/Pages/tips.dart';
import 'package:life_saver/Pages/vitals/vital_status.dart';
import 'package:life_saver/arduino-transfer/my_app.dart';
import 'package:life_saver/arduino-transfer/my_homepage.dart';

class Navi {
  void navigate(int index,BuildContext context) {
// Handle navigation here based on the selected index
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => vitalsPage(selectedIndex: index)),
      );
    }
    else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile(selectedIndex: index)),
      ); // Set the color for the unselected items
    }
    else if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Feature(selectedIndex: index)),
      ); // Set the color for the unselected items
    }
    else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(selectedIndex: index)),
      ); // Set the color for the unselected items
    }
  }
}
// pages/my_app.dart
import 'package:flutter/material.dart';
import 'my_homepage.dart';

class MyApp extends StatefulWidget {
  final int selectedIndex;

  MyApp({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blue Arduino',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(),
    );
  }
}

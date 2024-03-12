import 'package:flutter/material.dart';
import 'dart:async';

class CustomAlertDialog extends StatefulWidget {
  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  bool _dialogResult = false;

  @override
  void initState() {
    super.initState();
    //_startTimer();
  }

  void startTimer() {

    Timer(Duration(seconds: 10), () {
      if (mounted) {
        Navigator.of(context).pop(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return AlertDialog(
      title: Text('Message Sending Confirmation'),
      content: Text('Do you want to send the message?'),
      actions: [
        TextButton(
          onPressed: () {
            _dialogResult = false;
            Navigator.of(context).pop(true);
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            _dialogResult = true;
            Navigator.of(context).pop(false);
          },
          child: Text('Yes'),
        ),
      ],
    );
  }

  // @override
  // void dispose() {
  //   print("Dialog Result: $_dialogResult");
  //   super.dispose();
  // }
}


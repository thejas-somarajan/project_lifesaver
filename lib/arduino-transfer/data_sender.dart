import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';
import 'package:life_saver/shared/navigator.dart';
import 'device_page.dart';
import 'dart:convert';

class DataArd {
  static BluetoothConnection? connection; // Use BluetoothDevice instead of var

  /// Sets the Bluetooth connection.
  void setConnection(BluetoothConnection? device) {
    connection = device;
  }

  /// Sends a command to the connected Arduino device.
  void sendCommand(String command) {
    print('Reached inside sendCommand');
    if (connection != null && connection!.isConnected) {
      print('Reached insideif');
      print(connection);
      connection!.output.add(utf8.encode(command));
      connection!.output.allSent.then((_) {
        print('Command sent to Arduino');
      }).catchError((error) {
        print('Error sending command: $error');
      });
    } else {
      print('No active connection to Arduino');
    }
  }
}

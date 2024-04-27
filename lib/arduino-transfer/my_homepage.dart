// pages/my_home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';
import 'package:life_saver/shared/navigator.dart';
import 'device_page.dart';
import 'dart:convert';
import 'data_sender.dart';

class MyHomePage extends StatefulWidget {
  final int selectedIndex;

  MyHomePage({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BluetoothConnection? connection;

  // final int selectedIndex;

  int _selectedIndex=3;
  var text = '1';

  void _onItemTapped(int index) {
    Navi().navigate(index, context);
  }

  void _connectToBluetooth() async {
    BluetoothDevice selectedDevice = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectBondedDevicePage(),
      ),
    );

    if (selectedDevice != null) {
      print('Connecting to ${selectedDevice.name}...');
      await BluetoothConnection.toAddress(selectedDevice.address)
          .then((value) {
        print('Connected to ${selectedDevice.name}');
        connection = value;
        DataArd().setConnection(connection);
        _sendCommandToArduino();
      }).catchError((error) {
        print('Cannot connect, error: $error');
      });
    } else {
      print('No device selected');
    }
  }

  void _takeCommand(var com) {

    if (connection != null && connection!.isConnected) {
      connection!.output.add(utf8.encode(com));
      connection!.output.allSent.then((_) {
        print('Command sent to Arduino');
      }).catchError((error) {
        print('Error sending command: $error');
      });
    }

  }

  void _sendCommandToArduino() {
    if (connection != null && connection!.isConnected) {
      connection!.output.add(utf8.encode('1'));
      connection!.output.allSent.then((_) {
        print('Command sent to Arduino');
      }).catchError((error) {
        print('Error sending command: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blue Arduino'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _connectToBluetooth,
              child: Text('Connect to Arduino'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendCommandToArduino,
              child: Text('Send Data'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PreferredSize(

        preferredSize: const Size.fromHeight(70),

        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.message, color: _selectedIndex == 0 ? Colors.green[500] : Colors.grey),
              label: 'Tips',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info, color: _selectedIndex == 1 ? Colors.green[500] : Colors.grey),
              label: 'Vitals',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: _selectedIndex == 2 ? Colors.green[500] : Colors.grey),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.watch, color: _selectedIndex == 3 ? Colors.green[500] : Colors.grey),
              label: 'Watch',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green[500],
          unselectedItemColor: Colors.grey[500],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

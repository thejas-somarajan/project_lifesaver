// pages/my_home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';
import 'package:life_saver/Pages/home.dart';
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
      connection!.output.add(utf8.encode('0'));
      connection!.output.allSent.then((_) {
        print('connection signal');
        print('Command sent to Arduino');
      }).catchError((error) {
        print('Error sending command: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.greenAccent.shade200, Colors.greenAccent.shade100], // Define your gradient colors
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 45, 0, 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.home),
                  color: Colors.white,
                  onPressed: () {
                    // Navigate back to the home page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 80),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,60,0,0),
                          child: Text(
                            'Blue Arduino',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _connectToBluetooth,
                      child: Text('Connect to Arduino',
                        style: TextStyle(color: Colors.white,fontSize: 18),),
                      style: ButtonStyle(
                        // Gradient background
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent.shade400),
                        // Rounded rectangle shape with border radius 5
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // You can also provide additional border properties if needed
                            side: BorderSide(color: Colors.green, width: 2.0), // Border side
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _sendCommandToArduino,
                      child: Text('Send Data',
                        style: TextStyle(color: Colors.white,fontSize: 18),),
                      style: ButtonStyle(
                        // Gradient background
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent.shade400),
                        // Rounded rectangle shape with border radius 5
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // You can also provide additional border properties if needed
                            side: BorderSide(color: Colors.green, width: 2.0), // Border side
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        )
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

// pages/select_bonded_device_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';

class SelectBondedDevicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Device'),
      ),
      body: BondedDeviceList(),
    );
  }
}

class BondedDeviceList extends StatefulWidget {
  @override
  _BondedDeviceListState createState() => _BondedDeviceListState();
}

class _BondedDeviceListState extends State<BondedDeviceList> {
  List<BluetoothDevice> _devicesList = [];

  @override
  void initState() {
    super.initState();
    _getBondedDevices();
  }

  void _getBondedDevices() {
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        _devicesList = bondedDevices;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _devicesList.length,
      itemBuilder: (context, index) {
        String deviceName = _devicesList[index].name ?? 'Unknown device';
        return ListTile(
          title: Text(deviceName),
          onTap: () {
            Navigator.pop(context, _devicesList[index]);
          },
        );
      },
    );
  }
}

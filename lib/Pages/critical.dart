import 'package:flutter/material.dart';
import 'package:life_saver/arduino-transfer/data_sender.dart';
import 'dart:async';

import 'package:life_saver/ml_implementation/ml_file.dart';
import 'package:life_saver/sms/alertsignal.dart';
import 'package:life_saver/sms/sms_module.dart';


import 'package:life_saver/Database/firestore.dart';



class Critical_interface extends StatefulWidget {
  @override
  State<Critical_interface> createState() => _MyAppState();
}

class _MyAppState extends State<Critical_interface> {
  int stage = 1;

  late StreamController<int> stageController = StreamController<int>();

  late StreamController<Map<String, double>?> heartRateController;
  late StreamController<Map<String, double>?> tempController;
  late StreamController<Map<String, double>?> oxygenController;
  late StreamController<Map<String, double>?> bloodController;
  late StreamController<Map<String, double>?> edaController;


  Simulator simulator = Simulator();


  Map<int, List<double>> dataset = {
    1:[102.28,1.79,97.69,57.69,93.81,36.45],
    2:[105.65,2.1,97.26,57.26,92.54,36.3],
    3:[109.55,2.23,94.33,54.33,92.08,36.16],
    4:[112.68,2.86,94.22,54.22,91.95,35.8],
    5:[115.43,3.78,92.4,52.4,90.46,35.75],
    6:[119.05,4.46,92.05,52.05,89.07,35.68],
    7:[121.54,5.26,91.3,51.3,88.61,35.56],
    8:[123.58,5.27,89.17,49.17,86.72,35.33],
    9:[126.71,5.8,86.97,46.97,85.29,34.87],
    10:[129.54,6.59,85.67,45.67,83.41,34.77],
    11:[132.9,6.65,83.41,43.41,81.87,34.42],
    12:[135.19,6.78,82.48,42.48,81.76,33.97],
    13:[137.42,7.54,80.49,40.49,81.06,33.49],
    14:[140.64,8.25,78.25,38.25,80.96,33.01],
    15:[143.04,8.63,75.47,35.47,80.13,33],
  };





  late Timer timer1;
  late Timer timer2;
  int currentIndex = 1;
  int light = 0;
  int counter =1;

  int n = 1;

  @override
  void initState() {
    super.initState();



    heartRateController = StreamController<Map<String, double>>();
    tempController = StreamController<Map<String, double>>();
    oxygenController = StreamController<Map<String, double>>();
    bloodController = StreamController<Map<String, double>>();
    edaController = StreamController<Map<String, double>>();

    // Sms_Sender().profileSnatcher();


    // stageController = StreamController<int>.broadcast();

    timer1 = Timer.periodic(Duration(seconds: 10), (Timer t) async {
      // Simulate updating heart rate data every 2 seconds
      simulator.inCrementer(n++);
      print('N: $n');
      Map<String, double>? result = await simulator.getDataset();
      updateRate(result);
      // updateRate(dataset[currentIndex % dataset.length + 1]!);
      currentIndex++;
    });

    timer2 = Timer.periodic(Duration(seconds: 45), (Timer t) {
      // Simulate updating heart rate data every 2 seconds
      light=0;
      updateAlert(dataset[currentIndex % dataset.length + 1]!);

    });
  }

  void updateRate(Map<String, double>? newRate) async {
    counter = await stageData(newRate);
    // counter++;
    heartRateController.add(newRate);
    tempController.add(newRate);
    oxygenController.add(newRate);
    bloodController.add(newRate);
    edaController.add(newRate);

    stageController.add(counter);

    // if(counter >= 2 && light == 0){
    //   bool? result = await _showAlertDialog();
    //
    //   if(result == false && result != null ) {
    //     Sms_Sender().sendLocationViaSMS(newRate,counter);
    //
    //   }
    //   light = 1;
    // }
  }

  void updateAlert(List<double> newRate) async {
    if(counter >= 2 && light == 0){
      bool? result = await _showAlertDialog();

      if(result == false  ) {
        DataArd().sendCommand('s');
        Sms_Sender().sendLocationViaSMS(newRate,counter);
      }
      light = 1;
    }
  }

  Future<bool?> _showAlertDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog();
      },
    );
  }

  @override
  void dispose() {
    stageController.close();
    timer1.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stageController.stream,
      initialData: stage, // Initial value for the stage
      builder: (context, snapshot) {
        stage = snapshot.data!;
        return _buildScaffold(stage);
      },
    );
  }


  // Change this value to adjust the status
  Widget _buildScaffold(int stage) {
    Size screenSize = MediaQuery.of(context).size;

    // Calculate the margin based on the screen width
    double horizontalMargin = screenSize.width * 0.06;
    double verticalMargin = screenSize.height * 0.29;

    return MaterialApp(
      home: Scaffold(
        // backgroundColor:value < 0.5 ? Colors.green.shade100 : Colors.red.shade100,
        backgroundColor: stage == 1 ?
          Colors.green[100] : stage == 2 ?
          Colors.yellow[100] : stage == 3 ?
          Colors.orange[100] : stage == 4 ?
          Colors.red[100]: Colors.grey[100],

        body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  color:  stage == 1 ?
                  Colors.green : stage == 2 ?
                  Colors.yellow[500] : stage == 3 ?
                  Colors.orange : stage == 4 ?
                  Colors.red : Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 100, 30, 140),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 200.0),
                          child: Text(
                            'Status',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Container(
                          width: 268,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                width: stage * 70,
                                child: Container(
                                  decoration: BoxDecoration(
                                    //color: value < 0.5 ? Colors.green : Colors.red,
                                    color: stage == 1 ?
                                    Colors.green : stage == 2 ?
                                    Colors.yellow[500] : stage == 3 ?
                                    Colors.orange : stage == 4 ?
                                    Colors.red : Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 180),
                          child: Text(
                            stage < 2 ? 'Normal' : 'Critical',
                            style: TextStyle(
                              color: stage == 1 ?
                              Colors.green : stage == 2 ?
                              Colors.yellow[500] : stage == 3 ?
                              Colors.orange : stage == 4 ?
                              Colors.red : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 140),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical, // Vertical scrolling
                    child: Column(
                      children: [
                        Container(
                          height: 90, // Adjust height as needed
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                const SizedBox(width: 10.0),
                                Image.asset(
                                  'lib/assets/heart-attack.png',
                                  // Replace 'assets/image.png' with your image path
                                  width: 45.0, // Adjust width as needed
                                  height: 45.0, // Adjust height as needed
                                ),
                                const SizedBox(width: 12.0),
                                // Add some space between the image and text
                                StreamBuilder<Map<String, double>?>(
                                  stream: heartRateController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {

                                      final heartRateData = snapshot.data;
                                      final heartRate = heartRateData?['heart_rate'];

                                      return Row(
                                        children: [
                                          Text(
                                            'Heart Rate',
                                            style: TextStyle(fontSize: 19.0),
                                          ),
                                          SizedBox(width: 30),
                                          Text(
                                            heartRate != null ? heartRate.toStringAsFixed(2) : 'N/A',
                                            style: TextStyle(fontSize: 25.0),
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            'BPM',
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text(
                                        'Loading...',
                                        style: TextStyle(fontSize: 30.0),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 95, // Adjust height as needed
                          margin: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const SizedBox(width: 8.0),
                                Image.asset(
                                  'lib/assets/high-temperature.png',
                                  // Replace 'assets/image.png' with your image path
                                  width: 45.0, // Adjust width as needed
                                  height: 45.0, // Adjust height as needed
                                ),
                                const SizedBox(width: 11.0),
                                // Add some space between the image and text
                                StreamBuilder<Map<String, double>?>(
                                  stream: tempController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {

                                      final tempData = snapshot.data;
                                      final temp = tempData?['temp'];

                                      return Row(
                                        children: [
                                          Text(
                                            'Temperature',
                                            style: TextStyle(fontSize: 19.0),
                                          ),
                                          SizedBox(width: 30),
                                          Text(
                                            temp != null ? temp.toStringAsFixed(2) : 'N/A',
                                            style: TextStyle(fontSize: 25.0),
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            '°C',
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text(
                                        'Loading...',
                                        style: TextStyle(fontSize: 30.0),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ), Container(
                          height: 95, // Adjust height as needed
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                const SizedBox(width: 12.0),
                                Image.asset(
                                  'lib/assets/oxygen.png',
                                  // Replace 'assets/image.png' with your image path
                                  width: 55.0, // Adjust width as needed
                                  height: 55.0, // Adjust height as needed
                                ),
                                const SizedBox(width: 10.0),
                                // Add some space between the image and text
                                StreamBuilder<Map<String, double>?>(
                                  stream: oxygenController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {

                                      final oxysatData = snapshot.data;
                                      final oxy_sat = oxysatData?['oxy_sat'];

                                      return Row(
                                        children: [
                                          Text(
                                            'Oxygen',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          SizedBox(width: 50),
                                          Text(
                                            oxy_sat != null ? oxy_sat.toStringAsFixed(2) : 'N/A',
                                            style: TextStyle(fontSize: 30.0),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '%',
                                            style: TextStyle(fontSize: 10.0),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text(
                                        'Loading...',
                                        style: TextStyle(fontSize: 30.0),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ), Container(
                          height: 95, // Adjust height as needed
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                const SizedBox(width: 10.0),
                                Image.asset(
                                  'lib/assets/blood-pressure.png',
                                  // Replace 'assets/image.png' with your image path
                                  width: 45.0, // Adjust width as needed
                                  height: 45.0, // Adjust height as needed
                                ),
                                const SizedBox(width: 9.0),
                                // Add some space between the image and text
                                StreamBuilder<Map<String, double>?>(
                                  stream: bloodController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {

                                      final blood_sysData = snapshot.data;
                                      final blood_sys = blood_sysData?['blood_sys'];

                                      return Row(
                                        children: [
                                          Text(
                                            'Blood ',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          SizedBox(width: 60),
                                          Text(
                                            blood_sys != null ? blood_sys.toStringAsFixed(2) : 'N/A',
                                            style: TextStyle(fontSize: 25.0),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'mm',
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text(
                                        'Loading...',
                                        style: TextStyle(fontSize: 30.0),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 95, // Adjust height as needed
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                const SizedBox(width: 13.0),
                                Image.asset(
                                  'lib/assets/ecg-machine.png',
                                  // Replace 'assets/image.png' with your image path
                                  width: 45.0, // Adjust width as needed
                                  height: 45.0, // Adjust height as needed
                                ),
                                const SizedBox(width: 12.0),
                                // Add some space between the image and text

                                StreamBuilder<Map<String, double>?>(
                                  stream: edaController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {

                                      final edaData = snapshot.data;
                                      final eda = edaData?['eda'];

                                      return Row(
                                        children: [
                                          Text(
                                            'EDA',
                                            style: TextStyle(fontSize: 25.0),
                                          ),
                                          SizedBox(width: 80),
                                          Text(
                                            eda != null ? eda.toStringAsFixed(2) : 'N/A',
                                            style: TextStyle(fontSize: 25.0),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '',
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text(
                                        'Loading...',
                                        style: TextStyle(fontSize: 30.0),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              // padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
              margin: EdgeInsets.only(
                left: horizontalMargin,
                right: horizontalMargin,
                top: verticalMargin,
              ),
              width: 330,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text('Predicted Case :',
                          style: TextStyle(fontSize: 18.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,)),
                      SizedBox(width: 10),
                      Text(
                          'hemorrhage',
                          style: TextStyle(fontSize: 18.0,
                            color: stage == 1 ?
                            Colors.green : stage == 2 ?
                            Colors.yellow[500] : stage == 3 ?
                            Colors.orange : stage == 4 ?
                            Colors.red : Colors.black,
                            fontWeight: FontWeight.bold,)),
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.grey),
                  Row(
                    children: [
                      SizedBox(width: 25),
                      Text('Status :',
                          style: TextStyle(fontSize: 18.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,)),
                      SizedBox(width: 80),

                      Text(
                          stage == 1 ?
                          'Stage 1' : stage == 2 ?
                          'Stage 2' : stage == 3 ?
                          'Stage 3' : stage == 4 ?
                          'Stage 4' : 'Stage 4',
                          style: TextStyle(
                            color: stage == 1 ?
                            Colors.green : stage == 2 ?
                            Colors.yellow[500] : stage == 3 ?
                            Colors.orange : stage == 4 ?
                            Colors.red : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,)),
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.grey),
                  Row(

                    children: [
                      SizedBox(width: 25),
                      Text('Condition :',
                          style: TextStyle(fontSize: 18.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,)),
                      SizedBox(width: 55),
                      Text(
                          stage == 1 ?
                          'Dizzy' : stage == 2 ?
                          'Agitated' : stage == 3 ?
                          'Unconscious' : stage == 4 ?
                          'Unresponsive' : 'Unresponsive',
                          style: TextStyle(fontSize: 16.0,
                            color: stage == 1 ?
                            Colors.green : stage == 2 ?
                            Colors.yellow[500] : stage == 3 ?
                            Colors.orange : stage == 4 ?
                            Colors.red : Colors.black,

                            fontWeight: FontWeight.bold,)),
                    ],
                  ),
                ],
              ),
            ),
          ),

        ],
      ),

      ),
    );
  }
}

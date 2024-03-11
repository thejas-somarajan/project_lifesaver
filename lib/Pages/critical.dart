import 'package:flutter/material.dart';
import 'dart:async';

import 'package:life_saver/ml_implementation/ml_file.dart';



class Critical_interface extends StatefulWidget {
  @override
  State<Critical_interface> createState() => _MyAppState();
}

class _MyAppState extends State<Critical_interface> {
  int stage = 1;

  late StreamController<int> stageController = StreamController<int>();

  late StreamController<List<double>> heartRateController;
  late StreamController<List<double>> tempController;
  late StreamController<List<double>> oxygenController;
  late StreamController<List<double>> bloodController;
  late StreamController<List<double>> edaController;


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
  };

  late Timer timer;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();



    heartRateController = StreamController<List<double>>();
    tempController = StreamController<List<double>>();
    oxygenController = StreamController<List<double>>();
    bloodController = StreamController<List<double>>();
    edaController = StreamController<List<double>>();


    // stageController = StreamController<int>.broadcast();

    timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      // Simulate updating heart rate data every 2 seconds
      updateRate(dataset[currentIndex % dataset.length + 1]!);
      currentIndex++;
    });
  }

  void updateRate(List<double> newRate) async {
    int counter = await stageData(newRate);
    // counter++;

    heartRateController.add(newRate);
    tempController.add(newRate);
    oxygenController.add(newRate);
    bloodController.add(newRate);
    edaController.add(newRate);

    stageController.add(counter);
  }

  @override
  void dispose() {
    stageController.close();
    timer.cancel();
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
                                StreamBuilder<List<double>>(
                                  stream: heartRateController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        children: [
                                          Text(
                                            'Heart Rate',
                                            style: TextStyle(fontSize: 25.0),
                                          ),
                                          SizedBox(width: 50),
                                          Text(
                                            snapshot.data![0].toStringAsFixed(2),
                                            style: TextStyle(fontSize: 30.0),
                                          ),
                                          SizedBox(width: 4),
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
                                StreamBuilder<List<double>>(
                                  stream: tempController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        children: [
                                          Text(
                                            'Temperature',
                                            style: TextStyle(fontSize: 22.0),
                                          ),
                                          SizedBox(width: 50),
                                          Text(
                                            snapshot.data![2].toStringAsFixed(2),
                                            style: TextStyle(fontSize: 30.0),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '°C',
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
                                StreamBuilder<List<double>>(
                                  stream: oxygenController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        children: [
                                          Text(
                                            'Oxygen',
                                            style: TextStyle(fontSize: 25.0),
                                          ),
                                          SizedBox(width: 90),
                                          Text(
                                            snapshot.data![1].toStringAsFixed(2),
                                            style: TextStyle(fontSize: 30.0),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '%',
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
                                StreamBuilder<List<double>>(
                                  stream: bloodController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        children: [
                                          Text(
                                            'Blood ',
                                            style: TextStyle(fontSize: 25.0),
                                          ),
                                          SizedBox(width: 90),
                                          Text(
                                            snapshot.data![3].toStringAsFixed(2),
                                            style: TextStyle(fontSize: 30.0),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '%',
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

                                StreamBuilder<List<double>>(
                                  stream: edaController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        children: [
                                          Text(
                                            'EDA',
                                            style: TextStyle(fontSize: 25.0),
                                          ),
                                          SizedBox(width: 120),
                                          Text(
                                            snapshot.data![4].toStringAsFixed(2),
                                            style: TextStyle(fontSize: 30.0),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '%',
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
                      SizedBox(width: 25),
                      Text('Predicted Case :',
                          style: TextStyle(fontSize: 18.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,)),
                      SizedBox(width: 15),
                      Text(
                          'hemorrhage',
                          style: TextStyle(fontSize: 25.0,
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
                      SizedBox(width: 90),

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
                            fontSize: 25.0,)),
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
                      SizedBox(width: 65),
                      Text(
                          stage == 1 ?
                          'Dizzy' : stage == 2 ?
                          'Agitated' : stage == 3 ?
                          'Unconscious' : stage == 4 ?
                          'Unresponsive' : 'Unresponsive',
                          style: TextStyle(fontSize: 25.0,
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

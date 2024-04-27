import 'package:flutter/material.dart';
import 'package:life_saver/Pages/critical.dart';
import 'package:life_saver/Pages/profile.dart';
import 'package:life_saver/Pages/tips.dart';
import 'package:life_saver/shared/navigator.dart';
import 'vitals/vital_status.dart';
import 'dart:async';
import 'package:life_saver/Database/firestore.dart';


import 'package:life_saver/ml_implementation/ml_file.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  late StreamController<DateTime> _dateTimeController;

  Map<int, List<double>> normal = {
    1: [0.33, 84.44, 36.84, 99.8],
    2: [0.44, 83.17, 36.67, 98.6],
    3: [0.51,	82.76,	37.32, 95.6],
    4: [0.61,	83.02,	36.33, 96.3],
    5: [0.7,	78.67,	36.08, 97.1],
    6: [1.28,	75.83,	36.21, 95.2],
    7: [1.29,	75.55,	36.01, 93.8],
    8: [1.35,	75.57,	36.25, 96.7],
    // 9: [5.36, 133.53,	36.04, 85.67],
    // 10:[9.39, 121.74,	36.82, 87.69],
  };

  late StreamController<Map<String, double>?> heartRateController;
  late StreamController<Map<String, double>?> tempController;
  late StreamController<Map<String, double>?> oxygenController;

  late StreamController<int> traverseController;

  late Timer timer;
  int currentIndex = 1;
  int i = 1;

  static int n = 1;
  int clicked = 0;

  ProfileService _profileService = ProfileService();

  Simulator simulator = Simulator();

  @override
  void initState() {
    super.initState();

    heartRateController = StreamController<Map<String, double>>();
    tempController = StreamController<Map<String, double>>();
    oxygenController = StreamController<Map<String, double>>();

    traverseController = StreamController<int>();


    _dateTimeController = StreamController<DateTime>.broadcast();
    _startClock();

    timer = Timer.periodic(Duration(seconds: 5), (Timer t) async{
      // Simulate updating heart rate data every 2 seconds
      print(currentIndex);
      if(clicked == 1) {
        simulator.inCrementer(n++);
        print('N: $n');
        Map<String, double>? result = await simulator.getDataset();
        updateRate(result);
        // updateRate(result1);
      }
      else {
        simulator.inCrementer(n++);
        print('N: $n');
        Map<String, double>? result = await simulator.getNormal();
        updateRate(result);

        // updateRate(simulator.getNormal());
      }
      // updateRate(result);
      // updateRate(normal[currentIndex % normal.length + 1]!);

      // _profileService.getDataset(i++);

      currentIndex++;
    });
  }

  void updateRate(Map<String, double>? newRate) {
    heartRateController.add(newRate);
    tempController.add(newRate);
    oxygenController.add(newRate);

    critical_traverse(newRate);
  }

  @override
  void dispose() {
    heartRateController.close();
    tempController.close();
    oxygenController.close();

    timer.cancel();

    _dateTimeController.close();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _dateTimeController = StreamController<DateTime>.broadcast();
  //   _startClock();
  // }

  // @override
  // void dispose() {
  //   _dateTimeController.close();
  //   super.dispose();
  // }


  void critical_traverse(Map<String, double>? newRate) async{
    // final Stream<String> traverse = traverseController.stream;
    int data = await processData(newRate);
    print(data);

    // Subscribe to the stream
    // final StreamSubscription<String> subscription =
    // traverse.listen((int data) {
    //     if(data == 0)
    //       {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => Critical_interface()),
    //         );
    //       }
    // });

    if(data == 0)
          {
            dispose();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Critical_interface()),
            );
          }
    else
      {
        print('brooks was here');
      }


  }


  void _startClock() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      now = DateTime.now();
      _dateTimeController.add(now);
    });
  }
  //
  // String getCurrentTime() {
  //   String formattedTime = "${now.hour}:${now.minute}";
  //   return formattedTime;
  // }

  String AMPM(String formattedTime) {
    if (now.hour < 12) {
      formattedTime = formattedTime + " AM";
    } else {
      formattedTime = formattedTime + " PM";
    }
    return formattedTime;
  }

  String Month(String formattedDate) {
    switch (now.month) {
      case 1:
        return "Jan " + formattedDate;
      case 2:
        return ("Feb " + formattedDate);
      case 3:
        return ("Mar " + formattedDate);
      case 4:
        return ("April " + formattedDate);
      case 5:
        return ("May " + formattedDate);
      case 6:
        return ("June " + formattedDate);
      case 7:
        return ("July " + formattedDate);
      case 8:
        return ("Aug " + formattedDate);
      case 9:
        return ("Sept " + formattedDate);
      case 10:
        return ("Oct " + formattedDate);
      case 11:
        return ("Nov " + formattedDate);
      case 12:
        return ("Dec " + formattedDate);
      default:
        return "Jan";
    }
  }

  void _onItemTapped(int index) {
    Navi().navigate(index, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200, // Height of your custom app bar
            decoration: BoxDecoration(
              color: Colors.green[500],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'lib/assets/watch_home.png',
                      width: 120.0, // Adjust size as needed
                      height: 160.0, // Adjust size as needed
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Apple S8',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          'connected',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Icon(
                          Icons.battery_0_bar_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/logo.png',
                      width: 180.0, // Adjust size as needed
                      height: 130.0, // Adjust size as needed
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(24, 28, 24, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<DateTime>(
                  stream: _dateTimeController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      DateTime currentTime = snapshot.data!;
                      String formattedTime =
                          "${currentTime.hour}:${currentTime.minute}";
                      String dateMonth =
                          "${currentTime.day} ${currentTime.year}";
                      dateMonth = Month(dateMonth);
                      formattedTime = AMPM(formattedTime);
                      return Row(
                        children: [
                          Text(
                            formattedTime,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            dateMonth,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    } else {
                      return Text('Loading...'); // Initial loading state
                    }
                  },
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => Critical_interface()),
                    // );
                    clicked = 1;
                  },
                  icon: Icon(Icons.add), // Wrap Icons.add with Icon widget
                  label: Text(''), // Wrap 'h' with Text widget
                ),
              ],
            ),
          ),

          // Second Row
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 1),
              scrollDirection: Axis.vertical, // Vertical scrolling
              child: Column(
                children: [
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
                          const SizedBox(width: 10.0),
                          Image.asset(
                            'lib/assets/heart-attack.png', // Replace 'assets/image.png' with your image path
                            width: 45.0, // Adjust width as needed
                            height: 45.0, // Adjust height as needed
                          ),
                          const SizedBox(
                              width:
                                  12.0), // Add some space between the image and text
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
                                      style: TextStyle(fontSize: 25.0),
                                    ),
                                    SizedBox(width: 50),
                                    Text(
                                      heartRate != null ? heartRate.toStringAsFixed(2) : 'N/A',
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
                            'lib/assets/high-temperature.png', // Replace 'assets/image.png' with your image path
                            width: 45.0, // Adjust width as needed
                            height: 45.0, // Adjust height as needed
                          ),
                          const SizedBox(
                              width:
                                  11.0), // Add some space between the image and text
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
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    SizedBox(width: 50),
                                    Text(
                                      temp != null ? temp.toStringAsFixed(2) : 'N/A',
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
                          const SizedBox(width: 12.0),
                          Image.asset(
                            'lib/assets/oxygen.png',
                            width: 55.0, // Adjust width as needed
                            height: 55.0, // Adjust height as needed
                          ),
                          const SizedBox(
                              width:
                                  10.0), // Add some space between the image and text
                          StreamBuilder<Map<String, double>?>(
                            stream: oxygenController.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final oxy_sat = snapshot.data;
                                final oxy = oxy_sat?['eda'];

                                return Row(
                                  children: [
                                    Text(
                                      'EDA',
                                      style: TextStyle(fontSize: 25.0),
                                    ),
                                    SizedBox(width: 80),
                                    Text(
                                      oxy != null ? oxy.toStringAsFixed(2) : 'N/A',
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
        ],
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                color:
                    //selectedIndex == 0 ?
                    Colors.green[500],
                // : Colors.grey
              ), // Set color conditionally
               label: 'Tips',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info,
                  color:
                      // _selectedIndex == 1 ?
                      Colors.green[500]
                  // : Colors.grey
                  ), // Set color conditionally
              label: 'Vitals',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color:
                    //  _selectedIndex == 2 ?
                    Colors.green[500],
                // : Colors.grey
              ), // Set color conditionally
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.watch,
                color:
                //  _selectedIndex == 2 ?
                Colors.green[500],
              ),
              label: 'Watch',
            ),
          ],
          //  currentIndex: _selectedIndex,
          selectedItemColor:
              Colors.green[500], // Set the color for the selected item
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

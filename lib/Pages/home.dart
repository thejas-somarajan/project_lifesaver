import 'package:flutter/material.dart';
import 'package:life_saver/Pages/profile.dart';
import 'package:life_saver/Pages/tips.dart';
import 'package:life_saver/shared/navigator.dart';
import 'vitals/vital_status.dart';
import 'dart:async';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  late StreamController<DateTime> _dateTimeController;

  Map<int, List<double>> normal = {
    1:[92.8, 97.2, 36.8, 102.3, 1.5],
    2:[94.4, 98.3, 37.1, 103.5, 1.8],
    3:[90.7, 95.8, 37.1, 101.6, 1.9],
    4:[92.7, 98.8, 37.3, 103.9, 1.1],
    5:[90.9, 99.9, 37.3, 103.2, 1.1],
    6:[94.7, 97.7, 36.9, 100.3, 1.5],
    7:[92.8, 95.5, 37.5, 101.3, 1.7],
    8:[93.2, 95.2, 37.3, 104.1, 1.2],
  };

  late StreamController<List<double>> heartRateController;
  late StreamController<List<double>> tempController;
  late StreamController<List<double>> oxygenController;



  late Timer timer;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();



    heartRateController = StreamController<List<double>>();
    tempController = StreamController<List<double>>();
    oxygenController = StreamController<List<double>>();

    _dateTimeController = StreamController<DateTime>.broadcast();
    _startClock();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      // Simulate updating heart rate data every 2 seconds
      updateRate(normal[currentIndex % normal.length + 1]!);
      currentIndex++;
    });
  }

  void updateRate(List<double> newRate) {
    heartRateController.add(newRate);
    tempController.add(newRate);
    oxygenController.add(newRate);
  }

  @override
  void dispose() {
    heartRateController.close();
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
    if(now.hour < 12)
    {
      formattedTime = formattedTime + " AM";
    }
    else
    {
      formattedTime = formattedTime + " PM";
    }
    return formattedTime;
  }

  String Month(String formattedDate) {
    switch(now.month) {
      case 1: return "Jan " + formattedDate;
      case 2: return ("Feb " + formattedDate);
      case 3: return ("Mar " + formattedDate);
      case 4: return ("April " + formattedDate);
      case 5: return ("May " + formattedDate);
      case 6: return ("June " + formattedDate);
      case 7: return ("July " + formattedDate);
      case 8: return ("Aug " + formattedDate);
      case 9: return ("Sept " + formattedDate);
      case 10: return ("Oct " + formattedDate);
      case 11: return ("Nov " + formattedDate);
      case 12: return ("Dec " + formattedDate);
      default: return "Jan";
    }
  }

  void _onItemTapped(int index) {
    Navi().navigate(index, context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children :[
          Container(
            height: 200, // Height of your custom app bar
            decoration: BoxDecoration(
              color: Colors.green[500],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.fromLTRB(5, 5, 10,5),
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
                        SizedBox(height: 4,),
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
                      String dateMonth = "${currentTime.day} ${currentTime.year}";
                      dateMonth = Month(dateMonth);
                      formattedTime = AMPM(formattedTime);
                      return Row(
                        children: [
                          Text(
                            formattedTime,
                            style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 60.0),
                          Text(
                            dateMonth,
                            style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    } else {
                      return Text('Loading...'); // Initial loading state
                    }
                  },
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
                          const SizedBox(width: 12.0), // Add some space between the image and text
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
                                    SizedBox(width: 10),
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
                            'lib/assets/high-temperature.png', // Replace 'assets/image.png' with your image path
                            width: 45.0, // Adjust width as needed
                            height: 45.0, // Adjust height as needed
                          ),
                          const SizedBox(width: 11.0), // Add some space between the image and text
                          StreamBuilder<List<double>>(
                            stream: tempController.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: [
                                    Text(
                                      'Temperature',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    SizedBox(width: 10),
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
                  ),Container(
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
                          const SizedBox(width: 10.0), // Add some space between the image and text
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
                                    SizedBox(width: 10),
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
                icon: Icon(Icons.message, color:
                //selectedIndex == 0 ?
                Colors.green[500],
                  // : Colors.grey
                ), // Set color conditionally
                label: 'Tips',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info, color:
                // _selectedIndex == 1 ?
                Colors.green[500]
                  // : Colors.grey
                ), // Set color conditionally
                label: 'Vitals',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color:
                //  _selectedIndex == 2 ?
                Colors.green[500],
                  // : Colors.grey
                ), // Set color conditionally
                label: 'Profile',
              ),
            ],
            //  currentIndex: _selectedIndex,
            selectedItemColor: Colors.green[500], // Set the color for the selected item
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
          ),
          ),

          );
          }
  }



import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:life_saver/Pages/home.dart';
import 'package:life_saver/shared/navigator.dart';
import 'chart.dart';
import 'dart:async';




// void main() {
//   runApp(vitals());
// }

// class vitals extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'vital page',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: vitalsPage(selectedIndex: 0),
//     );
//   }
// }

class vitalsPage extends StatefulWidget {
  final int selectedIndex;
  vitalsPage({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _vitalsPageState createState() => _vitalsPageState(selectedIndex);
}

class _vitalsPageState extends State<vitalsPage> {

  int _selectedIndex;

  _vitalsPageState(this._selectedIndex);

  void _onItemTapped(int index) {
    Navi().navigate(index, context);
  }
  final List<BarChartModel> data = [
    BarChartModel(
      month: "1 Feb",
      rate: 72,
      color: charts.ColorUtil.fromDartColor(Colors.redAccent),
    ),
    BarChartModel(
      month: "2 Feb",
      rate: 72,
      color: charts.ColorUtil.fromDartColor(Colors.redAccent),
    ),
    BarChartModel(
      month: "3 Feb",
      rate: 88,
      color: charts.ColorUtil.fromDartColor(Colors.redAccent),
    ),
    BarChartModel(
      month: "4 Feb",
      rate: 64,
      color: charts.ColorUtil.fromDartColor(Colors.redAccent),
    ),
    BarChartModel(
      month: "5 Feb",
      rate: 79,
      color: charts.ColorUtil.fromDartColor(Colors.redAccent),
    ),
    BarChartModel(
      month: "6 Feb",
      rate: 93,
      color: charts.ColorUtil.fromDartColor(Colors.redAccent),
    ),
    BarChartModel(
      month: "7 Feb",
      rate: 75,
      color: charts.ColorUtil.fromDartColor(Colors.redAccent),
    ),
  ];

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
  late StreamController<List<double>> bloodController;
  late StreamController<List<double>> edaController;



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
    bloodController.add(newRate);
    edaController.add(newRate);
  }

  @override
  void dispose() {
    heartRateController.close();
    timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "rate",
        data: data,
        domainFn: (BarChartModel series, _) => series.month,
        measureFn: (BarChartModel series, _) => series.rate,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];

    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(series),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        title: const Center(
          child: Text(
            'Vital status',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          Image.asset(
            'lib/assets/logo.png',
            width: 140.0,
            height: 140.0,
          ),
        ],
        leading: IconButton(
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
        backgroundColor: Colors.green[500],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
    );
  }

  Widget buildBody(List<charts.Series<BarChartModel, String>> series) {
    return Column(
      children: [
        // First Row: Bar Chart
        buildBarChart(series),
        // Second Row: User Status Container
        buildUserStatusContainer(),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical, // Vertical scrolling
            child: Column(
              children: [

              Container(
                height: 95,
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
                          width: 45.0,
                          height: 45.0,
                        ),
                        const SizedBox(width: 12.0),
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
                  height: 95,
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
                          'lib/assets/high-temperature.png',
                          width: 45.0,
                          height: 45.0,
                        ),
                        const SizedBox(width: 12.0),
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
                ),
                Container(
                  height: 95,
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
                          'lib/assets/oxygen.png',
                          width: 45.0,
                          height: 45.0,
                        ),
                        const SizedBox(width: 12.0),
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
                ),
                Container(
                  height: 95,
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
                          width: 45.0,
                          height: 45.0,
                        ),
                        const SizedBox(width: 12.0),
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
                  height: 95,
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
                          'lib/assets/ecg-machine.png',
                          width: 45.0,
                          height: 45.0,
                        ),
                        const SizedBox(width: 12.0),
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
        // Third Row: Vital Containers
        // buildVitalContainer('Heart rate', 'BPM', 'heart-attack.png'),
        // buildVitalContainer('Temperature', '°C', 'high-temperature.png'),
        // buildVitalContainer('Oxygen', '%', 'oxygen.png'),
        // Add more vital containers as needed
      ],
    );
  }

  Widget buildBarChart(List<charts.Series<BarChartModel, String>> series) {
    return Container(
      height: 270,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: charts.BarChart(
          series,
          animate: true,
        ),
      ),
    );
  }

  Widget buildUserStatusContainer() {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 2, 5, 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.green[400],
      ),
      width: MediaQuery.of(context).size.width * 0.7,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info, color: Colors.white),
          SizedBox(width: 10),
          Text(
            'User status: Normal',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Widget buildVitalContainer(String title, String unit, String imagePath) {
  //   return Container(
  //     height: 95,
  //     margin: const EdgeInsets.all(15),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(15),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.5),
  //           spreadRadius: 2,
  //           blurRadius: 10,
  //           offset: const Offset(0, 3),
  //         ),
  //       ],
  //       color: Colors.white,
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(4.0),
  //       child: Row(
  //         children: [
  //           const SizedBox(width: 10.0),
  //           Image.asset(
  //             'lib/assets/$imagePath',
  //             width: 45.0,
  //             height: 45.0,
  //           ),
  //           const SizedBox(width: 12.0),
  //           Row(
  //             children: [
  //               Text(
  //                 title,
  //                 style: TextStyle(fontSize: 20.0),
  //               ),
  //               SizedBox(width: 70),
  //               Row(
  //                 children: [
  //                   Text(
  //                     'XX',
  //                     style: TextStyle(fontSize: 25.0),
  //                   ),
  //                   SizedBox(width: 4),
  //                   Text(
  //                     unit,
  //                     style: TextStyle(fontSize: 15.0),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  PreferredSizeWidget buildBottomNavigationBar() {
    return PreferredSize(
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[500],
        unselectedItemColor: Colors.grey[500],
        onTap: _onItemTapped,
      ),
    );
  }
}


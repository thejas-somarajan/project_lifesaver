import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:life_saver/Pages/home.dart';
import 'package:life_saver/shared/navigator.dart';
import 'chart.dart';



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
                buildVitalContainer('Heart Rate', 'BPM', 'heart-attack.png'),
                buildVitalContainer('Temperature', '°C', 'high-temperature.png'),
                buildVitalContainer('Oxygen', '%', 'oxygen.png'),
                buildVitalContainer('Blood Pressure', '%', 'blood-pressure.png'),
                buildVitalContainer('EDA', '%', 'ecg-machine.png'),
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

  Widget buildVitalContainer(String title, String unit, String imagePath) {
    return Container(
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
              'lib/assets/$imagePath',
              width: 45.0,
              height: 45.0,
            ),
            const SizedBox(width: 12.0),
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(width: 70),
                Row(
                  children: [
                    Text(
                      'XX',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SizedBox(width: 4),
                    Text(
                      unit,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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


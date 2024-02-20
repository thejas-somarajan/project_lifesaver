import 'package:flutter/material.dart';
import 'package:life_saver/Pages/profile.dart';
import 'vitals/vital_status.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Build the AppBar
      appBar: buildAppBar(),

      // Build the main body content
      body: buildBody(),

      // Build the BottomNavigationBar
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  // Function to build the AppBar
  PreferredSizeWidget? buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(180),
      child: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Apple S8', style: TextStyle(fontSize: 16)),
                Text('connected', style: TextStyle(fontSize: 16)),
                Icon(Icons.battery_alert, color: Colors.black, size: 25),
              ],
            )
          ],
        ),
        actions: [
          Image.asset(
            'lib/assets/logo.png',
            alignment: Alignment.center,
            width: 180.0,
            height: 180.0,
          ),
        ],
        leading: Icon(Icons.watch, color: Colors.white, size: 20),
        backgroundColor: Colors.green[500],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
    );
  }

  // Function to build the main body content
  Widget buildBody() {
    return Column(
      children: [
        // Top section with time and date
        Container(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '10:00 PM',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'Sunday, February 4',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),

        // Expanded section for vital containers
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // Vital containers
                buildVitalContainer('Heart rate', 'BPM', 'heart-attack.png'),
                buildVitalContainer('Temperature', '°C', 'high-temperature.png'),
                buildVitalContainer('Oxygen', '%', 'oxygen.png'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Function to build individual vital containers
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
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(width: 70),
                Row(
                  children: [
                    Text(
                      'XX',
                      style: TextStyle(fontSize: 28.0),
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

  // Function to build the BottomNavigationBar
  Widget buildBottomNavigationBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message, color: Colors.green[500]),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info, color: Colors.green[500]),
            label: 'Vitals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.green[500]),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green[500],
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            // Navigate to vitalsPage on tapping 'Vitals'
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => vitalsPage()),
            );
          }
          else if (index == 2){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
            );
          }
        },
      ),
    );
  }
}

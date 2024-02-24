import 'package:flutter/material.dart';
import 'package:life_saver/Pages/profile.dart';
import 'package:life_saver/Pages/tips.dart';
import 'package:life_saver/shared/navigator.dart';
import 'vitals/vital_status.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

                Text(
                  '10:00 PM',
                  style: TextStyle(fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sunday, February 4',
                  style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold),
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
                          const Row(
                            children: [
                              Text(
                                'Heart rate',
                                style: TextStyle(fontSize: 28.0,),
                              ),
                              SizedBox(width: 70,),
                              Row(
                                children: [
                                  Text(
                                    'XX',
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                  SizedBox(width: 4,),
                                  Text(
                                    'BPM',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ],
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
                          const Row(
                            children: [
                              Text(
                                'Temperature',
                                style: TextStyle(fontSize: 28.0,),
                              ),
                              SizedBox(width: 44,),
                              Row(
                                children: [
                                  Text(
                                    'XX',
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                  SizedBox(width: 6,),
                                  Text(
                                    '°C',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ],
                              ),
                            ],
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
                          const Row(
                            children: [
                              Text(
                                'Oxygen',
                                style: TextStyle(fontSize: 28.0,),
                              ),
                              SizedBox(width: 105,),
                              Row(
                                children: [
                                  Text(
                                    'XX',
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                  SizedBox(width: 6,),
                                  Text(
                                    '%',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ],
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



import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lifesaver'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '10:00 PM',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      'Sunday, February 4',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              Divider(height: 20.0),
              ListTile(
                leading: Icon(Icons.watch),
                title: Text('Apple Watch S8'),
                subtitle: Text('Connected'),
                trailing: Text('15%'),
              ),
              Divider(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Heart rate'),
                      Text(
                        'XX BPM', // Replace with actual heart rate value
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Temperature'),
                      Text(
                        'XX °C', // Replace with actual temperature value
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                ],
              ),
              // Divider(height: 150.0),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_vert),
              label: 'Home',
            ),
          ],
        ),
      ),
    );
  }
}

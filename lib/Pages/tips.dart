import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:life_saver/Pages/home.dart';
import 'package:life_saver/shared/navigator.dart';

class Feature extends StatefulWidget {
  final int selectedIndex;
  Feature({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _FeatureState createState() => _FeatureState(selectedIndex);
}

class _FeatureState extends State<Feature> {

  int _selectedIndex;

  _FeatureState(this._selectedIndex);

  List<String> healthTips = [
    "An apple a day keeps the doctor away.",
    "Drink plenty of water every day.",
    "Get at least 30 minutes of exercise daily.",
    "Eat a balanced diet with plenty of fruits and vegetables.",
    "Get enough sleep every night.",
    "Avoid sugary drinks and processed foods.",
    "Take breaks to stretch and move if you sit for long periods.",
    // Add more health tips as needed
  ];

  String currentHealthTip = '';
  DateTime? lastGeneratedDate;
  final storage = FlutterSecureStorage();

  void _onItemTapped(int index) {
    Navi().navigate(index, context);
  }

  @override
  void initState() {
    super.initState();
    _loadLastGeneratedDate();
  }

  Future<void> _loadLastGeneratedDate() async {
    String? storedDate = await storage.read(key: 'lastGeneratedDate');
    if (storedDate != null) {
      setState(() {
        lastGeneratedDate = DateTime.parse(storedDate);
      });
    }
    generateRandomHealthTip();
  }

  Future<void> _saveLastGeneratedDate() async {
    await storage.write(key: 'lastGeneratedDate', value: DateTime.now().toIso8601String());
  }

  void generateRandomHealthTip() {
    DateTime now = DateTime.now();
    if (lastGeneratedDate == null || !_isSameDay(now, lastGeneratedDate!)) {
      setState(() {
        currentHealthTip = healthTips[Random().nextInt(healthTips.length)];
        lastGeneratedDate = now;
      });
      _saveLastGeneratedDate();
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(165, 221, 120, 1),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 45, 0, 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
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
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      'Tip of the day...',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 260,
                    height: 370,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(51, 190, 51, 1),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '"',
                          style: TextStyle(fontSize: 45),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          currentHealthTip,
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => _onButtonPressed('share'),
                              icon: Icon(Icons.share),
                              color: Colors.white,
                            ),
                            SizedBox(width: 16),
                            IconButton(
                              onPressed: () => _onButtonPressed('like'),
                              icon: Icon(Icons.thumb_up),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: generateRandomHealthTip,
                    child: Text(
                      'Health tips',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 52, 231, 58)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message, color: _selectedIndex == 0 ? Colors.blue : Colors.white),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info, color: _selectedIndex == 1 ? Colors.blue : Colors.white),
            label: 'Vitals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: _selectedIndex == 2 ? Colors.blue : Colors.white),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onButtonPressed(String action) {
    // Handle button press (share or like) here
  }
}

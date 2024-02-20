import 'package:flutter/material.dart';
import 'package:life_saver/Pages/login.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.green.shade100],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text(
                  'Welcome User,',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              SizedBox(
                height: 560,
                child: CardCarousel(),
              ),
              TextButton(
                onPressed: () {
                  print('Button pressed!');
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyLoginPage()),
                  );
                  // Add actions for the button here
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardCarousel extends StatefulWidget {
  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> imageUrls = [
    'lib/assets/1.png',
    'lib/assets/3.jpg',
    'lib/assets/4.jpg',
    'lib/assets/5.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(20, 20, 20, 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 12,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              imageUrls.length,
                  (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                width: 10,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? Colors.green.withOpacity(0.8)
                      : Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

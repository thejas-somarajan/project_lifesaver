import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_saver/Database/firestore.dart';
import 'package:life_saver/Pages/home.dart';
import 'package:life_saver/login_auth/firebase_auth/auth.dart';
import 'package:life_saver/ml_implementation/ml_file.dart';
import 'package:life_saver/shared/navigator.dart';
import 'package:life_saver/shared/profile_editor.dart';
import 'package:life_saver/shared/stream_function.dart';
import 'package:life_saver/shared/user_data.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Profile extends StatefulWidget {

  final int selectedIndex;

  Profile({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState(selectedIndex);
}

class _ProfileState extends State<Profile> {

  int _selectedIndex;

  _ProfileState(this._selectedIndex);

  final AuthService _auth = AuthService();
  String? userid = '';
  File? _imageFile;
  ProfileService _profileService = ProfileService();

  void _onItemTapped(int index) {
    Navi().navigate(index, context);
  }

  void Userid_call() async {
    userid = await UserData().getCurrentUserId();
    print('User id is $userid');
  }

  ImageProvider<Object>? _getImageProvider() {
    if (_imageFile != null) {
      return FileImage(_imageFile!) as ImageProvider<Object>;
    } else {
      return NetworkImage('https://via.placeholder.com/150');
    }
  }

  Widget buildProfileWidget(Map<String, dynamic> userData) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildInfoColumn('Height', userData['height'] ?? 'N/A'),
            buildInfoColumn('Weight', userData['weight'] ?? 'N/A'),
            buildInfoColumn('Blood Group', userData['blood_group'] ?? 'N/A'),
          ],
        ),
        SizedBox(height: 15.0,),
        Column(
          children: <Widget>[
            buildListTile('Name', userData['name'] ?? 'N/A'),
            buildListTile('Phone No.', userData['phone'] ?? 'N/A'),
            buildListTile('Address', userData['address'] ?? 'N/A'),
            buildListTile('Urgent Contact', userData['urgent_contact'] ?? 'N/A'),
          ],
        ),
      ],
    );
  }

  Widget buildInfoColumn(String title, dynamic value) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
            value.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget buildListTile(String title, dynamic value) {
    return ListTile(
      title: Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
          ),
      ),
      trailing: Text(
        value.toString(),
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }

  // Removed the Future<Map<String, dynamic>?> pegasus() function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 231),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            BackgroundContainer(),
            Positioned(
              top: 110,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40.0,
                            // Uncomment the following line and provide the image URL
                            backgroundImage: _getImageProvider(),
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProfileUpdate()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0),
                    // Replaced Container with StreamBuilder
                    StreamBuilder<DocumentSnapshot<Object?>?>(
                      stream: _profileService.getProfileDataStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || !snapshot.data!.exists) {
                          return Text('User profile not found.');
                        } else {
                          // Moved buildProfileWidget call inside StreamBuilder
                          Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;

                          return buildProfileWidget(userData);
                        }
                      },
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await _auth.signOut(context);
                        },
                        child: Text(
                          'Sign Out',
                          style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PreferredSize(

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
      ),
    );
  }
}

class BackgroundContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            color: Colors.green[500],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        icon: Icon(Icons.home, color: Colors.white),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 35.0, 0),
                      child: Image.asset('lib/assets/logo.png', height: 125, width: 125, alignment: Alignment.topRight),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

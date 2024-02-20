import 'package:flutter/material.dart';
import 'package:life_saver/Pages/home.dart';
import 'package:life_saver/login_auth/firebase_auth/auth.dart';
import 'package:life_saver/shared/profile_editor.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,233,233,231),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            BackgroundContainer(),
            Positioned(
              top: 130,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
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
                            // backgroundImage: NetworkImage('https://i.imgur.com/jSS8P2Z.jpg'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildInfoColumn('Height', 'XX CM'),
                        buildInfoColumn('Weight', 'XX Kg'),
                        buildInfoColumn('Blood Group', 'X+'),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Divider(),
                    SizedBox(height: 12.0),
                    buildListTile('Name', 'Neethu P Sabu'),
                    buildListTile('Phone No.', '+91 9876543210'),
                    buildListTile('Address', '123 Main Street, Victoria.'),
                    buildListTile('Urgent Contact', 'XXXXXX'),
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
    );
  }

  Widget buildInfoColumn(String title, String value) {
    return Column(
      children: <Widget>[
        Text(title),
        SizedBox(height: 6.0),
        Text(value),
      ],
    );
  }

  Widget buildListTile(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Text(value),
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
            height: 40,
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
                // Text(
                //   'Profile',
                //   style: TextStyle(
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //   ),
                // ),
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

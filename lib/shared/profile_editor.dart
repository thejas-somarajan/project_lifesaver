import 'package:flutter/material.dart';
import 'package:life_saver/Pages/profile.dart';


class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          },
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildImage(),
                SizedBox(height: 10.0),
                Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          buildTextField('Name'),
                          SizedBox(height: 8.0),
                          buildTextField('Phone No'),
                          SizedBox(height: 8.0),
                          buildTextField('Address'),
                          SizedBox(height: 8.0),
                          buildTextField('Urgent Contact'),
                          SizedBox(height: 8.0),
                          buildTextField('Height'),
                          SizedBox(height: 8.0),
                          buildTextField('Weight'),
                          SizedBox(height: 8.0),
                          buildTextField('Blood Group'),
                        ],
                      ),
                    )
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Save Updates',
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 40.0,
          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
        ),
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {},
          color: Colors.black,
        ),
      ],
    );
  }



  Widget buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          labelText: label,
          labelStyle: TextStyle(fontSize: 12),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

}


import 'package:flutter/material.dart';
import 'package:life_saver/Database/firestore.dart';
import 'package:life_saver/Pages/profile.dart';


class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {

  Map<String,dynamic> profileData = {};

  final GlobalKey<FormState> _profileformKey = GlobalKey<FormState>();




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
              MaterialPageRoute(builder: (context) => Profile(selectedIndex: 2)),
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
            child: Form(
              key: _profileformKey,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildImage(),
                  SizedBox(height: 10.0),
                  Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                          child:Column(
                            children: [
                              Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                labelText: 'Name',
                                labelStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  // You can add validation logic here if needed
                                  if (value == null || value.isEmpty) {
                                    return 'Name is required';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  // Update the profileData when the value changes
                                  profileData['name'] = value;
                                },
                              ),
                            ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: 'Phone Number',
                                    labelStyle: TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    // You can add validation logic here if needed
                                    if (value == null || value.isEmpty) {
                                      return 'Phone Number is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    // Update the profileData when the value changes
                                    profileData['phone_no'] = value;
                                  },
                                ),
                                ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: 'Address',
                                    labelStyle: TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    // You can add validation logic here if needed
                                    if (value == null || value.isEmpty) {
                                      return 'Address is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    // Update the profileData when the value changes
                                    profileData['address'] = value;
                                  },
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: 'Urgent Contact',
                                    labelStyle: TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    // You can add validation logic here if needed
                                    if (value == null || value.isEmpty) {
                                      return 'Urgent Contact is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    // Update the profileData when the value changes
                                    profileData['urg_contact'] = value;
                                  },
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: 'Age',
                                    labelStyle: TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    // You can add validation logic here if needed
                                    if (value == null || value.isEmpty) {
                                      return 'Age is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    // Update the profileData when the value changes
                                    profileData['age'] = value;
                                  },
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: 'Height',
                                    labelStyle: TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    // You can add validation logic here if needed
                                    if (value == null || value.isEmpty) {
                                      return 'Height is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    // Update the profileData when the value changes
                                    profileData['height'] = value;
                                  },
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: 'Weight',
                                    labelStyle: TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    // You can add validation logic here if needed
                                    if (value == null || value.isEmpty) {
                                      return 'Weight is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    // Update the profileData when the value changes
                                    profileData['weight'] = value;
                                  },
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: 'Blood Group',
                                    labelStyle: TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    // You can add validation logic here if needed
                                    if (value == null || value.isEmpty) {
                                      return 'Blood Group is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    // Update the profileData when the value changes
                                    profileData['blood'] = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      if (_profileformKey.currentState!.validate()) {
                          _profileformKey.currentState!.save();
                          //Userid_call();
                          print(profileData);
                          ProfileService().updateUserData(profileData);
                        } else {
                          // Handle sign-in failure (e.g., display error message)
                          print( 'Sign-in failed. Please try again.');
                        }
                      },
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

}


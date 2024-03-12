import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:life_saver/ml_implementation/ml_file.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Sms_Sender {

  Map<String, dynamic> userData = {};

  var name;
  var age;
  var blood_gp;
  var weight;
  var height;
  var phone;

  Future<int> profileSnatcher() async {
    final CollectionReference profileDetails = FirebaseFirestore.instance.collection('profile');
    final currentUser = FirebaseAuth.instance.currentUser;
    final String uid;
    if (currentUser != null) {
      uid = currentUser.uid;
      final docSnapshot = await profileDetails.doc(uid).get();

      userData = (docSnapshot.data() as Map<String, dynamic>);

    }

    print(userData);
    name = userData['name'];
    age = userData['age'];
    blood_gp = userData['blood_group'];
    weight = userData['weight'];
    height = userData['height'];
    phone = userData['phone'];

    return 0;
  }

  void sendLocationViaSMS(List<double>  row, int stage) async {
      int counter = await profileSnatcher();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (position != null && counter == 0) {
        final TwilioFlutter twilioFlutter = TwilioFlutter(
          accountSid: 'AC92c272072cced50fffd18799fb511dae', // replace with Account SID
          authToken: '05657fc202a4ffd6aa08cb3a3d6fb579', // replace with Auth Token
          twilioNumber: '+19783841755', // replace with Twilio Number (With country code)
        );

        String messageBody = '\nEmergency\n';
        messageBody += '\nCase: Hemorrhage\n';
        messageBody += 'Stage: ${stage}\n';
        messageBody += 'Name: ${name}\n';
        messageBody += 'Age: ${age}\n';
        messageBody += 'Height: ${height}\n';
        messageBody += 'Weight: ${weight}\n';
        messageBody += 'Weight: ${blood_gp}\n';
        messageBody += 'Phone: ${phone}\n';
        messageBody += '\n';
        messageBody += 'Heart Rate: ${row[0]}\n';
        messageBody += 'Temperature: ${row[5]}\n';
        messageBody += 'Oxygen: ${row[2]}%\n';
        messageBody += 'Eda: ${row[1]}%\n';
        messageBody += 'Oxygen: ${row[4]}%\n';
        messageBody += '\n';
        messageBody += 'Current Location - Latitude: ${position.latitude}, Longitude: ${position.longitude} \n';


        await twilioFlutter.sendSMS(
          toNumber: '+91 6238637381', // replace with Recipient's Mobile Number (With country code)
          messageBody: messageBody,
        );

        print('Location sent via SMS successfully');
      } else {
        print('Unable to fetch current location');
      }

  }


}
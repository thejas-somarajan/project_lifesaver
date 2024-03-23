import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_saver/shared/stream_function.dart';
import 'package:life_saver/shared/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfileService {
  final CollectionReference _profileDetails =
  FirebaseFirestore.instance.collection('profile');

  final CollectionReference simulate =
  FirebaseFirestore.instance.collection('dataset');

  Future<void> updateUserData(Map<String, dynamic> profileData) async {
    try {
      final String? uid = await UserData().getCurrentUserId();
      if (uid != null) {
        // print('Userid ivde kiteela $uid');
        await _profileDetails.doc(uid).set({
          'name': profileData['name'],
          'phone': profileData['phone_no'],
          'address': profileData['address'],
          'urgent_contact': profileData['urg_contact'],
          'age': profileData['age'],
          'height': profileData['height'],
          'weight': profileData['weight'],
          'blood_group': profileData['blood'],
        }).then((_) async {
          print('User data updated successfully!');

          // Streams().pegausus();
        }).catchError((error) {
          print('Error updating user data: $error');
          // Handle the error, log it, or show an error message to the user.
        });
      } else {
        print('User ID is null.');
        // Handle the case where the user ID is null, possibly by showing an error message.
      }
    } catch (e) {
      print('Error updating user data: $e');
      // Handle the error, log it, or show an error message to the user.
    }
  }


  Stream<DocumentSnapshot<Object?>?>? getProfileDataStream() {
    final currentUser = FirebaseAuth.instance.currentUser;
    final String uid;
    if (currentUser != null) {
      uid = currentUser.uid;
      return _profileDetails.doc(uid).snapshots();
    }// final String? uid = UserData().getCurrentUserId();
    else {
      print('User is not found.');
      // Handle the case where the user ID is null, possibly by returning an empty stream.
      return null;
    }
  }

  // Future<void> getDataset(int i) async {
  //   try {
  //     String index = i.toString();
  //     final DocumentSnapshot snapshot = await simulate.doc(index).get();
  //     print(snapshot.data());
  //   } catch (e) {
  //     print('Error getting dataset: $e');
  //   }
  // }

}

class Simulator{

  final CollectionReference simulate =
  FirebaseFirestore.instance.collection('dataset');


  final CollectionReference normal =
  FirebaseFirestore.instance.collection('normal');

  static int i = 1;
  static int j = 0;

  int inCrementer(int n) {
    i =  n % 5;
    print('i: $i');
    return i;
  }

  Future<Map<String, double>?> getNormal() async {
    try {
      String index = i.toString();
      final DocumentSnapshot snapshot = await normal.doc(index).get();
      print(snapshot.data());
      Object? sender = snapshot.data();

      if (sender is Map<String, dynamic>) {
        Map<String, double> convertedData = {};
        sender.forEach((key, value) {
          if (value is double) {
            convertedData[key] = value;
          } else if (value is int) {
            convertedData[key] = value.toDouble();
          } else if (value is String) {
              convertedData[key] = double.parse(value);
          } else {
            print("Unsupported data type for key $key: ${value.runtimeType}");
          }
        });
        return convertedData;
      };

      // return snapshot.data();
      // return convertedData;
    } catch (e) {
      print('Error getting dataset: $e');
    }
  }


  Future<Map<String, double>?> getDataset() async {
    try {
      String index = j.toString();
      print('reached dataset');
      j++;
      final DocumentSnapshot snapshot = await simulate.doc(index).get();
      print(snapshot.data());

      Object? sender = snapshot.data();
      if (sender is Map<String, dynamic>) {
        Map<String, double> convertedData = {};
        sender.forEach((key, value) {
          if (value is double) {
            convertedData[key] = value;
          } else if (value is int) {
            convertedData[key] = value.toDouble();
          } else if (value is String) {
            convertedData[key] = double.parse(value);
          } else {
            print("Unsupported data type for key $key: ${value.runtimeType}");
          }
        });
        return convertedData;
      };


    } catch (e) {
      print('Error getting dataset: $e');
    }
  }
}



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_saver/shared/stream_function.dart';
import 'package:life_saver/shared/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfileService {
  final CollectionReference _profileDetails =
  FirebaseFirestore.instance.collection('profile');

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

}



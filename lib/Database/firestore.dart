import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_saver/Pages/profile.dart';
import 'package:life_saver/shared/user_data.dart';

class ProfileService {


  //collection reference
  final CollectionReference profile_details = FirebaseFirestore.instance.collection('profile');

  Future? updateUserData(Map profiledata) async {
    final String? uid = await UserData().getCurrentUserId();
    print('Userid ivde kiteela ${uid}');
    return await profile_details.doc(uid).set({
      'name': profiledata['name'],
      'phone': profiledata['phone_no'],
      'address': profiledata['address'],
      'urgent_contact': profiledata['urg_contact'],
      'age': profiledata['age'],
      'height': profiledata['height'],
      'weight': profiledata['weight'],
      'blood_group': profiledata['blood'],
    });
  }

  //get brew stream

  Stream<QuerySnapshot?> get brews {
    return profile_details.snapshots();
  }
}
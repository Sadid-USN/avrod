import 'package:cloud_firestore/cloud_firestore.dart';

class DtabaseService {
  final String? uid;
  DtabaseService({this.uid});

// reference for our collections
  final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  // update the userdata

  Future updateUserData(
    String fullName,
    String email,
  ) async {
    return await userCollectionRef.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  // saving userdata
  Future savingUserData(String fullName, String email) async {
    return await userCollectionRef.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollectionRef.where("email", isEqualTo: email).get();
    return snapshot;
  }
}

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

  // get user groups

  Future getUserGroups() async {
    var snapshot = userCollectionRef.doc(uid).snapshots();
    return snapshot;
  }

  //creating Group

  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    // update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollectionRef.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"]),
    });
  }

  // getting the chats
  Future getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  // Get Group member

  Future groupMembers(String groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  // Search

  Future searchGroupByName(String groupName) async {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  // function -> bool
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentRef = userCollectionRef.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentRef.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join/exit
  Future toggleGroupJoin(
      String groupName, String groupId, String userName) async {
    DocumentReference userReference = userCollectionRef.doc(uid);
    DocumentReference groupReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await userReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    // if user has our groups -> then remove then or also re join
    if (groups.contains("${groupId}_$groupName")) {
      await userReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessage) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessage);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessage["message"],
      "recentMessageSender": chatMessage["sender"],
      "recentMessageTime": chatMessage["time"].toString(),
    });
  }
}

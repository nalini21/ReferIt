//import 'package:flutter/material.dart';
// import 'dart:html';

import 'package:ReferIt/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final String uid;
  int rewUpd = 0;
  FirestoreService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  Future updateUserData(String id, String name, int reward) async {
    return await userCollection.doc(id).set({
      'name': name,
      'reward': reward,
    });
  }

  Future getRewardData(String uid) async {
    return await userCollection
        .where(FieldPath.documentId, isEqualTo: uid)
        .get()
        .then((document) {
      if (document.docs.isNotEmpty) {
        int rew = document.docs.single.data().values.first;
        print(rew);
        return rew.toString();
      }
    });
  }

  Future getReward(String refferal) async {
    return await userCollection
        .where(FieldPath.documentId, isEqualTo: refferal)
        .get()
        .then((document) {
      if (document.docs.isNotEmpty) {
        // print('got the reward value of the refferal person');
        rewUpd = document.docs.single.data().values.first;
        var name = document.docs.single.data().values.last;
        rewUpd += 20;
        updateUserData(refferal, name, rewUpd);
      } else {
        updateUserData(uid, 'someone', 0);
      }
    });
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: snapshot.id,
      name: snapshot['name'],
      reward: snapshot['reward'],
    );
  }

  // Stream<QuerySnapshot> get users {
  //   return userCollection.snapshots();
  // }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}

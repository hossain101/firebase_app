import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/brew.dart';
import 'package:firebase_app/models/user1.dart';
import 'package:firebase_app/models/user1.dart';


class DatabaseService{
  final String? uid;
  DatabaseService({ this.uid});

  //collection reference

  final CollectionReference brewCollection= FirebaseFirestore.instance.collection('brews');

  Future updateUserData (String sugars,String name, int strength) async {
    return await brewCollection.doc(uid).set({

      'sugars':sugars,
      'name':name,
      'strength':strength,

    });

  }

  //brew list from snapshot

  List<Brew?> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.get("name")??"",
        sugar: doc.get("sugar")??"",
        strength: doc.get("strength")??0,

      );

    }).toList();
  }

  //user data from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid: uid!,
        name: (snapshot.data() as DocumentSnapshot)['name'],
        sugars: (snapshot.data() as DocumentSnapshot)['sugar'],
        strength: (snapshot.data() as DocumentSnapshot)['strength']
    );
  }

  //get brews stream
Stream<List<Brew?>?> get brews{

    return brewCollection.snapshots().map(_brewListFromSnapshot);
}


// get user doc stream

Stream<UserData?> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);

}

}
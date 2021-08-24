import 'package:firebase_app/models/user1.dart';
import 'package:firebase_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  
  //create user obj based on Firebase User
  User1? _userFromFirebaseUser(User user){
    return user!=null? User1(uid: user.uid):null;
  }

  // auth chang user stream

  Stream<User1?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user!));
  }


  // sign in anonymously
  Future signInAnon() async{
    try{
      UserCredential result= await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;

    }
  }


 //sign in with email and password
  Future signInWithEmailAndPassword(String email,String password)async{
    try{
      UserCredential result =await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);


    }catch(e){
      print(e.toString());
      return null;
    }

  }

 //register with email and password
  Future registerWithEmailAndPassword(String email,String password)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //create a new document for user with the uid
      await DatabaseService(uid:user!.uid).updateUserData("0", "new crew member", 100);

      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;

    }


  }

 // sign out

Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}
}
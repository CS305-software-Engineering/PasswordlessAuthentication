import 'package:firebase_auth/firebase_auth.dart';

import 'package:myapp/models/user.dart';



class AuthService{


  final FirebaseAuth _auth = FirebaseAuth.instance;


  //create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){

    return user != null ? User(uid: user.uid) : null;

  }

  //auth change user streaam

  Stream<User> get user{
    return _auth.onAuthStateChanged

        .map(_userFromFirebaseUser);
  }


}

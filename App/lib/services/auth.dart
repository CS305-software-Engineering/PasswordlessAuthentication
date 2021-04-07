import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';

import 'package:myapp/screens/home/home.dart';


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



// login with moblie number


  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();



  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          return _userFromFirebaseUser(user);

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },

        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {

                return AlertDialog(

                  title: Text("Enter your OTP-"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.lightBlueAccent,
                      onPressed: () async {
                        Navigator.pop(context, true);
                        final code = _codeController.text.trim();
                        AuthCredential credential = PhoneAuthProvider
                            .getCredential(
                            verificationId: verificationId, smsCode: code);

                        AuthResult result = await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        return _userFromFirebaseUser(user);

                      },
                    )
                  ],
                );
              }
          ).then((exit){

            if(exit == null) return ;

            if (exit) {

            }else{

            }

          });
        },
        codeAutoRetrievalTimeout: null

    );
  }




  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }


}

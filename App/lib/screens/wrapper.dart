import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/screens/authenticate/authenticate.dart';


import 'package:myapp/screens/home/home.dart';
import 'package:myapp/screens/profile.dart';
import 'package:myapp/screens/setup_pin.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   final user = Provider.of<User>(context);
   //final profile = Provider.of<profileData>(context);

   // return home or authenticate widget

   // bool showSignIn = true;

    if(user == null){
      return Authenticate();
    } else {
      return Profile();

    }
  }
}
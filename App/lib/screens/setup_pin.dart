import 'package:flutter/cupertino.dart';
import 'package:myapp/screens/home/home.dart';

import 'package:myapp/screens/profile.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
var app_Pin;

class PinSetup extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Set up your Pin"),
        automaticallyImplyLeading: false,
      ),

      body: Container(

        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: PinEntryTextField(
            showFieldAsBox: true,
            isTextObscure: true,
            onSubmit: (String pin){

              app_Pin=pin;
              _save();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );

              //return homePage();



            }, // end onSubmit
          ), // end PinEntryTextField()
        ), // end Padding()
      ), // end Container()
    );
  }
}
_save() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'password';
  final value = app_Pin;
  prefs.setString(key, value);
  //print('saved $value');
}
import 'package:flutter/material.dart';
import 'package:myapp/screens/home/home.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'setup_pin.dart';

import 'package:shared_preferences/shared_preferences.dart';


class PinVerify extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Enter your pin"),
      ),
      body: Container(

        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: PinEntryTextField(
            lastPin: app_Pin,
            showFieldAsBox: true,
            isTextObscure: true,
            onSubmit: (String pin) async{
              final prefs = await SharedPreferences.getInstance();
              final key = 'password';
              final value = prefs.getString(key) ?? 'empty';
              app_Pin=value;
              if(app_Pin==pin){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );


                //return homePage();

              }
              else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Pin"),
                        content: Text('Wrong pin entered'),
                      );
                    }
                );//end showDialog()
              }

            }, // end onSubmit
          ), // end PinEntryTextField()
        ), // end Padding()
      ), // end Container()
    );
  }

}
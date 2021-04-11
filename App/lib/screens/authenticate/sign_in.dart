import 'package:flutter/material.dart';

import 'package:myapp/screens/home/home.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/shared/constants.dart';
import 'package:myapp/shared/loading.dart';

class SignIn extends StatefulWidget {


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {



  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  bool loading = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(

        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(

          title: Text(
              '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tUSER  LOGIN',
            style: TextStyle(color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 20.0 ),
          ),

          backgroundColor: Colors.lightBlue,
          elevation: 0.0,


        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Container(
            //padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
               // mainAxisAlignment: MainAxisAlignment.center,


                children: <Widget>[

                  //Text("Passwordless Authentication", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

                  SizedBox(height: 20.0),

                  Text(
                      'Enter your phone number',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 15.0),
                  ),

                  SizedBox(height: 20.0),

                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Moblie number'),
                    controller: _phoneController,
                  ),

                  SizedBox(height: 20.0),
                  RaisedButton(
                    //width: double.infinity,
                    color: Colors.lightBlueAccent,
                    child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),

                    // padding: EdgeInsets.all(16),
                    onPressed: () async {
                      final phone = _phoneController.text.trim();

                     setState(() => loading = true);

                       await _auth.loginUser(phone, context);

                      loading = false;


                    },


                  ),


                ],

              ),
            ),
          ),
        )
    );
  }
}

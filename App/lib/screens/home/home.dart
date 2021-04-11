
import 'package:flutter/material.dart';

import 'package:myapp/screens/home/scanner.dart';

import 'package:myapp/services/auth.dart';



class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
            'HOME',
          style: TextStyle(color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 20.0),
        ),

        backgroundColor: Colors.lightBlue,
        elevation: 0.0,
        actions:<Widget> [

          FlatButton.icon(
            icon: Icon(Icons.qr_code_scanner_sharp),
            label: Text('Web Login'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Scanner()));
            },
          ),


          FlatButton.icon(
            icon: Icon(Icons.logout),
            label: Text('Logout'),
            onPressed: () async{
              await _auth.signOut();
            },
          ),



        ],

      ),
      //body: ReqList(),
    );
  }
}

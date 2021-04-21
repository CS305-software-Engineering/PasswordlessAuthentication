
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/userdata.dart';

import 'package:myapp/screens/home/scanner.dart';
import 'package:myapp/screens/home/user_form.dart';

import 'package:myapp/services/auth.dart';

import 'package:myapp/services/database.dart';

import 'package:provider/provider.dart';
import 'package:myapp/models/userdata.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

      void _showUserPanel(){
        showModalBottomSheet(context: context, builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
            child: UserForm(),
          );
        });
      }

    return StreamProvider<List<UserData>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text(
              'HOME',
            style: TextStyle(color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 15.0),
          ),

         automaticallyImplyLeading: false,
          backgroundColor: Colors.lightBlue,
          elevation: 0.0,
          actions:<Widget> [

            FlatButton.icon(
              icon: Icon(Icons.qr_code_scanner_sharp),
              label: Text('Web'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Scanner()));
              },
            ),

            FlatButton.icon(
              icon: Icon(Icons.person_outline),
              label: Text('User'),
              onPressed: () => _showUserPanel(),
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
      ),
    );
  }
}

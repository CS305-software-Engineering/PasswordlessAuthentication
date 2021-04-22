

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/models/userdata.dart';

import 'package:myapp/screens/home/scanner.dart';
import 'package:myapp/screens/home/session.dart';
import 'package:myapp/screens/home/user_form.dart';

import 'package:myapp/services/auth.dart';

import 'package:myapp/services/database.dart';

import 'package:provider/provider.dart';
import 'package:myapp/models/userdata.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override

  Future<void> Weblogout(String name) async {

    Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};
      var url = Uri.parse('https://passwdless-auth.herokuapp.com/logout');
      var response = await http.post(url,headers:headers, body: "username=" + name);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

  }


  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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
       // body: Session() ,
          body: StreamBuilder<profileData>(
            stream: DatabaseService(uid: user.uid).ProfileData,
            builder: (context, snapshot) {
              profileData ProflieData = snapshot.data;
              return Builder(builder: (BuildContext context) {
                return Container(
                    alignment: Alignment.center,
                    child: Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          ElevatedButton(
                              onPressed: () => Weblogout(ProflieData.name),
                              child: Text('Web Logout')),

                          //Text('Scan result : ',
                              //style: TextStyle(fontSize: 20))
                        ]));
              }
              );
            }
          )
      )
    );


  }
}

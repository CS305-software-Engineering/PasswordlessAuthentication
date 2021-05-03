
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/models/userdata.dart';
import 'package:myapp/screens/authenticate/sign_in.dart';
import 'package:myapp/screens/home/scanner.dart';
import 'package:myapp/screens/home/user_form.dart';

import 'package:myapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:myapp/screens/home/session.dart';


class Home extends StatelessWidget {


  @override



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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Home'.toUpperCase(),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
          elevation: 0.0,

        ),

        drawer: Drawer(
          child: Row(
            children: [

              Expanded(
                child: StreamBuilder<profileData>(
                  stream: DatabaseService(uid: user.uid).ProfileData,
                  builder: (context, snapshot) {
                    profileData ProflieData = snapshot.data;
                    String Name;
                    Name = ProflieData.name;
                    return Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          UserAccountsDrawerHeader(accountName: Text(Name),
                            //accountEmail: Text("abhishekm977@gmail.com"),
                            currentAccountPicture: CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Text(
                                Name[0],
                                style: TextStyle(fontSize: 40.0),
                              ),
                            ),  ),
                          //Spacer(),
                         // Divider(),

                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.lightBlue,
                              child: Icon(
                                Icons.home_outlined,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                            title: Text("Home"),
                            onTap: () { Navigator.pop(context);  },
                          ),
                          Divider(),

                          ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.lightBlue,
                                child: Icon(
                                  Icons.qr_code_scanner_sharp,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                              title: Text("Web login Scanner"),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Scanner()));
                              }
                          ),

                          Divider(),

                          ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.lightBlue,
                                child: Icon(
                                  Icons.laptop_chromebook_rounded,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                              title: Text("Web Sessions"),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Session()));
                              }
                          ),

                          Divider(),

                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.lightBlue,
                              child: Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                            title: Text("Settings"),
                            onTap: () { _showUserPanel();},
                          ),

                          Divider(),

                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.lightBlue,
                              child: Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                            title: Text("Logout"),
                            onTap: () async{
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignIn()),
                                      (route) => false);
                              }
                          ),
                          Divider(),


                          Spacer(),

                        ]

                      ),


                    );
                  }
                ),

                  ),
            ],
          ),
            ),



      )
    );

  }
}

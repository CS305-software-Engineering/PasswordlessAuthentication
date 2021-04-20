

import 'package:flutter/material.dart';
import 'package:myapp/models/userdata.dart';
import 'package:myapp/screens/home/scanner.dart';
import 'package:myapp/screens/home/user_form.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/services/database.dart';
import 'package:provider/provider.dart';


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
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
          elevation: 0.0,

        ),

        drawer: Drawer(
          child: Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[

                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.lightBlue,
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    title: Text("User Profile"),
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
                        await _auth.signOut();
                      }
                  )]

                  ),

              ),
            ),
          ),

        body: Container(
          margin: EdgeInsets.all(10),

          height: 150,

          child: Row(
            children: <Widget>[
              // First
              Expanded(
                child: GestureDetector(
                  child: Container(
                      margin: EdgeInsets.only(right: 5),

                      decoration: BoxDecoration(
                          color: Colors.lightBlue,

                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.qr_code_scanner_sharp,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Motors',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                        ],
                      )
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Scanner()));
                  },
                ),
              ),



            ],
          ),
        ),
        ),
        //body: ReqList(),
      );

  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/screens/home/home.dart';
import 'package:myapp/screens/verify_pin.dart';
import 'package:myapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:myapp/screens/setup_pin.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  final CollectionReference userCollection = Firestore.instance.collection('userInfo');


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);


    return StreamBuilder<profileData>(
        stream: DatabaseService(uid: user.uid).ProfileData,
        builder: (context, snapshot) {

    if(snapshot.hasData){

      return PinVerify();

    } else {
            profileData ProflieData = snapshot.data;
            return Scaffold(
              key: _formKey,
              appBar: AppBar(
                title: Text(
                  'USER PROFILE',

                ),
                centerTitle: true,
                backgroundColor: Colors.lightBlue,
                elevation: 0.0,

              ),


              body: Container(
                child: ListView(
                  children: <Widget>[

                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 62),
                      child: Column(
                        children: <Widget>[
                          Spacer(),

                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            padding:
                            EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(color: Colors.black12, blurRadius: 5)
                                ]),
                            child: TextField(
                              onChanged: (val) { setState(() => _currentName =val);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,

                                hintText: 'enter your name',
                              ),

                            ),
                          ),


                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () async {

                              await userCollection.document(user.uid).setData({

                                'name' : _currentName,



                              });
                              //return Wrapper();
                              //Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PinSetup()));
                              //return Home();

                            },
                            child: Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.lightBlue,
                                      Colors.lightBlue,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(50))),
                              child: Center(
                                child: Text(
                                  'Next'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),


                  ],
                ),
              ),
              );
        }



        }
    );
  }

}

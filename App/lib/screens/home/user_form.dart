import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/services/database.dart';
import 'package:myapp/shared/loading.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<profileData>(
      stream: DatabaseService(uid: user.uid).ProfileData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
         profileData ProflieData = snapshot.data;
          return Form(
            key: _formKey,



              child: ListView(
                children: <Widget>[

                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 62),
                    child: Column(
                      children: <Widget>[
                        //Spacer(),
                        SizedBox(
                          child: Text(
                            'Enter your Name\n',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
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
                          child: TextFormField(
                            initialValue: ProflieData.name,
                            onChanged: (val) { setState(() => _currentName =val);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,

                              hintText: 'enter your name',
                              icon: Icon(
                                Icons.person_outline,
                                color: Colors.lightBlue,
                              ),
                            ),


                          ),
                        ),


                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {

                            if(_formKey.currentState.validate()){
                              await DatabaseService(uid: user.uid).updateUserData(
                                _currentName ?? ProflieData.name
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width / 3.0,
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
                                'Save'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                     // Spacer(flex: 3,),
                      ],
                    ),
                  )


                ],
              ),


          );

        } else {

          return Loading();
        }

      }
    );
  }
}

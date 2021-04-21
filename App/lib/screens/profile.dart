import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/screens/home/home.dart';
import 'package:myapp/screens/setup_pin.dart';
import 'package:myapp/screens/verify_pin.dart';
import 'package:myapp/screens/wrapper.dart';
import 'package:myapp/services/database.dart';
import 'package:myapp/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:myapp/services/auth.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;

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
                  style: TextStyle(color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 20.0),
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
                  SizedBox(height: 20.0),

                  Text(
                    'Name',
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 15.0),
                  ),

                  SizedBox(height: 20.0),
                  TextFormField(
                   // initialValue: ProflieData.name ,
                    decoration: textInputDecoration.copyWith(hintText: 'Your Name'),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName =val),
                  ),
                  RaisedButton(
                      color: Colors.blueGrey,
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async{

                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? ProflieData.name
                          );
                          //return Wrapper();
                          //Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PinSetup()));
                      //  return PinSetup();

                      }
                  ),
          ],

          ),
          ),
          ),
             ),
              );
        };



        }
    );
  }

}

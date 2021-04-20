import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/services/database.dart';
import 'package:myapp/shared/constants.dart';
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
            child: Column(
              children: <Widget>[
                Text(
                  'User Profile',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),

                SizedBox(height: 20.0),

                Text(
                  'Name',
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 15.0),
                ),

                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: ProflieData.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Your Name'),
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName =val),
                ),
                RaisedButton(
                    color: Colors.blueGrey,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentName ?? ProflieData.name
                        );
                        Navigator.pop(context);
                      }
                    }
                ),
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

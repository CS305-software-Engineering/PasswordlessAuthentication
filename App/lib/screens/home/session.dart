import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/services/database.dart';
import 'package:provider/provider.dart';

class Session extends StatefulWidget {
  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<profileData>(
        stream: DatabaseService(uid: user.uid).ProfileData,
        builder: (context, snapshot) {

            profileData ProflieData = snapshot.data;
            return Padding(
              padding: EdgeInsets.only(top: 8.0),
              key: _formKey,
              child: Card(
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  title: Text(ProflieData.status),
                  subtitle: Text( ProflieData.login_time ),
                ),
              ),
            );



        }
    );

    //return Container();
  }
}

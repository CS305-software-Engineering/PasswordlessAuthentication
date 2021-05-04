import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Session extends StatefulWidget {
  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {

  final _formKey = GlobalKey<FormState>();

  @override

  Future<void> Weblogout1(String uid) async {

    Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};
    var url = Uri.parse('https://passwdless-auth.herokuapp.com/logout/remote');
    var response = await http.post(url,headers:headers, body: "userId=" + uid);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

  }

  Future<void> Weblogout2(String uid) async {

    Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};
    var url = Uri.parse('https://passwdless-auth.herokuapp.com/logout/ws/remote');
    var response = await http.post(url,headers:headers, body: "userId=" + uid);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

  }

  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<profileData>(
      stream: DatabaseService(uid: user.uid).ProfileData,
      builder: (context, snapshot) {
        profileData ProflieData = snapshot.data;
        return Scaffold(

          appBar: AppBar(
            title: Text(
              'Sessions'.toUpperCase(),
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.lightBlue,
            elevation: 0.0,

          ),
            body: Center(

              child: Column(
                children: <Widget> [

                  new Expanded(
                     child: new StreamBuilder<profileData>(
                        stream: DatabaseService(uid: user.uid).ProfileData,
                        builder: (context, snapshot) {
                          profileData ProflieData = snapshot.data;
                          if(snapshot.data == null) return CircularProgressIndicator();
                          return Builder(builder: (BuildContext context) {
                            return ListView.builder(
                                itemCount: 1,
                                itemBuilder:(BuildContext context,int index){
                              return ListTile(
                                  leading: Icon(Icons.laptop_chromebook_rounded),
                                  trailing: Text(ProflieData.status,
                                    style: TextStyle(
                                        color: Colors.green,fontSize: 15),),
                                  title:Text('\n${ProflieData.platform}\n'),
                                subtitle: Text('Login Time - ${ProflieData.login_time}\nLogout Time- ${ProflieData.logout_time}'),

                              );
                            });

                          }
                          );
                        }
                  ),

                   ),

                  InkWell(
                    onTap: ()  => Weblogout1(ProflieData.uid),
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.5,
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
                          'Web logout 1'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  Spacer(),

                  InkWell(
                    onTap: ()  => Weblogout2(ProflieData.uid),
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.5,
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
                          'Web logout 2'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  Spacer(),




                ],
              ),
            )
          
          
          
        );
      }
    );

    //return Container();
  }
}
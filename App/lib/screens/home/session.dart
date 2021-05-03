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

  Future<void> Weblogout(String name) async {

    Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};
    var url = Uri.parse('https://passwdless-auth.herokuapp.com/logout');
    var response = await http.post(url,headers:headers, body: "username=" + name);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

  }


  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<profileData>(
      stream: null,
      builder: (context, snapshot) {
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
            body: StreamBuilder<profileData>(
                stream: DatabaseService(uid: user.uid).ProfileData,
                builder: (context, snapshot) {
                  profileData ProflieData = snapshot.data;
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
                        subtitle: Text('Login - ${ProflieData.login_time}\nLogout - ${ProflieData.logout_time}'),
                      );
                    });
                    return Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 62),
                        child: Column(
                            children: <Widget>[
                              Spacer(),
                              InkWell(
                                onTap: ()  => Weblogout(ProflieData.name),
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
                                      'Web logout'.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),

                              //Text('Scan result : ',
                              //style: TextStyle(fontSize: 20))

                            ]
                        )
                    );
                  }
                  );
                }
            )
          
          
          
        );
      }
    );

    //return Container();
  }
}
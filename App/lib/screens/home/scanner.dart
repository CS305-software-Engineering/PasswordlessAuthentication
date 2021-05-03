import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/services/database.dart';
import 'package:provider/provider.dart';



class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }


  Future<void> scanQR(String uid,String name) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);


      var url = Uri.parse('https://passwdless-auth.herokuapp.com/login');
      var response = await http.post(url, body: {'qr_id': barcodeScanRes ,'uid':uid,'username': name});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<profileData>(
      stream: DatabaseService(uid: user.uid).ProfileData,
      builder: (context, snapshot) {
        profileData ProflieData = snapshot.data;
        return MaterialApp(
            home: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: const Text(
                  'Web Login',
                  style: TextStyle(color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 20.0),
                ),
                  backgroundColor: Colors.lightBlue,
                  elevation: 0.0,
                  centerTitle: true,
                  automaticallyImplyLeading: true,
                ),
                body: Builder(builder: (BuildContext context) {
                  return Container(
                      alignment: Alignment.center,
                      child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            InkWell(
                              onTap: ()  => scanQR(ProflieData.uid,ProflieData.name),
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
                                    'Scan Your QR code'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),

                            Text('Scan result : ${ProflieData.status}\n',
                                style: TextStyle(fontSize: 20))
                          ]));
                })));
      }
    );
  }
}
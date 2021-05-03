import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/models/userdata.dart';



class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  //collection ref

  final CollectionReference userCollection = Firestore.instance.collection('userInfo');


  Future updateUserData(String name) async {

    return await userCollection.document(uid).updateData({

      'name' : name,



    });

  }

  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){

      return UserData(
        name: doc.data['name'] ?? '-',
        login_time: doc.data['Login Time'] ?? '-',
        logout_time: doc.data['Logout Time'] ?? '-',
        status: doc.data['Status'] ?? '-',
      );

    }).toList();

  }

  profileData _profileDataFromSnapshot(DocumentSnapshot snapshot){
    return profileData(
        uid: uid,
        name: snapshot.data['name'] ?? '-',
        login_time: snapshot.data['Login Time'] ?? '-',
        logout_time: snapshot.data['Logout Time'] ?? '-',
        status: snapshot.data['Status'] ?? '-',
        platform: snapshot.data['platform'] ?? '-'

    );
  }

  Stream<List<UserData>> get users{

    return userCollection.snapshots()
        .map(_userListFromSnapshot);

  }

  Stream<profileData> get ProfileData {
    return userCollection.document(uid).snapshots()
        .map(_profileDataFromSnapshot);
  }
}
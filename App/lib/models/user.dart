class User{

  final String uid;



  User({this.uid});


}

class profileData {

  final String uid;
  final String name;
  final String login_time;
  final String logout_time;
  final String status;
  final String platform;

  profileData({this.uid,this.name,this.login_time,this.logout_time,this.status,this.platform});
}
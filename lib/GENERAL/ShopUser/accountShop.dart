import '../Tool/Time.dart';

class accountShop {
  String phoneNum;
  String id;
  String name;
  int status;
  Time createTime;
  String location;
  String avatarID;
  String password;

  accountShop({required this.phoneNum, required this.location, required this.name, required this.id, required this.status, required this.avatarID, required this.createTime, required this.password});

  Map<dynamic, dynamic> toJson() => {
    'phoneNum': phoneNum,
    'location': location,
    'id' : id,
    'name' : name,
    'status' : status,
    'createTime' : createTime.toJson(),
    'avatarID' : avatarID,
    'password' : password
  };

  factory accountShop.fromJson(Map<dynamic, dynamic> json) {
    return accountShop(
        phoneNum: json['phoneNum'].toString(),
        location: json['location'].toString(),
        name: json['name'].toString(),
        id: json['id'].toString(),
        status: int.parse(json['status'].toString()),
        avatarID: json['avatarID'].toString(),
        createTime: Time.fromJson(json['createTime']),
        password: json['password'].toString(),
    );
  }
}
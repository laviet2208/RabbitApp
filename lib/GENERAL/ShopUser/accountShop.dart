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
  String closeTime;
  String openTime;

  accountShop({required this.openTime, required this.closeTime,required this.phoneNum, required this.location, required this.name, required this.id, required this.status, required this.avatarID, required this.createTime, required this.password});

  Map<dynamic, dynamic> toJson() => {
    'phoneNum': phoneNum,
    'location': location,
    'id' : id,
    'name' : name,
    'status' : status,
    'createTime' : createTime.toJson(),
    'avatarID' : avatarID,
    'password' : password,
    'closeTime' : closeTime,
    'openTime' : openTime
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
      closeTime: json['closeTime'].toString(),
      openTime: json['openTime'].toString(),
    );
  }
}
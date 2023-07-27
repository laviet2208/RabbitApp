import 'package:rabbitshipping/GENERAL/Product/Voucher.dart';
import 'package:rabbitshipping/GENERAL/Tool/Time.dart';

import 'accountLocation.dart';

class accountNormal {
  String phoneNum;
  String id;
  String name;
  int type;
  int status;
  Time createTime;
  List<String> cartList = [];
  List<accountLocation> locationHis = [];
  List<Voucher> voucherList = [];
  String avatarID;

  accountNormal({required this.id, required this.avatarID, required this.createTime, required this.status, required this.name, required this.phoneNum, required this.type, required this.cartList, required this.locationHis, required this.voucherList});

  Map<dynamic, dynamic> toJson() => {
    'phoneNum': phoneNum,
    'locationHis': locationHis.map((e) => e.toJson()).toList(),
    'id' : id,
    'name' : name,
    'status' : status,
    'createTime' : createTime.toJson(),
    'avatarID' : avatarID,
    'type' : type,
    'cartList' : cartList,
    'voucherList' : voucherList.map((Voucher) => Voucher.toJson()).toList()
  };

  factory accountNormal.fromJson(Map<dynamic, dynamic> json) {
    List<String> cartlist = [];
    List<accountLocation> locationHis = [];
    List<Voucher> voucherList = [];

    if (json["cartList"] != null) {
      for (final result in json["cartList"]) {
        cartlist.add(result.toString());
      }
    }

    if (json["voucherList"] != null) {
      for (final result in json["voucherList"]) {
        voucherList.add(Voucher.fromJson(result));
      }
    }
    
    return accountNormal(
        id: json['id'].toString(),
        avatarID: json['avatarID'].toString(),
        createTime: Time.fromJson(json['createTime']),
        status: int.parse(json['status'].toString()),
        name: json['name'].toString(),
        phoneNum: json['phoneNum'].toString(),
        type: int.parse(json['type'].toString()),
        cartList: cartlist,
        locationHis: [],
        voucherList: voucherList
    );
  }

}
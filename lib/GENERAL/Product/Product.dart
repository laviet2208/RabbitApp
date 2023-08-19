import 'package:rabbitshipping/GENERAL/ShopUser/accountShop.dart';

import 'Evaluate.dart';


class Product {
  String id;
  String name;
  String content;
  double cost;
  List<String> imageList;
  List<Evaluate> evaluateList;
  accountShop owner;
  int type;
  String openTime;
  String closedTime;

  Product({required this.id, required this.name, required this.content, required this.owner, required this.cost, required this.evaluateList, required this.imageList, required this.type, required this.openTime, required this.closedTime});

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'content' : content,
    'cost' : cost,
    'owner' : owner.toJson(),
    'evaluateList': evaluateList.map((e) => e.toJson()).toList(),
    'imageList' : imageList,
    'type' : type,
    'openTime' : openTime,
    'closedTime' : closedTime
  };

  factory Product.fromJson(Map<dynamic, dynamic> json) {
    List<Evaluate> evalua = [];
    List<String> url = [];

    if (json["evaluateList"] != null) {
      for (final result in json["evaluateList"]) {
        evalua.add(Evaluate.fromJson(result));
      }
    }

    if (json["imageList"] != null) {
      for (final result in json["imageList"]) {
        url.add(result.toString());
      }
    }

    return Product(
        id: json['id'].toString(),
        name: json['name'].toString(),
        content: json['content'].toString(),
        owner: accountShop.fromJson(json['owner']),
        cost: double.parse(json['cost'].toString()),
        evaluateList: evalua,
        imageList: url,
        type: int.parse(json['type'].toString()),
        openTime: json['openTime'].toString(),
        closedTime: json['openTime'].toString()
    );
  }
}
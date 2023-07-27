import 'package:flutter/material.dart';
import 'package:rabbitshipping/GENERAL/NormalUser/accountLocation.dart';
import 'package:rabbitshipping/GENERAL/NormalUser/accountNormal.dart';
import 'package:rabbitshipping/GENERAL/Order/Receiver.dart';
import 'package:rabbitshipping/GENERAL/Order/item_details.dart';
import 'package:rabbitshipping/GENERAL/Product/Voucher.dart';
import 'package:rabbitshipping/GENERAL/Tool/Time.dart';

import '../GENERAL/Product/Product.dart';

final accountNormal currentAccount = accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, cartList: [], locationHis: [], voucherList: []);

//Các controllerTextbike
final startcontroller = TextEditingController();
final endcontroller = TextEditingController();


final accountLocation bikeGetLocation = accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA"); // điểm đón xe ôm
final accountLocation bikeSetLocation = accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA"); // điểm trả xe ôm

//người nhận
final Receiver currentReceiver = Receiver(location: accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA"), locationNote: 'NA', name: 'NA', phoneNum: 'NA', note: 'NA');
final item_details currentitemdetail = item_details(weight: -1, type: 'NA', codFee: -1);

//giỏ hàng
final List<Product> cartList = [];

//voucher đang chọn
final Voucher chosenvoucher = Voucher(id: 'NA', totalmoney: 0, mincost: 0);
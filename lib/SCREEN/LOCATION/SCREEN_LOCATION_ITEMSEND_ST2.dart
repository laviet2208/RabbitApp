import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rabbitshipping/GENERAL/Order/itemsendOrder.dart';
import 'package:rabbitshipping/GENERAL/Tool/Tool.dart';
import 'package:rabbitshipping/OTHER/Button/Buttontype1.dart';

import '../../FINAL/finalClass.dart';
import '../../GENERAL/NormalUser/accountLocation.dart';
import '../../GENERAL/NormalUser/accountNormal.dart';
import '../../GENERAL/Product/Voucher.dart';
import '../../GENERAL/Tool/Time.dart';
import '../FILL_INFOR/SCREENfillitemsendinfo.dart';
import '../FILL_INFOR/SCREENfillreceiverinfor.dart';
import '../INUSER/SCREEN_MAIN/SCREENmain.dart';
import '../VOUCHER/SCREENvoucherchosen.dart';
import 'SCREEN_LOCATION_ITEMSEND_ST1.dart';

class SCREENlocationitemsendst2 extends StatefulWidget {
  final double Distance;
  const SCREENlocationitemsendst2({Key? key, required this.Distance}) : super(key: key);

  @override
  State<SCREENlocationitemsendst2> createState() => _SCREENlocationitemsendst2State();
}

class _SCREENlocationitemsendst2State extends State<SCREENlocationitemsendst2> {
  String setlocation = "";
  String getlocation = "";
  Color receiverMancolor = Colors.blueAccent;
  Color inforordercolor = Colors.blueAccent;
  String receiverManText = 'Chọn người nhận hàng';
  String infororderText = 'Thêm thông tin hàng hóa';
  double cost = 0;

  bool bookingloading = false;
  bool voucherloading = false;

  int getCost(double distance) {
    int cost = 0;
    if (distance >= 2.0) {
      cost += 20000; // Giá cước cho 2km đầu tiên (10.000 VND/km * 2km)
      distance -= 2.0; // Trừ đi 2km đã tính giá cước
      cost = cost + ((distance - 2) * 5000).toInt();
    } else {
      cost += (distance * 10000).toInt(); // Giá cước cho khoảng cách dưới 2km
    }
    return cost;
  }

  Future<void> pushitemSendOrder(itemsendOrder itemsend) async {
    try {
// Khởi tạo kết nối đến Realtime Database
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

// Đẩy dữ liệu catchOrder lên mục catchOrder với khóa chính là id của catch
      await databaseRef.child('itemsendOrder').child(itemsend.id).set(itemsend.toJson());

      print('Đẩy Order thành công');
      setState(() {
        bookingloading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmain()));
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushVoucherdata(List<Voucher> list) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + currentAccount.id + "/voucherList").remove();
      if (list.isNotEmpty) {
        for (int i = 0 ; i < list.length ; i++) {
          await databaseRef.child('normalUser/' + currentAccount.id + "/voucherList/" + i.toString()).set(list[i].toJson());
        }
      }
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (bikeSetLocation.firstText == "NA") {
      setlocation = bikeSetLocation.Longitude.toString() + " , " + bikeSetLocation.Latitude.toString();
    } else {
      setlocation = bikeSetLocation.firstText;
    }

    if (bikeGetLocation.firstText == "NA") {
      getlocation = bikeGetLocation.Longitude.toString() + " , " + bikeGetLocation.Latitude.toString();
    } else {
      getlocation = bikeGetLocation.firstText;
    }

    if (currentReceiver.name != "NA") {
      receiverManText = currentReceiver.name + '-' + currentReceiver.phoneNum;
    }

    cost = getCost(widget.Distance).toDouble();
    if (currentitemdetail.weight != -1) {
      infororderText = currentitemdetail.weight.toString() + " kg. " + currentitemdetail.type + " .Thu hộ : " + getStringNumber(currentitemdetail.codFee) + 'đ';
      if (currentitemdetail.codFee > 0) {
        cost = cost + 5000;
      }

    }

    if (chosenvoucher.id != 'NA') {
      cost = cost - chosenvoucher.totalmoney;
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),

            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight/5,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 82, 57)
                    ),

                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 40,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              currentReceiver.phoneNum = 'NA';
                              currentReceiver.name = 'NA';
                              currentReceiver.note = 'NA';
                              currentReceiver.locationNote = 'NA';
                              currentReceiver.location = accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA");

                              currentitemdetail.codFee = -1;
                              currentitemdetail.type = 'NA';
                              currentitemdetail.weight = -1;

                              bikeGetLocation.firstText = "NA";
                              bikeGetLocation.phoneNum = "NA";
                              bikeGetLocation.LocationID = "NA";
                              bikeGetLocation.secondaryText = "NA";
                              bikeGetLocation.Latitude = -1;
                              bikeGetLocation.Longitude = -1;

                              bikeSetLocation.firstText = "NA";
                              bikeSetLocation.phoneNum = "NA";
                              bikeSetLocation.LocationID = "NA";
                              bikeSetLocation.secondaryText = "NA";
                              bikeSetLocation.Latitude = -1;
                              bikeSetLocation.Longitude = -1;
                              startcontroller.clear();
                              endcontroller.clear();
                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationitemsendst1()));
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/backicon1.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: screenHeight/7,
                  left: 18,
                  child: Container(
                    width: screenWidth - 36,
                    height: screenHeight / 2.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),

                    child: Stack(
                      children: <Widget>[
                        ///điểm lấy hàng
                        Positioned(
                          top: 15,
                          left: 15,
                          child: Container(
                            height: screenWidth / 17,
                            width: screenWidth / 17,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/bluecircle.png'),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 18,
                          left: 20 + screenWidth / 17,
                          child: Text(
                            compactString(35, setlocation),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Positioned(
                          top: 18 + screenWidth / 17,
                          left: 20 + screenWidth / 17,
                          child: Text(
                            currentAccount.name + "-" + currentAccount.phoneNum,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'arial',
                                color: Colors.black45,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        ///điểm nhận hàng
                        Positioned(
                          top: 75,
                          left: 15,
                          child: Container(
                            height: screenWidth / 17,
                            width: screenWidth / 17,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/iconlocation.png'),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 78,
                          left: 20 + screenWidth / 17,
                          child: Text(
                            compactString(35, getlocation),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'arial',
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Positioned(
                          top: 78 + screenWidth / 17,
                          left: 20 + screenWidth / 17,
                          child: GestureDetector(
                            onTap: () {
                              currentReceiver.phoneNum = 'NA';
                              currentReceiver.name = 'NA';
                              currentReceiver.note = 'NA';
                              currentReceiver.locationNote = 'NA';
                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENfillreceiverinfor(Distance: widget.Distance,)));
                            },
                            child: Container(
                              child: Text(
                                receiverManText,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'arial',
                                  color: receiverMancolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        ///làm màu
                        Positioned(
                          top: 110 + screenWidth / 17,
                          left: 20,
                          child: Container(
                            height: 1,
                            width: screenWidth - 36 - 40,
                            decoration: BoxDecoration(
                              color: Colors.grey
                            ),
                          ),
                        ),

                        Positioned(
                          top: 145,
                          left: 10,
                          child: Container(
                            height: screenWidth / 12,
                            width: screenWidth / 12,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/linhtinh3.png'),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 148,
                          left: 20 + screenWidth / 17,
                          child: Text(
                            'Lấy hàng ngay(Trong 15 phút)',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'arial',
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Positioned(
                          top: 145 + screenWidth / 17,
                          left: 20 + screenWidth / 17,
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              child: Text(
                                'Nhanh chóng và tiện lợi',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'arial',
                                  color: receiverMancolor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 195,
                          left: 10,
                          child: Container(
                            height: screenWidth / 12,
                            width: screenWidth / 12,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/linhtinh4.png'),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 198,
                          left: 20 + screenWidth / 17,
                          child: Text(
                            'Xe máy',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'arial',
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Positioned(
                          top: 195 + screenWidth / 17,
                          left: 20 + screenWidth / 17,
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              child: Text(
                                'Tối đa 50kg (50x50x50cm)',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'arial',
                                  color: Colors.green,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 235 + screenWidth / 17,
                          left: 20,
                          child: Container(
                            height: 1,
                            width: screenWidth - 36 - 40,
                            decoration: BoxDecoration(
                                color: Colors.grey
                            ),
                          ),
                        ),

                        ///thông tin hàng hóa
                        Positioned(
                          top: 265,
                          left: 15,
                          child: Container(
                            height: screenWidth / 12,
                            width: screenWidth / 12,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/linhtinh5.png'),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 268,
                          left: 25 + screenWidth / 17,
                          child: Text(
                            'Thông tin hàng hóa',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'arial',
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Positioned(
                          top: 268 + screenWidth / 17,
                          left: 25 + screenWidth / 17,
                          child: GestureDetector(
                            onTap: () {
                              currentitemdetail.weight = -1;
                              currentitemdetail.type = 'NA';
                              currentitemdetail.codFee = -1;
                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENfillitemsendinfo(Distance: widget.Distance,)));
                            },
                            child: Container(
                              child: Text(
                                infororderText,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'arial',
                                  color: inforordercolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: screenHeight/5 + 40,
                  left: 20,
                  child: Container(
                    height: 1,
                    width: screenWidth - 40,
                    decoration: BoxDecoration(
                        color: Colors.grey
                    ),
                  ),
                ),

                Positioned(
                  bottom: screenHeight/5,
                  left: 18,
                  child: Text(
                    "Tổng tiền ",
                    style: TextStyle(
                      fontFamily: 'arial',
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                ),

                Positioned(
                  bottom: screenHeight/5,
                  right: 18,
                  child: Text(
                    getStringNumber(cost.toDouble()) + "đ",
                    style: TextStyle(
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),

                Positioned(
                  bottom: 60,
                  left: 18,
                  child: Container(
                    width: screenWidth/2 - 28,
                    height: 60,
                    child: ButtonType1(Height: 60, Width: screenWidth/2 - 28, color: Color.fromARGB(255, 0, 177, 79), radiusBorder: 30, title: 'Đặt đơn', fontText: 'arial', colorText: Colors.white,
                        onTap: () async {
                           setState(() {
                             bookingloading = true;
                           });

                           if (chosenvoucher.id != 'NA') {
                             List<Voucher> newlist = [];
                             for (int i = 0 ; i < currentAccount.voucherList.length ; i++) {
                               if (chosenvoucher.id != currentAccount.voucherList[i].id) {
                                 newlist.add(currentAccount.voucherList[i]);
                               }
                             }
                             await pushVoucherdata(newlist);
                           }

                           itemsendOrder itemorder = itemsendOrder(
                               id: generateID(10),
                               cost: cost.toDouble(),
                               owner: currentAccount,
                               shipper: accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, cartList: [], locationHis: [], voucherList: []),
                               status: 'A',
                               endTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                               startTime: getCurrentTime(),
                               cancelTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                               receiveTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                               locationset: bikeSetLocation,
                               receiver: currentReceiver,
                               itemdetails: currentitemdetail
                           );

                           await pushitemSendOrder(itemorder);
                        }, loading: bookingloading),
                  ),
                ),

                Positioned(
                  bottom: 60,
                  right: 18,
                  child: Container(
                    width: screenWidth/2 - 28,
                    height: 60,
                    child: ButtonType1(Height: 60, Width: screenWidth/2 - 28, color: Color.fromARGB(255, 238, 250, 250), radiusBorder: 30, title: 'Ưu đãi', fontText: 'arial', colorText: Colors.black,
                        onTap: () {
                          chosenvoucher.id = 'NA';
                          chosenvoucher.mincost = 0;
                          chosenvoucher.totalmoney = 0;
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENvoucherchosen(type: 3, distance: widget.Distance,)));
                        }, loading: voucherloading),
                  ),
                )
              ],
            ),
          ),
        ),
      onWillPop: () async {
        return false;
      },
    );
  }
}

import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rabbitshipping/FINAL/finalClass.dart';
import 'package:rabbitshipping/GENERAL/Order/catchOrder.dart';
import 'package:rabbitshipping/GENERAL/Order/foodOrder.dart';
import 'package:rabbitshipping/GENERAL/Tool/Tool.dart';
import 'package:rabbitshipping/OTHER/Button/Buttontype1.dart';
import 'package:rabbitshipping/SCREEN/ORDER/WAIT/SCREEN_waitbiker.dart';
import 'package:rabbitshipping/SCREEN/SHOP/SCREENfoodcart.dart';
import 'package:rabbitshipping/SCREEN/SHOP/SCREENshopmain.dart';

import '../../GENERAL/NormalUser/accountNormal.dart';
import '../../GENERAL/Product/Voucher.dart';
import '../../GENERAL/Tool/Time.dart';
import '../VOUCHER/SCREENvoucherchosen.dart';
import 'SCREEN_LOCATION_BIKE_ST1.dart';

class SCREENlocationfood1 extends StatefulWidget {
  final double Distance;
  const SCREENlocationfood1({Key? key, required this.Distance}) : super(key: key);

  @override
  State<SCREENlocationfood1> createState() => _SCREENlocationbikest2State();
}

class _SCREENlocationbikest2State extends State<SCREENlocationfood1> {
  late GoogleMapController mapController;
  double _originLatitude = bikeSetLocation.Latitude, _originLongitude = bikeSetLocation.Longitude;
  double _destLatitude = bikeGetLocation.Latitude, _destLongitude = bikeGetLocation.Longitude;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBsVQaVVMXw-y3QgvCWwJe02FWkhqP_wRA";
  bool Loading1 = false;
  double total = 0;

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }


  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

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

  Future<void> pushfoodOrder(foodOrder foodorder) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('foodOrder').child(foodorder.id).set(foodorder.toJson());
      cartList.clear();
      Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENshopmain()));
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
    for (int i = 0 ; i < cartList.length ; i++) {
      total = total + cartList[i].cost;
    }

    if (chosenvoucher.id != 'NA') {
      total = total - chosenvoucher.totalmoney;
    }

    _addMarker(LatLng(_originLatitude, _originLongitude), "origin", BitmapDescriptor.defaultMarker);

    _addMarker(LatLng(_destLatitude, _destLongitude), "destination", BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
            body: Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      height: screenHeight/1.5,
                      width: screenWidth,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(_originLatitude, _originLongitude), zoom: 12),
                        myLocationEnabled: false,
                        tiltGesturesEnabled: true,
                        compassEnabled: true,
                        scrollGesturesEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: false,
                        onMapCreated: _onMapCreated,
                        markers: Set<Marker>.of(markers.values),
                        polylines: Set<Polyline>.of(polylines.values),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: screenHeight/2,
                      width: screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),

                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              "Đơn đồ ăn ( " + double.parse(widget.Distance.toStringAsFixed(1)).toString() + " km )",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "arial",
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),

                          Positioned(
                            top: 50,
                            left: 0,
                            child: Container(
                              width: screenWidth,
                              height: screenHeight/10,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 238, 250, 250)
                              ),

                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: (screenHeight/10 - screenHeight/14)/2,
                                    left: 10,
                                    child: Container(
                                      height: screenHeight/14,
                                      width: screenHeight/14,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('assets/image/bikeLogo1.png')
                                          )
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: (screenHeight/10)/3,
                                    left: 10 + screenHeight/14 + 15,
                                    child: Container(
                                      child: Text(
                                        'Phí ship',
                                        style: TextStyle(
                                            fontFamily: 'arial',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: (screenHeight/10)/3,
                                    right: 10,
                                    child: Text(
                                      getStringNumber(getCost(widget.Distance).toDouble()) + "đ",
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            top: 50 +  screenHeight/10 + 10,
                            left: 0,
                            child: Container(
                              width: screenWidth,
                              height: screenHeight/10,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 238, 250, 250)
                              ),

                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: (screenHeight/10 - screenHeight/14)/2,
                                    left: 10,
                                    child: Container(
                                      height: screenHeight/14,
                                      width: screenHeight/14,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('assets/image/linhtinh5.png')
                                          )
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: (screenHeight/10)/3,
                                    left: 10 + screenHeight/14 + 15,
                                    child: Container(
                                      child: Text(
                                        'Giá trị đơn',
                                        style: TextStyle(
                                            fontFamily: 'arial',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: (screenHeight/10)/3,
                                    right: 10,
                                    child: Text(
                                      getStringNumber(total) + "đ",
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: screenWidth,
                              height: screenHeight/7,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3), // màu của shadow
                                    spreadRadius: 5, // bán kính của shadow
                                    blurRadius: 7, // độ mờ của shadow
                                    offset: Offset(0, 3), // vị trí của shadow
                                  ),
                                ],
                              ),

                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 10,
                                    left: 20,
                                    child: Container(
                                      width: 42,
                                      height: 21,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('assets/image/realmoneyicon.png')
                                          )
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 13,
                                    left: 20 + 42 + 10,
                                    child: Text(
                                      'Sử dụng tiền mặt',
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      ),
                                    ),
                                  ),


                                  ///Nút đặt đơn
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Container(
                                      width: screenWidth/2 - 20,
                                      height: screenHeight/15,
                                      child: ButtonType1(Height: screenHeight/10, Width: screenWidth/2 - 20, color: Color.fromARGB(255, 0, 177, 79), radiusBorder: 30, title: 'Đặt đơn', fontText: 'arial', colorText: Colors.white,
                                        onTap: () async {
                                        setState(() {
                                          Loading1 = true;
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

                                            foodOrder foodorder = foodOrder(
                                                id: generateID(12),
                                                locationSet: bikeSetLocation,
                                                locationGet: bikeGetLocation,
                                                cost: total,
                                                owner: currentAccount,
                                                shipper: accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, cartList: [], locationHis: [], voucherList: []),
                                                status: 'A',
                                                endTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                                                startTime: getCurrentTime(),
                                                productList: cartList,
                                                cancelTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                                                receiveTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                                                shipcost: getCost(widget.Distance).toDouble()
                                            );

                                            await pushfoodOrder(foodorder);
                                        }, loading: Loading1,
                                      ),
                                    ),
                                  ),

                                  ///Nút vouvher
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Container(
                                      width: screenWidth/2 - 20,
                                      height: screenHeight/15,
                                      child: ButtonType1(Height: screenHeight/10, Width: screenWidth/2 - 20, color: Color.fromARGB(255, 238, 250, 250), radiusBorder: 30, title: 'Ưu đãi', fontText: 'arial', colorText: Color.fromARGB(255, 30, 72, 64),
                                          onTap: () {
                                            chosenvoucher.id = 'NA';
                                            chosenvoucher.mincost = 0;
                                            chosenvoucher.totalmoney = 0;
                                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENvoucherchosen(type: 4, distance: widget.Distance,)));
                                          }
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///Nút back
                  Positioned(
                    top: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
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
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENshopmain()));
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
                  )

                ],
              ),
            )
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}

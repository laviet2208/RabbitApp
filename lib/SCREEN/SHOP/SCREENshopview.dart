import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rabbitshipping/FINAL/finalClass.dart';
import 'package:rabbitshipping/GENERAL/Product/Product.dart';
import 'package:rabbitshipping/GENERAL/ShopUser/accountShop.dart';
import 'package:rabbitshipping/ITEM/ITEMfood.dart';
import 'package:rabbitshipping/ITEM/ITEMrestaurant.dart';
import 'package:rabbitshipping/SCREEN/SHOP/SCREENshopmain.dart';

import '../INUSER/SCREEN_MAIN/SCREENmain.dart';
import 'SCREENfoodview.dart';

class SCREENshopview extends StatefulWidget {
  final accountShop currentShop;
  const SCREENshopview({Key? key, required this.currentShop}) : super(key: key);

  @override
  State<SCREENshopview> createState() => _SCREENshopmainState();
}

class _SCREENshopmainState extends State<SCREENshopview> {
  List<Product> productList = [];
  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("RestaurantFood").onValue.listen((event) {
      productList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        Product pro = Product.fromJson(value);
        if (pro.owner.phoneNum == widget.currentShop.phoneNum) {
          productList.add(pro);
          setState(() {});
        }
      });
    });
  }

  List<int> parseDateString(String dateString) {
    List<String> parts = dateString.split('/');
    if (parts.length != 3) {
      throw Exception("Invalid date format");
    }

    int day = int.tryParse(parts[0]) ?? 0;
    int month = int.tryParse(parts[1]) ?? 0;
    int year = int.tryParse(parts[2]) ?? 0;

    return [day, month, year];
  }

  String formatTime(int hour, int minute, int second) {
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');
    return '$formattedHour giờ $formattedMinute phút';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      child: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: screenWidth,
                      height: screenHeight,

                      child: ListView(
                        children: [
                          Container(
                            height: screenHeight/5 + 60,
                            width: screenWidth,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    height: screenHeight/6,
                                    width: screenWidth,
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
                                        ),

                                        Positioned(
                                          right: 0,
                                          bottom: 40,
                                          child: Container(
                                            width: screenWidth/3,
                                            height: screenWidth/6,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage('assets/image/stick.png')
                                                )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: screenHeight/8,
                                  left: 10,
                                  child: GestureDetector(
                                    onTap: () {

                                    },
                                    child: Container(
                                      height: 110,
                                      width: screenWidth - 20,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: 15,
                                            left: 10,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage('assets/image/iconlocation.png'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 20,
                                            left: 50,
                                            child: Text(
                                              widget.currentShop.name,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'arial',
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 50,
                                            left: 50,
                                            child: Text(
                                              "Giờ mở cửa : " + formatTime(parseDateString(widget.currentShop.openTime)[0],parseDateString(widget.currentShop.openTime)[1],parseDateString(widget.currentShop.openTime)[2]),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'arial',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 70,
                                            left: 50,
                                            child: Text(
                                              "Giờ đóng cửa : " + formatTime(parseDateString(widget.currentShop.closeTime)[0],parseDateString(widget.currentShop.closeTime)[1],parseDateString(widget.currentShop.closeTime)[2]),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'arial',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(height: 10,),

                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                                height: screenHeight - 10 - screenHeight/5 - 60,
                                decoration: BoxDecoration(

                                ),
                                child: GridView.builder(
                                  itemCount: productList.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // số phần tử trên mỗi hàng
                                    mainAxisSpacing: 0, // khoảng cách giữa các hàng
                                    crossAxisSpacing: 0, // khoảng cách giữa các cột
                                    childAspectRatio: 0.73, // tỷ lệ chiều rộng và chiều cao
                                  ),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENfoodview(product: productList[index],)));
                                        },
                                        child: ITEMfood(product: productList[index]),
                                      ),
                                    );
                                  },
                                )
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              )
          )
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}

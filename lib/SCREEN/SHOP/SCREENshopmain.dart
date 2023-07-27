import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rabbitshipping/FINAL/finalClass.dart';
import 'package:rabbitshipping/GENERAL/ShopUser/accountShop.dart';
import 'package:rabbitshipping/GENERAL/utils/utils.dart';
import 'package:rabbitshipping/ITEM/ITEMrestaurant.dart';
import 'package:rabbitshipping/SCREEN/SHOP/SCREENfoodcart.dart';
import 'package:rabbitshipping/SCREEN/SHOP/SCREENshopview.dart';

import '../INUSER/SCREEN_MAIN/SCREENmain.dart';

class SCREENshopmain extends StatefulWidget {
  const SCREENshopmain({Key? key}) : super(key: key);

  @override
  State<SCREENshopmain> createState() => _SCREENshopmainState();
}

class _SCREENshopmainState extends State<SCREENshopmain> {
  List<accountShop> shopList = [];
  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("RestaurantAccount").onValue.listen((event) {
      shopList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        accountShop acc = accountShop.fromJson(value);
        shopList.add(acc);
        setState(() {});
      });

    });
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
                            height: screenHeight/8 + 60,
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
                                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmain()));
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
                                      height: 60,
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
                                              'Xin chào, ' + currentAccount.name,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'arial',
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black87,
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
                                height: screenHeight - 10 - screenHeight/8 + 60,
                                decoration: BoxDecoration(

                                ),
                                child: GridView.builder(
                                  itemCount: shopList.length,
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
                                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENshopview(currentShop: shopList[index])));
                                        },
                                        child: ITEMrestaurant(currentshop: shopList[index]),
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

                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: GestureDetector(
                      onTap: () {
                        if (cartList.length == 0) {
                          toastMessage('Giỏ hàng chưa có sản phẩm nào');
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENfoodcart()));
                        }
                      },
                    child: Container(
                      width: 60,
                      height: 60,
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
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image/carticon.png')
                        )
                      ),

                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 5,
                            right: 5,
                              child: Container(
                                alignment: Alignment.center,
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Text(
                                  cartList.length.toString(),
                                  style: TextStyle(
                                    fontFamily: 'arial',
                                    color: Colors.white,
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                          )
                        ],
                      ),
                    ),
                  )
                  )
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

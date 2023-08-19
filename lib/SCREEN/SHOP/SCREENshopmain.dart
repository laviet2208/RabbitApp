import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rabbitshipping/FINAL/finalClass.dart';
import 'package:rabbitshipping/GENERAL/ShopUser/accountShop.dart';
import 'package:rabbitshipping/GENERAL/utils/utils.dart';
import 'package:rabbitshipping/ITEM/ITEMrestaurant.dart';
import 'package:rabbitshipping/SCREEN/SHOP/SCREENfoodcart.dart';
import 'package:rabbitshipping/SCREEN/SHOP/SCREENshopview.dart';

import '../../GENERAL/Product/Product.dart';
import '../../ITEM/ITEMfood.dart';
import '../INUSER/SCREEN_MAIN/SCREENmain.dart';
import 'SCREENfoodview.dart';

class SCREENshopmain extends StatefulWidget {
  const SCREENshopmain({Key? key}) : super(key: key);

  @override
  State<SCREENshopmain> createState() => _SCREENshopmainState();
}

class _SCREENshopmainState extends State<SCREENshopmain> {
  List<accountShop> shopList = [];
  List<Product> monngonmoinoi = [];
  List<Product> sieusao = [];
  List<Product> uudai = [];

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

  void getfoodData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("RestaurantFood").onValue.listen((event) {
      monngonmoinoi.clear();
      sieusao.clear();
      uudai.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        Product acc = Product.fromJson(value);
        if (acc.type == 1) {
          monngonmoinoi.add(acc);
        }
        if (acc.type == 2) {
          sieusao.add(acc);
        }
        if (acc.type == 3) {
          uudai.add(acc);
        }
        setState(() {});
      });

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getfoodData();
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

                          Container(height: 20,),

                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                'Danh sách nhà hàng',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'arial',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              )
                          ),

                          Container(height: 10,),

                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                                height: 249,
                                decoration: BoxDecoration(

                                ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
                                itemCount: shopList.length,
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
                              ),

                            ),
                          ),

                          Container(height: 20,),

                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                'Món ngon mới nổi',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'arial',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              )
                          ),

                          Container(height: 10,),

                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              height: 249,
                              decoration: BoxDecoration(

                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
                                itemCount: monngonmoinoi.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENfoodview(product: monngonmoinoi[index],)));
                                      },
                                      child: ITEMfood(product: monngonmoinoi[index]),
                                    ),
                                  );
                                },
                              ),

                            ),
                          ),


                          Container(height: 20,),

                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                'Siêu sao trong tháng',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'arial',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              )
                          ),

                          Container(height: 10,),

                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              height: 249,
                              decoration: BoxDecoration(

                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
                                itemCount: sieusao.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENfoodview(product: sieusao[index],)));
                                      },
                                      child: ITEMfood(product: sieusao[index]),
                                    ),
                                  );
                                },
                              ),

                            ),
                          ),


                          Container(height: 20,),

                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                'Ngập tràn ưu đãi',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'arial',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              )
                          ),

                          Container(height: 10,),

                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              height: 249,
                              decoration: BoxDecoration(

                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
                                itemCount: uudai.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENfoodview(product: uudai[index],)));
                                      },
                                      child: ITEMfood(product: uudai[index]),
                                    ),
                                  );
                                },
                              ),

                            ),
                          ),
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

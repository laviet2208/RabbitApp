import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rabbitshipping/FINAL/finalClass.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rabbitshipping/GENERAL/Order/foodOrder.dart';
import 'package:rabbitshipping/GENERAL/utils/utils.dart';
import '../../../GENERAL/NormalUser/accountNormal.dart';
import '../PAGE_ACCOUNTINFO/PAGEaccountinfo.dart';
import '../PAGE_COMMINGSOON/PAGEcommingsoon.dart';
import '../PAGE_HOME/PAGEhome.dart';

class SCREENmain extends StatefulWidget {
  const SCREENmain({Key? key}) : super(key: key);

  @override
  State<SCREENmain> createState() => _SCREENmainState();
}

class _SCREENmainState extends State<SCREENmain> {
  int selectedIndex = 0;
  final List<foodOrder> isShippingList = [];

  Future<void> getData(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('foodOrder').once();
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      isShippingList.clear();
      catchOrderData.forEach((key, value) {
        if (accountNormal.fromJson(value['owner']).id == id) {
          foodOrder thisO = foodOrder.fromJson(value);
          if (thisO.status == 'A' || thisO.status == 'B' || thisO.status == 'C' || thisO.status == 'D') {
            isShippingList.add(thisO);
            setState(() {

            });
          }
        }
      }
      );
    }
  }

  Widget getBodyWidget() {
    // Dựa vào selectedIndex, trả về phần body tương ứng
    switch (selectedIndex) {
      case 0 :
        return PAGEhome();
      case 3 :
        return PAGEaccountinfo();
      default:
        return PAGEcommingsoon();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(currentAccount.id);
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
              bottom: 0,
              child: Container(
                width: screenWidth,
                child: getBodyWidget(),
              ),
            ),

            Positioned(
                right: 10,
                bottom: 10,
                child: GestureDetector(
                  onTap: () {
                    if (isShippingList.length != 0) {

                    } else {
                      toastMessage('Bạn chưa có đơn hàng nào');
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
                              isShippingList.length.toString(),
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
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: Color.fromARGB(255, 244, 90, 36),
            tabBackgroundColor: Color.fromARGB(100, 200, 225, 252),
            gap: 8,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },

            padding: EdgeInsets.all(12),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: ("Trang chủ"),
              ),

              GButton(
                icon: Icons.list_alt_outlined,
                text: ("Hoạt động"),
              ),

              GButton(
                icon: Icons.account_balance_wallet,
                text: ("Thanh toán"),
              ),

              GButton(
                icon: Icons.account_circle_sharp,
                text: ("Tài Khoản"),
              ),
            ],
          ),
        ),
      ),

    ),
      onWillPop: () async {
        return false;
      },
    );
  }
}

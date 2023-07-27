import 'package:flutter/material.dart';
import 'package:rabbitshipping/FINAL/finalClass.dart';
import 'package:rabbitshipping/GENERAL/Tool/Tool.dart';
import 'package:rabbitshipping/ITEM/ITEMfoodincart.dart';
import 'package:rabbitshipping/OTHER/Button/Buttontype1.dart';
import 'package:rabbitshipping/SCREEN/SHOP/SCREENshopmain.dart';

import '../../GENERAL/utils/utils.dart';
import '../LOCATION/SCREEN_LOCATION_FOOD.dart';

class SCREENfoodcart extends StatefulWidget {
  const SCREENfoodcart({Key? key}) : super(key: key);

  @override
  State<SCREENfoodcart> createState() => _SCREENfoodcartState();
}

class _SCREENfoodcartState extends State<SCREENfoodcart> {
  double total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    total = 0;
    for (int i = 0 ; i < cartList.length ; i++) {
      total = total + cartList[i].cost;
    }
  }

  double getF(String input) {
    List<String> parts = input.split(',');
    if (parts.length > 0) {
      String firstPart = parts[0];
      return double.tryParse(firstPart) ?? 0.0;
    }
    return 0.0;
  }

  double getS(String input) {
    List<String> parts = input.split(',');
    if (parts.length > 1) {
      String secondPart = parts[1];
      return double.tryParse(secondPart) ?? 0.0;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENshopmain()));
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/image/backicon1.png')
                          )
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Text(
                  'Giỏ hàng của tôi',
                  style: TextStyle(
                    fontFamily: "arial",
                    fontSize: screenWidth/19.65,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(width: 5),

              ],
            ),
          ),

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
                      height: screenHeight - 10 - screenHeight/8 + 60,
                      width: screenWidth,
                      decoration: BoxDecoration(

                      ),
                      child: GridView.builder(
                        itemCount: cartList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, // số phần tử trên mỗi hàng
                          mainAxisSpacing: 0, // khoảng cách giữa các hàng
                          crossAxisSpacing: 0, // khoảng cách giữa các cột
                          childAspectRatio: 4, // tỷ lệ chiều rộng và chiều cao
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                            child: InkWell(
                              onTap: () {

                              },
                              child: ITEMfoodincart(food: cartList[index], width: screenWidth,
                              onTap: () {
                                cartList.remove(cartList[index]);
                                toastMessage('đã xóa khỏi giỏ hàng');
                                total = 0;
                                for (int i = 0 ; i < cartList.length ; i++) {
                                  total = total + cartList[i].cost;
                                }
                                setState(() {

                                });
                                if (cartList.length == 0) {
                                  toastMessage('giỏ hàng trống');
                                  Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENshopmain()));
                                }
                              },),
                            ),
                          );
                        },
                      )
                  ),
                ),

                Positioned(
                  bottom: 70,
                  left: 10,
                  child: Container(
                    width: screenWidth-10,
                    height: 70,
                    child: Text(
                      'Tổng tiền : ' + getStringNumber(total) + "đ" ,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'arial',
                        color: Colors.black
                      ),
                    )
                  ),
                ),

                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    width: screenWidth-10,
                    height: 70,
                    child: ButtonType1(Height: 70, Width: screenWidth-20, color: Color.fromARGB(255, 0, 177, 79), radiusBorder: 35, title: 'Bước tiếp theo', fontText: 'arial', colorText: Colors.white,
                        onTap: () {
                          bikeGetLocation.firstText = "NA";
                          bikeGetLocation.phoneNum = "NA";
                          bikeGetLocation.LocationID = "NA";
                          bikeGetLocation.secondaryText = "NA";
                          bikeGetLocation.Latitude = -1;
                          bikeGetLocation.Longitude = -1;
                          startcontroller.clear();

                          bikeSetLocation.firstText = "NA";
                          bikeSetLocation.phoneNum = "NA";
                          bikeSetLocation.LocationID = "NA";
                          bikeSetLocation.secondaryText = "NA";
                          print(getF(cartList[0].owner.location).toString());
                          bikeSetLocation.Latitude = getF(cartList[0].owner.location);
                          bikeSetLocation.Longitude = getS(cartList[0].owner.location);

                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationfood()));
                        }),
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

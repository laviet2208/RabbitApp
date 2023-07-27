import 'package:flutter/material.dart';
import 'package:rabbitshipping/SCREEN/LOCATION/SCREEN_LOCATION_CAR_ST1.dart';

import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/NormalUser/accountLocation.dart';
import '../../HISTORY/SCREENhistorysend.dart';
import '../../INUSER/SCREEN_MAIN/SCREENmain.dart';
import '../../LOCATION/SCREEN_LOCATION_BIKE_ST1.dart';
import '../../LOCATION/SCREEN_LOCATION_ITEMSEND_ST1.dart';

class SCREENitemsend extends StatefulWidget {
  const SCREENitemsend({Key? key}) : super(key: key);

  @override
  State<SCREENitemsend> createState() => _SCREENitemsendState();
}

class _SCREENitemsendState extends State<SCREENitemsend> {
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

            child: ListView(
              children: [
                Container(
                  height: 230,
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),

                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: 200,
                          width: screenWidth,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 82, 57)
                          ),

                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 50,
                                left: 20,
                                child: Text(
                                  "Rabbit express",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'arial',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),

                              Positioned(
                                  top: 80,
                                  left: 20,
                                  child: Container(
                                    width: screenWidth/2,
                                    child: Text(
                                      "Cẩn thận , bảo mật và vô cùng nhanh chóng",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'arial',
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                              ),

                              Positioned(
                                  top: 50,
                                  right: 10,
                                child: GestureDetector(
                                  onTap: () {

                                  },

                                    child: Container(
                                      width: 100,
                                      height: 436/5,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('assets/image/parcel.png')
                                          )
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Bắt đầu đặt đơn
                      Positioned(
                        bottom: 0,
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
                                    'Bắt đầu gửi hàng ?',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'arial',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      ///Nút back
                      Positioned(
                        top: 10,
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

                      ///Nút lịch sử đơn
                      Positioned(
                        top: 10,
                        left: 10 + 30 + 10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENhistorysend()));
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
                                image: AssetImage('assets/image/iconorder.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rabbitshipping/FINAL/finalClass.dart';

import '../../INUSER/SCREEN_MAIN/SCREENmain.dart';
import '../../LOCATION/SCREEN_LOCATION_BIKE_ST1.dart';

class SCREENbikeorder extends StatefulWidget {
  const SCREENbikeorder({Key? key}) : super(key: key);

  @override
  State<SCREENbikeorder> createState() => _SCREENbikeorderState();
}

class _SCREENbikeorderState extends State<SCREENbikeorder> {
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
                            color: Color.fromARGB(255, 186, 237, 194)
                        ),

                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 50,
                              left: 20,
                              child: Text(
                                "Di chuyển",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'arial',
                                    color: Colors.black,
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
                                    "Chúng tôi sẽ đưa bạn tới bất kỳ đâu!",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'arial',
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                            ),

                            Positioned(
                                top: 50,
                                right: 10,
                                child: Container(
                                  width: 100,
                                  height: 436/5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/linhtinh1.png')
                                      )
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Chọn địa chỉ đến
                    Positioned(
                      bottom: 0,
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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationbikest1()));
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
                                  'Đến đâu ?',
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
                    )
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

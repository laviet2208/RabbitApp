import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:rabbitshipping/GENERAL/models/autocomplate_prediction.dart';
import 'package:rabbitshipping/GENERAL/models/place_auto_complate_response.dart';
import 'package:rabbitshipping/GENERAL/utils/utils.dart';
import 'package:rabbitshipping/SCREEN/INUSER/SCREEN_MAIN/SCREENmain.dart';
import 'package:uuid/uuid.dart';

import '../../FINAL/finalClass.dart';
import '../FEATURE/SCREEN_BIKEORDER/SCREENbikeorder.dart';
import '../FEATURE/SCREEN_itemsend/SCREENitemsend.dart';
import '../INUSER/PAGE_LOCATIONSEARCH/PAGE_ItemSendlocationsearchget.dart';
import '../INUSER/PAGE_LOCATIONSEARCH/PAGE_ItemSendlocationsearchset.dart';
import '../INUSER/PAGE_LOCATIONSEARCH/PAGElocationsearchset.dart';
import '../INUSER/PAGE_LOCATIONSEARCH/PAGElocationsearchget.dart';

class SCREENlocationitemsendst1 extends StatefulWidget {
  const SCREENlocationitemsendst1({Key? key}) : super(key: key);

  @override
  State<SCREENlocationitemsendst1> createState() => _SCREENlocationitemsendst1State();
}

class _SCREENlocationitemsendst1State extends State<SCREENlocationitemsendst1> {
  //màu của textfield điểm đi
  Color TextfieldsetColor = Color.fromARGB(255, 245, 245, 245);

  //chọn widget
  int selectedIndex = 0;
  Widget getBodyWidget() {
    switch (selectedIndex) {
      case 1 :
        return PAGEitemsendlocationsearchget(placePredictions: placePredictions,);
      case 0 :
        return PAGEitemsendlocationsearchset(placePredictions : placePredictions);
      default:
        return Container();
    }
  }

  //các hàm api vị trí
  var uuid = Uuid();
  List<AutocompletePrediction> placePredictions = [];

  void placeAutocomplete(String query) async{
    final url = Uri.parse('https://rsapi.goong.io/Place/AutoComplete?api_key=3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf&input=$query');

    var response = await http.get(url);

    if (response != null) {
      PlaceAutocompleteResponse result = PlaceAutocompleteResponse.parseAutocompleteResult(response.body);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (bikeSetLocation.Longitude == -1 && bikeSetLocation.Latitude == -1) {

    } else {
      if (bikeSetLocation.firstText == 'NA') {
        startcontroller.text = bikeSetLocation.Latitude.toString() + "," + bikeSetLocation.Longitude.toString();
      } else {
        startcontroller.text = bikeSetLocation.firstText;
      }
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
              color: Color.fromARGB(255, 245, 245, 245)
          ),

          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: screenWidth,
                  height: screenWidth/2.5,
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),

                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 60,
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
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENitemsend()));
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/backicon.png'),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 50,
                        left: 40,
                        child: Container(
                          width: screenWidth - 40 - 20,
                          height: screenWidth / 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: TextfieldsetColor,
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: (screenWidth / 8 - screenWidth / 18) / 2,
                                left: 5,
                                child: Container(
                                  height: screenWidth / 18,
                                  width: screenWidth / 18,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/image/bluecircle.png'),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                bottom: 5,
                                right: 5,
                                child: Container(
                                  width: screenWidth - 40 - 25 - screenWidth / 15 - 15,
                                  height: screenWidth / 8 - 10,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(),
                                  child: Form(
                                    child: TextFormField(
                                      onTap: () {
                                        setState(() {
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
                                          TextfieldsetColor = Color.fromARGB(255, 245, 245, 245);
                                          selectedIndex = 0;
                                        });
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          placeAutocomplete(value);
                                        });
                                      },
                                      controller: startcontroller,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'arial',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Đón bạn ở đâu ?',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'arial',
                                        ),
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
                        bottom: 5,
                        left: 40,
                        child: Container(
                          width: screenWidth - 40 - 20,
                          height: screenWidth / 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 245, 245, 245),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: (screenWidth / 8 - screenWidth / 18) / 2,
                                left: 5,
                                child: Container(
                                  height: screenWidth / 18,
                                  width: screenWidth / 18,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/image/iconlocation.png'),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                bottom: 5,
                                right: 5,
                                child: Container(
                                  width: screenWidth - 40 - 25 - screenWidth / 15 - 15,
                                  height: screenWidth / 8 - 10,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(),
                                  child: Form(
                                    child: TextFormField(
                                      onTap: () {
                                        setState(() {
                                          if (bikeSetLocation.Longitude == -1 && bikeSetLocation.Latitude == -1) {
                                            toastMessage('Bạn chưa chọn điểm đón');
                                          } else {
                                            TextfieldsetColor = Colors.white;
                                            selectedIndex = 1;
                                          }
                                        });
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          placeAutocomplete(value);
                                        });
                                      },
                                      readOnly: bikeSetLocation.Longitude == -1 && bikeSetLocation.Latitude == -1,
                                      controller: endcontroller,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'arial',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Bạn muốn đến đâu ?',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'arial',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              Positioned(
                top: screenWidth/2.5 + 10,
                left: 0,
                child: Container(
                    alignment: Alignment.topCenter,
                    width: screenWidth,
                    height: screenHeight - screenWidth/2.5 - 10,
                    child: getBodyWidget()
                ),
              ),

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

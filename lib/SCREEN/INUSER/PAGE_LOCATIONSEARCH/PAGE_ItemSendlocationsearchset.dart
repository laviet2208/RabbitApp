import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rabbitshipping/FINAL/finalClass.dart';
import 'package:rabbitshipping/GENERAL/models/autocomplate_prediction.dart';
import 'package:rabbitshipping/GENERAL/utils/utils.dart';

import '../../../ITEM/ITEMplaceAutoComplete.dart';
import '../../../MAPPICKER/SCREENmappicker.dart';

class PAGEitemsendlocationsearchset extends StatefulWidget {
  final List<AutocompletePrediction> placePredictions;
  const PAGEitemsendlocationsearchset({Key? key, required this.placePredictions}) : super(key: key);

  @override
  State<PAGEitemsendlocationsearchset> createState() => _PAGElocationsearchsetState();
}

class _PAGElocationsearchsetState extends State<PAGEitemsendlocationsearchset> {

  Future<double?> getLongti(String placeId) async {
    final baseUrl = "rsapi.goong.io";
    final path = "/Geocode";
    final queryParams = {
      "place_id": placeId,
      "api_key": '3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf',
    };

    final uri = Uri.https(baseUrl, path, queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["status"] == "OK" && data["results"].length > 0) {
        final location = data["results"][0]["geometry"]["location"];
        return location["lng"];
      } else {
        print("Không tìm thấy địa điểm hoặc có lỗi khi truy vấn.");
        return null;
      }
    } else {
      print("Lỗi kết nối: ${response.statusCode}");
      return null;
    }
  }

  Future<double?> getLati(String placeId) async {
    final baseUrl = "rsapi.goong.io";
    final path = "/Geocode";
    final queryParams = {
      "place_id": placeId,
      "api_key": '3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf',
    };

    final uri = Uri.https(baseUrl, path, queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["status"] == "OK" && data["results"].length > 0) {
        final location = data["results"][0]["geometry"]["location"];
        return location["lat"];
      } else {
        print("Không tìm thấy địa điểm hoặc có lỗi khi truy vấn.");
        return null;
      }
    } else {
      print("Lỗi kết nối: ${response.statusCode}");
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Stack(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top : 0,
                        left: 0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            width: screenWidth-40,
                            height: screenHeight/2,
                            decoration: BoxDecoration(

                            ),
                            child: ListView.builder(
                                itemCount: widget.placePredictions.length,
                                padding: EdgeInsets.only(top: 0), // Loại bỏ khoảng trống ở đỉnh danh sách
                                itemBuilder: (context, index) {
                                  return ITEMplaceAutoComplete(location: widget.placePredictions[index], width: screenWidth,
                                    onTap: () async {
                                      bikeSetLocation.LocationID = widget.placePredictions[index].placeId.toString();
                                      bikeSetLocation.firstText = widget.placePredictions[index].description.toString();
                                      if (widget.placePredictions[index].structuredFormatting!.secondaryText.toString() != null) {
                                        bikeSetLocation.secondaryText = widget.placePredictions[index].structuredFormatting!.secondaryText.toString();
                                      } else {
                                        bikeSetLocation.secondaryText = 'NA';
                                      }
                                      bikeSetLocation.Longitude = (await getLongti(widget.placePredictions[index].placeId.toString()))!;
                                      bikeSetLocation.Latitude = (await getLati(widget.placePredictions[index].placeId.toString()))!;
                                      toastMessage('bạn đã chọn điểm nhận là ' + bikeSetLocation.firstText);
                                      print(bikeSetLocation.toJson().toString());
                                      setState(() {
                                        startcontroller.text = bikeSetLocation.firstText;
                                      });
                                    },
                                  );
                                }
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmappicker(type: 3,)));
                          },

                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              width: screenWidth-40,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey
                                  )
                              ),

                              child: Text(
                                "Xem trong map",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'arial',
                                    fontSize: 13
                                ),
                              ),
                            ),
                          ),

                        ),
                      ),
                    ],
                  )
              )
          )
        ],
      ),
    );
  }
}

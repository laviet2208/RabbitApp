import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rabbitshipping/FINAL/finalClass.dart';
import 'package:rabbitshipping/GENERAL/NormalUser/accountNormal.dart';
import 'package:rabbitshipping/GENERAL/Order/catchOrder.dart';
import 'package:rabbitshipping/SCREEN/HISTORY/ITEM/ITEMhistorycatch.dart';
import 'package:rabbitshipping/SCREEN/INUSER/SCREEN_MAIN/SCREENmain.dart';

class SCREENhistorycatch extends StatefulWidget {
  const SCREENhistorycatch({Key? key}) : super(key: key);

  @override
  State<SCREENhistorycatch> createState() => _SCREENhistorycatchState();
}

class _SCREENhistorycatchState extends State<SCREENhistorycatch> {
  List<catchOrder> dataList = [];
  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('catchOrder').onValue.listen((event) {
      dataList.clear();
      final dynamic account = event.snapshot.value;
      account.forEach((key, value) {
        if (accountNormal.fromJson(value['owner']).id == currentAccount.id) {
          catchOrder thisO = catchOrder.fromJson(value);
          dataList.add(thisO);
        }
      }
      );
      setState(() {

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
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: 100,
                decoration: BoxDecoration(

                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 15,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmain()));
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

                    Positioned(
                      bottom: 22,
                      left: 60,
                      child: Text(
                        'Lịch sử đi lại',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 24,
                          fontFamily: 'arial',
                          color: Colors.black
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 100,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight - 100,
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                      child: InkWell(
                        onTap: () {

                        },
                        child: ITEMhistorycatch(order: dataList[index], width: screenWidth, height: 120),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rabbitshipping/GENERAL/NormalUser/accountNormal.dart';
import 'package:rabbitshipping/GENERAL/Order/itemsendOrder.dart';
import 'package:rabbitshipping/GENERAL/utils/utils.dart';

import '../../FINAL/finalClass.dart';
import '../INUSER/SCREEN_MAIN/SCREENmain.dart';
import 'ITEM/ITEMhistorysend.dart';

class SCREENhistorysend extends StatefulWidget {
  const SCREENhistorysend({Key? key}) : super(key: key);

  @override
  State<SCREENhistorysend> createState() => _SCREENhistorysendState();
}

class _SCREENhistorysendState extends State<SCREENhistorysend> {
  Future<void> changeStatus(itemsendOrder order, String status) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("itemsendOrder/" + order.id + "/status").set(status);
  }
  
  List<itemsendOrder> dataList = [];
  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('itemsendOrder').onValue.listen((event) {
      dataList.clear();
      final dynamic account = event.snapshot.value;
      account.forEach((key, value) {
        if (accountNormal.fromJson(value['owner']).id == currentAccount.id) {
          itemsendOrder thisO = itemsendOrder.fromJson(value);
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
                          'Lịch sử giao hàng',
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
                        child: ITEMhistorysend(order: dataList[index], width: screenWidth, height: 140,
                          onTap: () async{
                              if (dataList[index].status == 'A') {
                                await changeStatus(dataList[index], 'E');
                                toastMessage('đã hủy đơn');
                              }

                              if (dataList[index].status == 'B') {
                                await changeStatus(dataList[index], 'F');
                                toastMessage('đã hủy đơn');
                              }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rabbitshipping/FINAL/finalClass.dart';
import 'package:rabbitshipping/GENERAL/utils/utils.dart';
import 'package:rabbitshipping/SCREEN/FEATURE/SCREEN_CARORDER/SCREENcarorder.dart';
import 'package:rabbitshipping/SCREEN/ORDER/WAIT/SCREEN_waitdriver.dart';
import '../../../GENERAL/NormalUser/accountNormal.dart';
import '../../../GENERAL/Order/catchOrder.dart';
import '../../../GENERAL/ShopUser/accountShop.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../../ITEM/ITEMrestaurant.dart';
import '../../FEATURE/SCREEN_BIKEORDER/SCREENbikeorder.dart';
import '../../FEATURE/SCREEN_itemsend/SCREENitemsend.dart';
import '../../ORDER/WAIT/SCREEN_waitbiker.dart';
import '../../SHOP/SCREENshopmain.dart';
import '../../SHOP/SCREENshopview.dart';
import '../../VOUCHER/SCREENvoucherview.dart';

class PAGEhome extends StatefulWidget {
  const PAGEhome({Key? key}) : super(key: key);

  @override
  State<PAGEhome> createState() => _PAGEhomeState();
}

class _PAGEhomeState extends State<PAGEhome> {
  final nameController = TextEditingController();
  bool iscar = false;

  bool loadingBike = false;
  bool loadingCar = false;

  Future<bool> getData(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('catchOrder').once();
    bool ch = false;
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      catchOrderData.forEach((key, value) {
        if (accountNormal.fromJson(value['owner']).id == id) {
          catchOrder thisO = catchOrder.fromJson(value);
          if (thisO.status == 'A' || thisO.status == 'B' || thisO.status == 'C') {
            bikeSetLocation.Longitude = thisO.locationSet.Longitude;
            bikeSetLocation.Latitude = thisO.locationSet.Latitude;
            bikeGetLocation.Longitude = thisO.locationGet.Longitude;
            bikeGetLocation.Latitude = thisO.locationGet.Latitude;
            if (thisO.type == 1) {
              iscar = false;
            }
            if (thisO.type == 2) {
              iscar = true;
            }
            ch = true;
          }
        }
      }
      );
    }
    return ch;
  }

  int ads1 = 0;
  String ads1text = "...";
  String ad1 = "https://firebasestorage.googleapis.com/v0/b/nowshopping-493ca.appspot.com/o/ads%2Fads_no_content.png?alt=media&token=d4431d5b-46d6-4e49-bfb7-0da840ac88fb";
  String ad2 = "https://firebasestorage.googleapis.com/v0/b/nowshopping-493ca.appspot.com/o/ads%2Fads_no_content.png?alt=media&token=d4431d5b-46d6-4e49-bfb7-0da840ac88fb";
  String ad3 = "https://firebasestorage.googleapis.com/v0/b/nowshopping-493ca.appspot.com/o/ads%2Fads_no_content.png?alt=media&token=d4431d5b-46d6-4e49-bfb7-0da840ac88fb";

  List<accountShop> shopList = [];
  void getshopData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("RestaurantAccount").onValue.listen((event) {
      shopList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        accountShop acc = accountShop.fromJson(value);
        shopList.add(acc);
      });
      setState(() {
        ads1 = get_randomnumber(0, shopList.length - 1);
        ads1text = shopList[ads1].name;
      });
    });
  }

  void getADSdata1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ads/0").onValue.listen((event) {
      final dynamic product = event.snapshot.value;
      ad1 = product.toString();
      setState(() {

      });
    });
  }

  void getADSdata2() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ads/1").onValue.listen((event) {
      final dynamic product = event.snapshot.value;
      ad2 = product.toString();
      setState(() {

      });
    });
  }

  void getADSdata3() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ads/2").onValue.listen((event) {
      final dynamic product = event.snapshot.value;
      ad3 = product.toString();
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getADSdata1();
    getADSdata2();
    getADSdata3();
    getshopData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        
        child: ListView(
          children: [
            Container(
              height: screenWidth/5,
              decoration: BoxDecoration(
                color: Colors.white
              ),

              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    child: Container(
                      height: screenWidth/9,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 244, 90, 36)
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 55,
                        width: screenWidth - 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(255, 255, 255, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3), // màu của shadow
                              spreadRadius: 5, // bán kính của shadow
                              blurRadius: 7, // độ mờ của shadow
                              offset: Offset(0, 3), // vị trí của shadow
                            ),
                          ],
                        ),
                        child: Form(
                          child: TextFormField(
                            controller: nameController,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Dmsan_regular',
                            ),

                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Thành phố Hà Nội',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Dmsan_regular',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Container(
              height: 30,
            ),

            //phần menu các tiểu mục
            Container(
              height: 76,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 15,
                  ),

                  //Mục đồ ăn
                  Container(
                    width: 56,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENshopmain()));
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 56,
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/iconfood.png'),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 56,
                              alignment: Alignment.center,
                              child: Text(
                                'Đồ ăn',
                                style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: 25,
                  ),

                  //Mục Ô tô
                  Container(
                    width: 56,
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          loadingCar = true;
                        });
                        bool ch = await getData(currentAccount.id);
                        if (ch) {
                          if (iscar) {
                            setState(() {
                              loadingCar = false;
                            });
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENwaitdriver()));
                          }

                          if (!iscar) {
                            toastMessage('Bạn cần hủy đơn xe ôm trước khi tạo đơn mới');
                            setState(() {
                              loadingCar = false;
                            });
                          }
                        } else {
                          setState(() {
                            loadingCar = false;
                          });
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENcarorder()));
                        }
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 56,
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/icontransport.png'),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 56,
                              alignment: Alignment.center,
                              child: loadingCar ? CircularProgressIndicator(strokeWidth: 4, color: Colors.green,) : Text(
                                'Ô tô',
                                style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: 25,
                  ),

                  //Mục Xe máy
                  Container(
                    width: 56,
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          loadingBike = true;
                        });
                        bool ch = await getData(currentAccount.id);
                        if (ch) {
                          if (!iscar) {
                            setState(() {
                              loadingBike = false;
                            });
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENwaitbiker()));
                          }

                          if (iscar) {
                            toastMessage('Bạn cần hủy đơn taxi trước khi tạo đơn mới');
                            setState(() {
                              loadingBike = false;
                            });
                          }
                        } else {
                          setState(() {
                            loadingBike = false;
                          });
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENbikeorder()));
                        }
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 56,
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/iconbike.png'),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 56,
                              alignment: Alignment.center,
                              child: loadingBike ? CircularProgressIndicator(strokeWidth: 4, color: Colors.green,) : Text(
                                'Xe máy',
                                style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: 25,
                  ),

                  //Mục giao hàng
                  Container(
                    width: 56,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENitemsend()));
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 56,
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/icondelivery.png'),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 56,
                              alignment: Alignment.center,
                              child: Text(
                                'Giao hàng',
                                style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: 25,
                  ),

                  //Mục Đi chợ
                  Container(
                    width: 56,
                    child: GestureDetector(
                      onTap: () {
                        // Xử lý sự kiện click vào hình ảnh ở đây
                        print('Clicked on image');
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 56,
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/iconmart.png'),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 56,
                              alignment: Alignment.center,
                              child: Text(
                                'Đi chợ',
                                style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: 25,
                  ),

                  //Mục ưu đãi
                  Container(
                    width: 56,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENvoucherview()));
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 56,
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/iconoffer.png'),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 56,
                              alignment: Alignment.center,
                              child: Text(
                                'Ưu đãi',
                                style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: 25,
                  ),

                  //mục quà tặng
                  Container(
                    width: 56,
                    child: GestureDetector(
                      onTap: () {
                        // Xử lý sự kiện click vào hình ảnh ở đây
                        print('Clicked on image');
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 56,
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/icongift.png'),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 56,
                              alignment: Alignment.center,
                              child: Text(
                                'Quà tặng',
                                style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: 25,
                  ),

                  //mục mua sắm
                  Container(
                    width: 56,
                    child: GestureDetector(
                      onTap: () {
                        // Xử lý sự kiện click vào hình ảnh ở đây
                        print('Clicked on image');
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 56,
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/iconbag.png'),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 56,
                              alignment: Alignment.center,
                              child: Text(
                                'Mua sắm',
                                style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: 25,
                  ),

                ],
              ),
            ),

            Container(height: 20,),

            Container(
              height: 56,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 10,
                    child: Container(
                      width: (screenWidth - 20) / 2 - 10,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 249, 249, 249),
                        borderRadius: BorderRadius.circular(10)
                      ),

                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              'Liên kết ngân hàng',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'arial'
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              'Comming',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'arial',
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                      width: (screenWidth - 20) / 2 - 10,
                      height: 56,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 249, 249, 249),
                          borderRadius: BorderRadius.circular(10)
                      ),

                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              'Điểm thưởng',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'arial'
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              'Comming',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'arial',
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                height: 0.8 * screenWidth / 2.1,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    //ads1
                    Container(
                      height: 0.8 * screenWidth / 2.1,
                      width: 0.8 * screenWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Image.network(ad1,fit: BoxFit.cover,),
                    ),

                    Container(
                      height: 0.8 * screenWidth / 2.1,
                      width: 0.02 * screenWidth,
                    ),

                    //ads2
                    Container(
                      height: 0.8 * screenWidth / 2.1,
                      width: 0.8 * screenWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Image.network(ad2,fit: BoxFit.cover,),
                    ),

                    Container(
                      height: 0.8 * screenWidth / 2.1,
                      width: 0.02 * screenWidth,
                    ),

                    //ads3
                    Container(
                      height: 0.8 * screenWidth / 2.1,
                      width: 0.8 * screenWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Image.network(ad3,fit: BoxFit.cover,),
                    ),
                  ],
                ),
              ),
            ),

            Container(height: 30,),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                height: 340,
                decoration: BoxDecoration(

                ),

                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 312,
                      left: 0,
                      child: Text(
                        "Bạn muốn ăn gì đây?",
                        style: TextStyle(
                            fontFamily: 'arial',
                            color: Colors.deepOrange,
                            fontSize: screenWidth/18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 312,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENshopmain()));
                        },
                        child: Text(
                          'See all',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color.fromRGBO(0, 99, 255, 1),
                            fontFamily: 'Dmsan_regular',
                            fontSize: screenWidth / 20,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 1,
                          ),
                        ),
                      ),
                    ),


                    Positioned(
                      top: 50,
                      left: 0,
                      child: Container(
                        width: screenWidth,
                        height: 248,
                        decoration: BoxDecoration(
                            color: Colors.white
                        ),

                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: shopList.length,
                          itemBuilder: (BuildContext context, int index) {
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

                  ],
                ),
              ),
            ),

            Container(height: 0,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 177, 79),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          width: screenWidth/2.5,
                          child: Text(
                            compactString(23, ads1text),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'arial',
                                fontWeight: FontWeight.bold,
                                fontSize: 23
                            ),
                          ),
                        )
                    ),

                    Positioned(
                        bottom: 10,
                        left: 10,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENshopview(currentShop: shopList[ads1])));
                            },
                            child: Text(
                              "Xem ngay",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'arial',
                                  fontSize: 18,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1
                              ),
                            )
                        )
                    ),

                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(

                        ),
                        child: Image.network("https://firebasestorage.googleapis.com/v0/b/rabbitshipping-fa875.appspot.com/o/image%2Fads1.png?alt=media&token=df65b53b-c126-4972-9e57-fb3c4f5fc3bc",fit: BoxFit.fitHeight),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rabbitshipping/OTHER/Button/Buttontype1.dart';

import '../../GENERAL/utils/utils.dart';
import 'SCREEN_fillVerifyCodeMobile.dart';


class SCREENlogin extends StatefulWidget {
  const SCREENlogin({Key? key}) : super(key: key);

  @override
  State<SCREENlogin> createState() => _LoginScreenMobiState();
}

class _LoginScreenMobiState extends State<SCREENlogin> {
  TextEditingController countryController = TextEditingController();
  var phone = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = "";
  bool loading = false;

  @override
  void initState() {
    countryController.text = "+84";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/mainLogo.png')
                  )
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Đăng nhập bằng số điện thoại",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Nhập số điện thoại chính xác của bạn để đăng nhập Rabbit",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          phone = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Số điện thoại",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ButtonType1(Height: 45, Width: screenWidth - 50, color: Color.fromARGB(255, 244, 90, 36), radiusBorder: 10, title: "Nhận mã otp", fontText: 'arial', colorText: Colors.white,
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      try {
                        await _auth.verifyPhoneNumber(
                          phoneNumber: countryController.text + phone,
                          verificationCompleted: (PhoneAuthCredential credential) {
                            setState(() {
                              loading = false;
                            });
                            },
                          verificationFailed: (FirebaseAuthException e) {
                            setState(() {
                              loading = false;
                            });
                            toastMessage(e.toString());
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            setState(() {
                              this.verificationId = verificationId;
                              loading = false;
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SCREENverify(verificationId: verificationId, phoneNum: phone,),),);
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      } catch (e) {
                        setState(() {
                          loading = false;
                        });
                        toastMessage(e.toString());
                      }
                    }, loading: loading,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
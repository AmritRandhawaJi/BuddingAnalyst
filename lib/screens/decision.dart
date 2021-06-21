import 'dart:io';
import 'package:budding_analyst/screens/home.dart';
import 'package:budding_analyst/screens/loginScreen.dart';
import 'package:budding_analyst/screens/registerUi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

class Decision extends StatefulWidget {
  @override
  _DecisionState createState() => _DecisionState();
}

class _DecisionState extends State<Decision> {
  bool result = false;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [

                        Image.asset("assets/heading.png",width: MediaQuery.of(context).size.width/2,
                          height: MediaQuery.of(context).size.height/4,),

                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                        onPressed: () async {
                          if (Platform.isIOS) {
                            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => Home(),));
                          }
                          else if (Platform.isAndroid) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(),));
                          }
                        },
                        child: Text(
                          "Skip"
                        )),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Text(
                  "Our world of Analysis",
                  style: TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: deviceType == DeviceType.tablet ? 40 : 32,
                      fontFamily: "Arvo",),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Text(
                  "We aim to provide an integrated platform for varied communities of analysts coming from different disciplines to share their wisdom with the idea of promoting innovation and learning.",
                  style: TextStyle(
                      height: 1.5,
                      color: Colors.black,
                      fontSize: deviceType == DeviceType.tablet ? 18 :14,
                      fontFamily: "Arvo",
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                height: deviceType == DeviceType.tablet ? 60 :50,
                width: MediaQuery.of(context).size.width / 2.0,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          if (Platform.isIOS) {
                            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => LoginScreen(),));
                          }
                          else if (Platform.isAndroid) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
                          }


                        },
                        height: deviceType == DeviceType.tablet ? 60 :50,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.black),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          if (Platform.isIOS) {
                            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => RegisterUi(),));
                          }
                          else if (Platform.isAndroid) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterUi(),));
                          }


                        },
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        color: Colors.black,
                        height: deviceType == DeviceType.tablet ? 60 :50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

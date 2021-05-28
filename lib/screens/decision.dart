import 'dart:io';
import 'package:budding_analyst/screens/home.dart';
import 'package:budding_analyst/screens/loginScreen.dart';
import 'package:budding_analyst/screens/registerUi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Decision extends StatefulWidget {
  @override
  _DecisionState createState() => _DecisionState();
}

class _DecisionState extends State<Decision> {
  bool result = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                        child: Image.asset(
                      "assets/heading.png",
                      width: MediaQuery.of(context).size.width / 2.2,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                        onPressed: () async {
                          if (Platform.isIOS) {
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => RegisterUi(),
                                ));
                          }
                          if (Platform.isAndroid) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                          }
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Text(
                  "Our world of Analysis",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: "Arvo",
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Text(
                  "We aim to provide an integrated platform for varied communities of analysts coming from different disciplines to share their wisdom with the idea of promoting innovation and learning.",
                  style: TextStyle(
                      height: 1.5,
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: "Arvo",
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.8,
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
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          }
                         else if (Platform.isAndroid) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          }
                        },
                        height: 50,
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
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => RegisterUi(),
                                ));
                          }
                         else if (Platform.isAndroid) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterUi(),
                                ));
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
                        height: 50,
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

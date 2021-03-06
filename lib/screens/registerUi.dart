import 'dart:io';

import 'package:budding_analyst/assets/my_flutter_app_icons.dart';
import 'package:budding_analyst/model/networkState.dart';
import 'package:budding_analyst/screens/emailRegister.dart';
import 'package:budding_analyst/screens/loginScreen.dart';
import 'package:budding_analyst/screens/phoneOTP.dart';
import 'package:budding_analyst/widgets/internetAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class RegisterUi extends StatefulWidget {
  @override
  _RegisterUiState createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: 60.w,
                      height: 30.h,
                      child: Hero(tag: "headingTag",
                      child: Image.asset("assets/register.png")),
                    ),
                    Text(
                      "Let's create account",
                      style: TextStyle(fontSize: deviceType == DeviceType.tablet ? 30 : 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await NetworkState.state();
                        if (NetworkState.status()) {
                          if (Platform.isIOS) {
                            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => EmailRegister(),));
                          }
                          else if (Platform.isAndroid) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EmailRegister(),));
                          }
                        } else {
                          InternetError(context).show();
                        }
                      },
                      child: Text(
                        "Continue with email",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      color: Colors.black,
                      minWidth: MediaQuery.of(context).size.width / 1.2,
                      height: deviceType == DeviceType.tablet ? 60 : 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await NetworkState.state();
                        if (NetworkState.status()) {
                          if (Platform.isIOS) {
                            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => MobileAuthentication(),));
                          }
                          else if (Platform.isAndroid) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MobileAuthentication(),));
                          }
                        } else {
                          InternetError(context).show();
                        }
                      },
                      child: Text(
                        "Continue with phone number",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      color: Colors.black,
                      minWidth: MediaQuery.of(context).size.width / 1.2,
                      height: deviceType == DeviceType.tablet ? 60 : 50,
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                            child: Divider(
                              color: Colors.black,
                              height: deviceType == DeviceType.tablet ? 60.0 : 50,
                            )),
                      ),
                      Text("OR"),
                      Expanded(
                        child: new Container(
                            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                            child: Divider(
                              color: Colors.black,
                              height: deviceType == DeviceType.tablet ? 60 : 50,
                            )),
                      ),
                    ]),
                    MaterialButton(
                      onPressed: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MyFlutterApp.google,
                              color: Colors.blue,
                            ),

                            Text(
                              "Continue with google",
                            ),
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      color: Colors.white,
                      minWidth: MediaQuery.of(context).size.width / 1.2,
                      height: deviceType == DeviceType.tablet ? 60 : 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MyFlutterApp.facebook,
                              color: Colors.blue,
                            ),
                            Text(
                              "Continue with facebook",
                            ),
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      color: Colors.white,
                      minWidth: MediaQuery.of(context).size.width / 1.2,
                      height: deviceType == DeviceType.tablet ? 60 : 50,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(

                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text("Already have an account?",style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(onPressed: (){
                          if (Platform.isIOS) {
                            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => LoginScreen(),));
                          }
                          else if (Platform.isAndroid) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
                          }
                        }, child: Text("Login"))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

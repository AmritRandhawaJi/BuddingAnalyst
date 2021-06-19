import 'dart:io';

import 'package:budding_analyst/widgets/alert.dart';
import 'package:budding_analyst/widgets/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'home.dart';

class EmailVerification extends StatefulWidget {
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    if (!user.emailVerified) {
      user.sendEmailVerification();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Sizer(
          builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Image.asset("assets/emailVerification.png")),
                ),
                Text(
                  "One step to go",
                  style: TextStyle(fontSize: 22.0, fontFamily: "Ubuntu"),
                ),
                Text(
                  "You are all set.",
                  style: TextStyle(fontSize: 18.0),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    "An email has been sent to you, Please check your inbox to verify your account.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Text(
                  "I have verified email proceed.",
                  style: TextStyle(fontSize: deviceType == DeviceType.tablet ? 18 : 14),
                ),

                MaterialButton(
                  onPressed: () {
                    if (!user.emailVerified) {
                      Error(context, "Email not verified",
                          "Please check inbox and tap to verify", "Ok", "Skip for now")
                          .show();
                    }
                    else if (user.emailVerified){
                      if (Platform.isIOS) {
                        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => Home(),));
                      }
                      else if (Platform.isAndroid) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(),));
                      }

                    }

                  },
                  height: deviceType == DeviceType.tablet ? 60 : 50,
                  minWidth: MediaQuery.of(context).size.width / 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: Colors.black,
                  child: Text("Proceed",style: TextStyle(color: Colors.white),),
                ),
                Text("Email not received?"),
                MaterialButton(onPressed: (){
                  user.sendEmailVerification();
                  Alerts("Verification link has been sent again.", "Email Resend", context).show();

                },               shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),color: Colors.white,height: deviceType == DeviceType.tablet ? 60 :50,child: Text("Resend email"),)
              ],
            );
          },
        ),
      ),
    );
  }
}

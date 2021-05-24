import 'package:budding_analyst/widgets/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        child: Column(
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
            SizedBox(
              height: 10.0,
            ),
            Text(
              "You are all set.",
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 25.0,),
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
            SizedBox(
              height: 40.0,
            ),
            Text(
              "I have verified email.",
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              onPressed: () {
                if (!user.emailVerified) {
                  Error(context, "Email not verified",
                          "Please check inbox and tap to verify", "Ok", "Skip for now")
                      .show();
                } else {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
                }
              },
              height: 50.0,
              minWidth: MediaQuery.of(context).size.width / 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              color: Colors.white,
              child: Text("Proceed"),
            )
          ],
        ),
      ),
    );
  }
}

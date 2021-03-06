import 'dart:io';

import 'package:budding_analyst/assets/my_flutter_app_icons.dart';
import 'package:budding_analyst/model/networkState.dart';
import 'package:budding_analyst/screens/emailLoginUi.dart';
import 'package:budding_analyst/screens/phoneOTP.dart';
import 'package:budding_analyst/screens/registerUi.dart';
import 'package:budding_analyst/widgets/internetAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:     Center(
            child: Text(
              "Welcome",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Ubuntu"),
            )),
        backgroundColor: Colors.black,
        toolbarHeight: MediaQuery.of(context).size.height / 3.5,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only( bottomLeft: Radius.circular(100))
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: () async {
                await NetworkState.state();
                if (NetworkState.status()) {
                  if (Platform.isIOS) {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                      builder: (context) => EmailLoginUI(),
                    ));
                  } else if (Platform.isAndroid) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => EmailLoginUI(),
                    ));
                  }
                } else {
                  InternetError(context).show();
                }
              },
              child: Text(
                "Login with email",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Colors.black,
              minWidth: MediaQuery.of(context).size.width / 1.2,
              height: 50,
            ),
            MaterialButton(
              onPressed: () async {
                await NetworkState.state();
                if (NetworkState.status()) {
                  if (Platform.isIOS) {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                      builder: (context) => MobileAuthentication(),
                    ));
                  } else if (Platform.isAndroid) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MobileAuthentication(),
                    ));
                  }
                } else {
                  InternetError(context).show();
                }
              },
              child: Text(
                "Login with phone number",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Colors.black,
              minWidth: MediaQuery.of(context).size.width / 1.2,
              height: 50,
            ),
            Row(children: <Widget>[
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Divider(
                      color: Colors.black,
                      height: 50,
                    )),
              ),
              Text("OR"),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 50,
                    )),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Icon(
                    MyFlutterApp.google,
                    color: Colors.blue,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Colors.white,
                  height: 50,
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Icon(
                    MyFlutterApp.facebook,
                    color: Colors.blue,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Colors.white,
                  height: 50,
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text("Don't have an account?",
                      style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                    onPressed: () {
                      if (Platform.isIOS) {
                        Navigator.of(context)
                            .pushReplacement(CupertinoPageRoute(
                          builder: (context) => RegisterUi(),
                        ));
                      } else if (Platform.isAndroid) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => RegisterUi(),
                        ));
                      }
                    },
                    child: Text("Register"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:budding_analyst/assets/my_flutter_app_icons.dart';
import 'package:budding_analyst/model/mover.dart';
import 'package:budding_analyst/model/networkState.dart';
import 'package:budding_analyst/screens/emailLoginUi.dart';
import 'package:budding_analyst/screens/emailRegister.dart';
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: MyPainter(),
                child: Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          "Welcome",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Ubuntu"),
                        )),
                      ],
                    )),
              ),
              SizedBox(
                height: 50,
              ),
              MaterialButton(
                onPressed: () async {
                  await NetworkState.state();
                  if (NetworkState.status()) {
                    Mover.move(context,EmailLoginUI());
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
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () async {
                  await NetworkState.state();
                  if (NetworkState.status()) {
                    Mover.move(context,MobileAuthentication());
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
              SizedBox(
                height: 20.0,
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
                     Mover.move(context,RegisterUi());
                      },
                      child: Text("Register"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 class MyPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 70);
    var controlPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

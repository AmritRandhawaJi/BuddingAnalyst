
import 'package:budding_analyst/screens/home.dart';
import 'package:budding_analyst/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      backgroundColor: Color(0xff19171F),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  TextButton(onPressed: ()async {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
                }, child: Text("Skip")),],
              ),
              Hero(
                  tag: "headingTag",
                  child: Center(
                      child: Image.asset(
                    "assets/headingWhite.png",
                    width: MediaQuery.of(context).size.width / 2,
                  ))),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Text(
                  "Our world of Analsys",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: "Arvo",
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Text(
                  "We aim to provide an integrated platform for varied communities of analysts coming from different disciplines to share their wisdom with the idea of promoting innovation and learning.",
                  style: TextStyle(height: 2,
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Arvo",
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  MaterialButton(
                    elevation: 34,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Colors.white,
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.black),
                    ),
                    height: 50.0,
                    minWidth: MediaQuery.of(context).size.width / 1.6,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Colors.white30,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    height: 50.0,
                    minWidth: MediaQuery.of(context).size.width / 1.8,
                  ),SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

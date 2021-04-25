import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Hero(tag: "headingTag",
                child: Center(child: Image.asset("assets/heading.png",height: 200.0,width: 200.0,))),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
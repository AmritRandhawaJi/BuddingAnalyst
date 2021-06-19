import 'dart:io';

import 'package:budding_analyst/screens/decision.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
             MaterialButton(onPressed: ()async {
               await FirebaseAuth.instance.signOut();
               if (Platform.isIOS) {
                 Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => Decision(),));
               }
               else if (Platform.isAndroid) {
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Decision(),));
               }
             },child: Text("Sign out"),)
            ],
          ),
        ),
      ),
    );
  }
}

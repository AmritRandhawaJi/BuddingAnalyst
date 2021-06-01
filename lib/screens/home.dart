import 'package:budding_analyst/model/mover.dart';
import 'package:budding_analyst/screens/decision.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
               Mover.move(context, Decision());
             },child: Text("Sign out"),)
            ],
          ),
        ),
      ),
    );
  }
}

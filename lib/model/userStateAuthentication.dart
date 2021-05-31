import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserStateAuthentication extends StatefulWidget {
  @override
  _UserStateAuthenticationState createState() =>
      _UserStateAuthenticationState();
}

class _UserStateAuthenticationState extends State<UserStateAuthentication> {
  @override
  void initState() {
    _authenticator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black)),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _authenticator() async {
      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value){
        if(value.data()!= null){
          print("old user");
        }else{
          print("new user");
        }
      });


  }
}

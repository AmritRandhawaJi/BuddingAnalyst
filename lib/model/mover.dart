import 'dart:async';
import 'dart:io';
import 'package:budding_analyst/screens/decision.dart';
import 'package:budding_analyst/screens/gettingStarted.dart';
import 'package:budding_analyst/screens/home.dart';
import 'package:budding_analyst/widgets/indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mover extends StatefulWidget {
  const Mover({Key? key}) : super(key: key);

  @override
  _MoverState createState() => _MoverState();
}

class _MoverState extends State<Mover> {
  late Timer timer;
 @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((_firebaseUser) {
      if(_firebaseUser != null) {
        if (Platform.isIOS) {
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (context) => Home(),));
        }
        else if (Platform.isAndroid) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Home(),));
        }
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      timer = Timer(Duration(seconds: 2), (){
     _authenticator();
     });
    });
    return Center(child: Indicator());
  }

  void _authenticator() async {
   final value =  await SharedPreferences.getInstance();
    if(value.getInt("userState") != 1) {
      if (Platform.isIOS) {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => GettingStartedScreen(),));
      }
     else if (Platform.isAndroid) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GettingStartedScreen(),));
      }
    }
    else{
      if (Platform.isIOS) {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => Decision(),));
      }
      else if (Platform.isAndroid) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Decision(),));
      }
    }
  }
}

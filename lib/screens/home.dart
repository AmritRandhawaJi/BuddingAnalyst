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
    return CupertinoTabScaffold(tabBar: CupertinoTabBar(items: [
BottomNavigationBarItem(icon: Icon(Icons.home),backgroundColor: Colors.black,label: "Home"),
BottomNavigationBarItem(icon: Icon(Icons.apps),backgroundColor: Colors.black,label: "Courses"),
BottomNavigationBarItem(icon: Icon(Icons.album_rounded),backgroundColor: Colors.black,label: "Live"),
BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),backgroundColor: Colors.black,label: "Account"),

    ],), tabBuilder: (context, index) => AccountSetting(),);
  }
}

class AccountSetting extends StatelessWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(height: 100,width: 100,child: CircleAvatar(backgroundColor: Colors.grey,child: Image.asset("assets/headingWhite.png"),)),
            Text("Amrit Randhawa",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: "Ubuntu"),)
            ],
          ),
            SizedBox(height: 30.0,),
            CupertinoButton(color: Colors.black,onPressed: ()async {
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
    );
  }
}

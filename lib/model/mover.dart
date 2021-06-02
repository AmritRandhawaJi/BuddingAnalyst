
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mover {
 static void move(BuildContext context, Widget screen){
    if (Platform.isIOS) {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => screen,));
    }
    else if (Platform.isAndroid) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => screen,));
    }
  }
 static void moveCanPop(BuildContext context, Widget screen){
   if (Platform.isIOS) {
     Navigator.of(context).push(CupertinoPageRoute(builder: (context) => screen,));
   }
   else if (Platform.isAndroid) {
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen,));
   }
 }
}

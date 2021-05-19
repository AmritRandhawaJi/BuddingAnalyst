
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InternetError{
 BuildContext context;
 InternetError(this.context);

 void show(){
  if(Platform.isIOS){
    showCupertinoDialog(context: context, builder: (context) => alert(),barrierDismissible: false);
  }if(Platform.isAndroid){
    showDialog(context: context, builder: (context) => alert(),barrierDismissible: false);
  }
}
 Widget alert(){
  return Platform.isIOS ? CupertinoAlertDialog(
    content: Text("internet required"),
    actions: [
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text("Ok"))
    ],
  ):AlertDialog(
    title: Text("No internet"),
    content: Text("Check your internet connection"),
    actions: [
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text("Ok"))
    ],
  );
}


}
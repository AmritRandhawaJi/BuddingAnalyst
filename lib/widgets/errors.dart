
import 'dart:io';

import 'package:budding_analyst/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Error{
  BuildContext context;
  String title;
  String content;
  String errorRight;
  String errorLeft;


  Error(this.context, this.title,this.content, this.errorRight, this.errorLeft);

  void show(){
    if(Platform.isIOS){
      showCupertinoDialog(context: context, builder: (context) => alert(),barrierDismissible: false);
    }if(Platform.isAndroid){
      showDialog(context: context, builder: (context) => alert(),barrierDismissible: false);
    }
  }
  Widget alert(){
    return Platform.isIOS ? CupertinoAlertDialog(
      content: Text(content),
      title: Text(title),
      actions: [
        TextButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
        }, child: Text(errorLeft)),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text(errorRight))
      ],
    ):AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
        }, child: Text(errorLeft)),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text(errorRight))
      ],
    );
  }


}
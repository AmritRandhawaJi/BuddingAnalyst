import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alerts{

  String content;
  String title;
  BuildContext context;


  Alerts(this.content, this.title, this.context);

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
          Navigator.pop(context);
        }, child: Text("Ok")),

      ],
    ):AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Ok"))
      ],
    );
  }

}
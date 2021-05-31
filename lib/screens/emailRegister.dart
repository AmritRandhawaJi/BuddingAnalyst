import 'dart:io';

import 'package:budding_analyst/model/slideUpFolding.dart';
import 'package:budding_analyst/screens/registerUi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EmailRegister extends StatefulWidget {
  @override
  _EmailRegisterState createState() => _EmailRegisterState();
}
class _EmailRegisterState extends State<EmailRegister> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
        body: SlidingUpPanel(
          parallaxEnabled: true,
          parallaxOffset: 4.0,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
          minHeight: MediaQuery.of(context).size.height / 1.8,
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(onPressed: (){
                      if (Platform.isIOS) {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => RegisterUi()
                              ,
                            ));
                      } else if (Platform.isAndroid) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterUi(),
                            ));
                      }
                    }, child: Icon(Icons.close,color: Colors.black,),)
                  ],
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      "Create Better Together.",
                      style: TextStyle(
                          fontSize: 35.0, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      "Join our community",
                      style: TextStyle(fontSize: 16.0),
                    )),


              ],
            ),
          ),
          panelBuilder: (controller) => SlideUpPage(
            controller: controller,
          ),
        ));
  }
}


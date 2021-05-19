import 'package:budding_analyst/screens/registerUi.dart';
import 'package:flutter/material.dart';

class MobileAuthentication extends StatefulWidget {


  @override
  _MobileAuthenticationState createState() => _MobileAuthenticationState();
}

class _MobileAuthenticationState extends State<MobileAuthentication> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
      children: [
          Row(
            children: [
              TextButton(onPressed: (){
                Navigator.pop(context);

              }, child: Icon(Icons.close,color: Colors.black,))
            ],
          ),
      ],
    ),
        ));
  }
}

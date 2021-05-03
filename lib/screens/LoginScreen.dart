import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: AppBar(elevation: 0,backgroundColor: Colors.indigo,),
        endDrawer: Drawer(
          child: ListView(
            children: [
              Text("Hello"),
              Text("World"),
              Text("Hello"),
              Text("Hello"),
              Text("Hello"),
              Text("Hello"),
            ],
          ),
        ),
      ),
    );
  }
}
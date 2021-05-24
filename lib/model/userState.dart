import 'package:budding_analyst/model/networkState.dart';
import 'package:budding_analyst/screens/decision.dart';
import 'package:budding_analyst/screens/gettingStarted.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserState extends StatefulWidget {
  @override
  _UserStateState createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {
   bool result = false;


void getData() async {
  final value =  await SharedPreferences.getInstance();
  if(value.getInt("userState") == 1){
    setState(() {
      result = true;
    });
  }
}
  @override
  void initState()  {
    super.initState();
 getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: result ? Decision() : GettingStartedScreen(),
    );
  }

}

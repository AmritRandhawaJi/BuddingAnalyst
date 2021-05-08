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

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: result ? Decision() : GettingStartedScreen(),
    );
  }
  Future<bool> getData()async{
    final value = await SharedPreferences.getInstance();
   if(value.getInt("userState") == 1){
     setState(() {
       result = true;
     });
   }
   else{
     setState(() {
       result = false;
     });
   }
   return false;
  }
}

import 'package:budding_analyst/model/networkState.dart';
import 'package:budding_analyst/screens/decision.dart';
import 'package:budding_analyst/screens/gettingStarted.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserState extends StatefulWidget {
final  bool _result;

  UserState(this._result);

  @override
  _UserStateState createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._result ? Decision() : GettingStartedScreen(),
    );
  }

}

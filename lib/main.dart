import 'package:budding_analyst/model/userState.dart';
import 'package:budding_analyst/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    runApp(MyApp());

}
class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _result = false;
  bool _state = false;

  void _getData() async {
    final value =  await SharedPreferences.getInstance();
    if(value.getInt("userState") == 1) {
      setState(() {
        _state = true;
      });
    }
    }

  @override
  void initState()  {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      if(firebaseUser !=null){
        setState(() {
          _result = true;
        });
      }else{
          _getData();
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home:  Scaffold(
        body: _result ? Home() : UserState(_state))
    );
  }
}



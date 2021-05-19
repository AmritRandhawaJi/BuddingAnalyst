import 'package:budding_analyst/model/userState.dart';
import 'package:budding_analyst/screens/decision.dart';
import 'package:budding_analyst/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


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
  @override

  @override
  void initState()  {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      if(firebaseUser !=null){
        setState(() {
        _result = true;
        });
      }else{
        setState(() {
          _result = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home:  Scaffold(
        body: _result ? Home() : UserState())
    );
  }
}



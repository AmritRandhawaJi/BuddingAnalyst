import 'package:firebase_auth/firebase_auth.dart';

Future<void> signIn(String email, String password) async {

}

Future<void> signUp(String email, String password) async {
  try{

  } on FirebaseAuthException catch(e){
    if(e.code == "weak-password"){
      print("choose strong password");
    }
    else if (e.code == "email-already-in-use"){
      print("already in use");
    }
  }
  catch(e){

  }
}
import 'package:budding_analyst/assets/my_flutter_app_icons.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> stateKey = GlobalKey<FormState>();
  GlobalKey<FormState> stateKey2 = GlobalKey<FormState>();

  bool hiddenState = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Form(
              key: stateKey,
              child: TextFormField(

                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (email!.isEmpty) {
                    return "Email is required";
                  }
                 else if (!EmailValidator.validate(email)) {
                    return "Email invalid";
                  }

                  else{
                    return null;
                  }
                },
                autofillHints: [AutofillHints.email],
                controller: emailController,
                decoration: InputDecoration(
                    filled: hiddenState,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    hintText: "What's your email address?",
                    hintStyle: TextStyle(color: Colors.black),
                    suffixIcon: GestureDetector(
                      child: Icon(Icons.close), onTap: () {
                      emailController.text = "";
                    },),
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.black)),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Form(
              key: stateKey2,
              child: TextFormField(
                obscureText: hiddenState,
                validator: (password) {
                  if (password!.isEmpty) {
                    return "Password required";
                  }
                 else if (password.length < 8) {
                    return "Minimum 8 characters required";
                  }

                  else{
                  return null;

                  }
                },
                controller: passwordController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    hintText: "Enter a password",
                    suffixIcon: GestureDetector(
                      child: hiddenState ? Icon(MyFlutterApp.eye_slash) : Icon(
                          MyFlutterApp.eye),
                      onTap: () {
                        setState(() {
                          if (hiddenState) {
                            hiddenState = false;
                          }
                          else {
                            hiddenState = true;
                          }
                        });
                      },),
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.lock_outline),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black)),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            MaterialButton(
              onPressed: () {
                stateKey.currentState!.validate();
                stateKey2.currentState!.validate();

              },

              child: Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              height: 40.0,
              minWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 2,
            )
          ],
        ),
      ),
    );
  }


  Future<bool> firebaseValidation() async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          return false;
        } else if (e.code == 'email-already-in-use') {
          return false;
        }
        else{
          return true;
        }
      } catch (e) {
        print(e);
      }
      return true;
    }

  }

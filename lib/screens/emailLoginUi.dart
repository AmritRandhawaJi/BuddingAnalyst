import 'dart:io';

import 'package:budding_analyst/screens/forgetScreen.dart';
import 'package:budding_analyst/screens/loginScreen.dart';
import 'package:budding_analyst/screens/registerUi.dart';
import 'package:budding_analyst/widgets/indicator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class EmailLoginUI extends StatefulWidget {
  @override
  _EmailLoginUIState createState() => _EmailLoginUIState();
}

class _EmailLoginUIState extends State<EmailLoginUI> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> stateKey = GlobalKey<FormState>();
  GlobalKey<FormState> stateKey2 = GlobalKey<FormState>();

  bool hiddenState = true;
  bool emailResult = false;
  bool passwordResult = false;

  bool buttonState = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _firebaseValidation() async {
    String id = emailController.text;
    String pass = passwordController.text;
    try {
      setState(() {
        buttonState = true;
      });
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: id, password: pass);
      if (Platform.isIOS) {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => Home(),));
      }
      else if (Platform.isAndroid) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(),));
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        buttonState = false;
      });
      if (e.code == "user-not-found") {
        emailResult = true;
        stateKey.currentState!.validate();
      } else if (e.code == "wrong-password") {
        passwordResult = true;
        stateKey2.currentState!.validate();
      }
      setState(() {
        stateKey.currentState!.validate();
        stateKey2.currentState!.validate();
        buttonState = false;
        emailResult = false;
        passwordResult = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    if (Platform.isIOS) {
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => LoginScreen(),));
                    }
                    else if (Platform.isAndroid) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
                    }
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Form(
              key: stateKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email!.isEmpty) {
                      return "Email is required";
                    } else if (!EmailValidator.validate(email)) {
                      return "Email invalid";
                    } else if (emailResult) {
                      return "No user found";
                    } else {
                      return null;
                    }
                  },
                  autofillHints: [AutofillHints.email],
                  controller: emailController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "What's your email address?",
                      hintStyle: TextStyle(color: Colors.black),
                      suffixIcon: GestureDetector(
                        child: Icon(Icons.close),
                        onTap: () {
                          emailController.text = "";
                        },
                      ),
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Form(
              key: stateKey2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: TextFormField(
                  obscureText: hiddenState,
                  validator: (password) {
                    if (password!.isEmpty) {
                      return "Password required";
                    } else if (password.length < 8) {
                      return "Enter minimum 8 characters";
                    } else if (passwordResult) {
                      return "Wrong password";
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Enter a password",
                      suffixIcon: GestureDetector(
                        child: hiddenState
                            ? Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.black87,
                              )
                            : Icon(
                                Icons.remove_red_eye,
                                color: Colors.black,
                              ),
                        onTap: () {
                          setState(() {
                            if (hiddenState) {
                              hiddenState = false;
                            } else {
                              hiddenState = true;
                            }
                          });
                        },
                      ),
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.lock_outline),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: buttonState ? Indicator() : null,
            ),
            SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              onPressed: buttonState
                  ? null
                  : () async {
                      if (stateKey.currentState!.validate() &
                          stateKey2.currentState!.validate()) {
                        _firebaseValidation();
                      }
                    },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              elevation: 5,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              height: 40.0,
              minWidth: MediaQuery.of(context).size.width / 2,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("Don't have an account?"),
            TextButton(
              onPressed: () {
                if (Platform.isIOS) {
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => RegisterUi(),));
                }
                else if (Platform.isAndroid) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterUi(),));
                }
              },
              child: Text("Register",
                  style: TextStyle(fontSize: 14.0)),
            ),
            SizedBox(
              height: 30.0,
            ),
            Column(
              children: [
                Text("Trouble logging in?"),
                TextButton(
                    onPressed: () {
                      if (Platform.isIOS) {
                        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => ForgetPassword(),));
                      }
                      else if (Platform.isAndroid) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ForgetPassword(),));
                      }
                    },
                    child: Text("Forget password"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

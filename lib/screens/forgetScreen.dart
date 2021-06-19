import 'dart:io';

import 'package:budding_analyst/screens/decision.dart';
import 'package:budding_analyst/widgets/alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> stateKey = GlobalKey();

  bool buttonState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    if (Platform.isIOS) {
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (context) => Decision(),
                      ));
                    } else if (Platform.isAndroid) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Decision(),
                      ));
                    }
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Container(
              child: Image.asset("assets/headingWhite.png"),
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 3.5,
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
                    }
                    // else if (emailResult) {
                    //   return "No user found";
                    // }
                    else {
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
                      labelText: "Enter your email",
                      labelStyle: TextStyle(color: Colors.black)),
                ),
              ),
            ),

            Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Text(
                  "Forget password? don't worry we'll assist you.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Ubuntu"),
                )),

            MaterialButton(
              onPressed: buttonState
                  ? null
                  : () async {
                      if (stateKey.currentState!.validate()) {
                        setState(() {
                          buttonState = false;
                        });
                        FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                       Alerts("We have sent an email please follow steps to reset password.","Email Reset",context).show();

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
            Text(
              "Need more help?",
              style: TextStyle(color: Colors.white),
            ),
            TextButton(
                onPressed: () {
                  Alerts(
                    "Write your concern at Helpdesk@buddinganalyst.com",
                    "Customer Support",
                    context,
                  ).show();
                },
                child: Text("Customer support",
                    style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
  _userAvailability(){

  }
}

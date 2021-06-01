import 'package:budding_analyst/model/mover.dart';
import 'package:budding_analyst/screens/decision.dart';
import 'package:email_validator/email_validator.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Mover.move(context, Decision());
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
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: buttonState
                  ? null
                  : () async {
                      if (stateKey.currentState!.validate()) {
                        setState(() {
                          buttonState = true;
                        });
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
          ],
        ),
      ),
    );
  }
}

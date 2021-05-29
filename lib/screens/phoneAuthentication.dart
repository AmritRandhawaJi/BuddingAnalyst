import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneAuthFirebase extends StatefulWidget {
  final String number;

  PhoneAuthFirebase(this.number);

  @override
  _PhoneAuthFirebaseState createState() => _PhoneAuthFirebaseState();
}

class _PhoneAuthFirebaseState extends State<PhoneAuthFirebase> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .width / 1.5,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.5,
                    child: Image.asset("assets/mobileHeading.png")),
                SizedBox(
                  height: 25,
                ),
                Container(child: Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black)),),

                SizedBox(height: 10,),
                Text(
                    "An one time password has been sent"
                ), SizedBox(height: 10,),
                Text(
                  widget.number, style: TextStyle(color: Colors.black87),
                ), SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: PinCodeTextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      appContext: context,
                      length: 6,
                      onChanged: (value) {}),
                ),
                SizedBox(height: 25,),
                MaterialButton(
                  onPressed: () {
                    _mobileAuthFirebase(widget.number);
                  },
                  height: 50,
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Proceed", style: TextStyle(color: Colors.white),),)
              ],
            ),
          ),
        )
    );
  }

  //   _mobileAuthFirebase(String number) async {
  //     await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: '+44 7123 123 456',
  //       verificationCompleted: (PhoneAuthCredential credential) {
  //         //Android only
  //
  //       },
  //       verificationFailed: (FirebaseAuthException e) {},
  //       codeSent: codeSent(),
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  // }
  // codeSent(String verificationID, int resendToken) {
  //
  // }

}


import 'dart:async';
import 'dart:io';
import 'package:budding_analyst/model/userStateAuthentication.dart';
import 'package:budding_analyst/screens/decision.dart';
import 'package:budding_analyst/screens/phoneOTP.dart';
import 'package:budding_analyst/widgets/alert.dart';
import 'package:budding_analyst/widgets/indicator.dart';
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
  late String _verificationCode;
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> otpKey = GlobalKey();
  bool _buttonState = true;

  @override
  void initState() {
    _mobileAuthFirebase(widget.number);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
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
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 2,
                child: Image.asset("assets/mobileHeading.png")),
            Container(
              child: Indicator(),
            ),
            Text("An one time password has been sent"),
            Text(
              widget.number,
              style: TextStyle(color: Colors.black87),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Form(
                key: otpKey,
                child: PinCodeTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter otp";
                    } else if (value.length != 6) {
                      return "Enter 6 digits otp";
                    } else {
                      return null;
                    }
                  },
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  appContext: context,
                  length: 6,
                  onChanged: (String value) {},
                ),
              ),
            ),
            Center(
              child: Container(
                child: _buttonState
                    ? MaterialButton(
                        onPressed: () async {
                          if (otpKey.currentState!.validate()) {
                            _signInManual();
                            setState(() {
                              _buttonState = false;
                            });
                          }
                        },
                        height: 50,
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Proceed",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : MaterialButton(
                        onPressed: () {},
                        height: 50,
                        color: Colors.grey,
                        disabledTextColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Proceed",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ),
            Column(
              children: [
                Text("Didn't get code?", style: TextStyle(color: Colors.black)),
                TextButton(
                    onPressed: () {
                      _mobileAuthFirebase(widget.number);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("OTP Resend")));
                    },
                    child: Text("Resend"))
              ],
            ),
            TextButton(
                onPressed: () {
                  Alerts("Write your concern at Helpdesk@Buddinganalyst.com",
                          "Customer support", context)
                      .show();
                },
                child: Text("Need help?"))
          ],
        ),
      ),
    );
  }

  Future<void> _mobileAuthFirebase(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        _signInWithAutoVerify(credential);
      },
      timeout: const Duration(seconds: 60),
      verificationFailed: (FirebaseAuthException e) async {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      },
      codeSent: (verificationId, resendToken) async {
        this._verificationCode = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<void> _signInWithAutoVerify(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        _buttonState = false;
      });
      if (Platform.isIOS) {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => UserStateAuthentication(),));
      }
      else if (Platform.isAndroid) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserStateAuthentication(),));
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        _buttonState = true;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  Future<void> _signInManual() async {
    final phoneAuth = PhoneAuthProvider.credential(
        verificationId: _verificationCode, smsCode: otpController.text);
    try {
      setState(() {
        _buttonState = false;
      });
      await FirebaseAuth.instance.signInWithCredential(phoneAuth);
      if (Platform.isIOS) {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => UserStateAuthentication(),));
      }
      else if (Platform.isAndroid) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserStateAuthentication(),));
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        _buttonState = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 5), content: Text(e.message.toString())));
    }
  }

}

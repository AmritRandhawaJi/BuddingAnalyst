import 'dart:io';
import 'package:budding_analyst/screens/phoneAuthentication.dart';
import 'package:budding_analyst/screens/registerUi.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MobileAuthentication extends StatefulWidget {
  @override
  _MobileAuthenticationState createState() => _MobileAuthenticationState();
}

class _MobileAuthenticationState extends State<MobileAuthentication> {
  String countryCode = "+91";
  TextEditingController numberField = TextEditingController();
  GlobalKey<FormState> phoneAuthKey = GlobalKey<FormState>();

  bool check = false;
  @override
  void dispose() {
    numberField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebf2ff),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    if (Platform.isIOS) {
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => RegisterUi(),));
                    }
                    else if (Platform.isAndroid) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterUi(),));
                    }

                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Text(
              "Verify your phone number",
              style: TextStyle(fontSize: 18),
            ),
            Container(
                height: MediaQuery.of(context).size.width / 1.7,
                width: MediaQuery.of(context).size.width / 1.7,
                child: Image.asset("assets/phoneHeading.png")),

            Center(
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Form(
                  key: phoneAuthKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone number required.";
                      } else if (value.length < 10) {
                        return "Enter 10 digits.";
                      } else {
                        return null;
                      }
                    },
                    controller: numberField,
                    maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    autofillHints: [AutofillHints.telephoneNumber],
                    decoration: InputDecoration(
                        prefixIcon: CountryCodePicker(
                          onChanged: (value) {
                            countryCode = value.toString();
                          },
                          initialSelection: 'IN',
                          favorite: ['+91', 'IN'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                        border: OutlineInputBorder(),
                        filled: true,
                        suffixIcon: check
                            ? Icon(Icons.check, color: Colors.green)
                            : Icon(null),
                        fillColor: Colors.white,
                        hintText: "Number",
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Text(
                  "We will send a one time password on your mobile number."),
            ),
            MaterialButton(
              onPressed: () {
                if (phoneAuthKey.currentState!.validate()) {
                  String number = countryCode + numberField.text;
                  if (Platform.isIOS) {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                      builder: (context) => PhoneAuthFirebase(number),
                    ));
                  } else if (Platform.isAndroid) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PhoneAuthFirebase(number),
                    ));
                  }
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 50.0,
              minWidth: MediaQuery.of(context).size.width / 3,
              color: Colors.blue,
              child: Text(
                "Get OTP",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

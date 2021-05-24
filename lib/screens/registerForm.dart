import 'package:budding_analyst/screens/emailVerification.dart';
import 'package:budding_analyst/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budding_analyst/model/registerFormData.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  User user = FirebaseAuth.instance.currentUser!;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  GlobalKey<FormState> firstNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> lastNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> ageKey = GlobalKey<FormState>();
  var _data;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
              SizedBox(
              height: 20.0,
            ),
            Text(
              "Almost Done!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
            ),
            Stack(

              children: [

                Column(
                  children: [
                    Container(
                      child: Image.asset("assets/formHeading.png"),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 3.5,
                    ),
                  ],
                ),

              ],
            ),
            Text(
              "What's your name?",
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(
              height: 20.0,
            ),
            Form(
              key: firstNameKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter first name";
                    } else {
                      return null;
                    }
                  },
                  autofillHints: [AutofillHints.name],
                  controller: firstNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: "First Name",
                      labelStyle: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Form(
              key: lastNameKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter last name";
                    } else {
                      return null;
                    }
                  },
                  controller: lastNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: "Last Name",
                      labelStyle: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Form(
              key: ageKey,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2,
                child: DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value != null) {
                      return null;
                    } else {
                      return "please select age";
                    }
                  },
                  icon: Icon(Icons.calendar_today),
                  focusColor: Colors.white,
                  value: _data,
                  //elevation: 5,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: SpinnerData()
                      .spinnerItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Age?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _data = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              onPressed: () {
                if (firstNameKey.currentState!.validate() &&
                    lastNameKey.currentState!.validate() &&
                    ageKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  _createDatabase();
                }
              },
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white),
              ),
              minWidth: MediaQuery
                  .of(context)
                  .size
                  .width / 3,
              color: Colors.blue,
              height: 50.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),SizedBox(
                  height: 10.0,
                ),
            Container(child: loading ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),) : null,)

                ]),
          )),
    );
  }

  _createDatabase() async {
    FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "first name": firstNameController.value.text,
      "last name": lastNameController.value.text,
      "email": user.email,
      "age": _data,
      "registration": DateTime.now()
    }, SetOptions(merge: true)).then((_) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => EmailVerification(),));
    });
  }
}

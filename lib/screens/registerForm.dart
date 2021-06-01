import 'dart:io';
import 'package:budding_analyst/model/mover.dart';
import 'package:budding_analyst/model/registerFormData.dart';
import 'package:budding_analyst/screens/emailVerification.dart';
import 'package:budding_analyst/widgets/indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  var _age;

  bool loading = false;
  var _gender = "Male";

  @override
  void initState() {
    _age = "18";
    super.initState();
  }

  @override
  void dispose() {
    FirebaseFirestore.instance.terminate();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Almost Done!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          Column(
            children: [
              Container(
                child: Image.asset("assets/formHeading.png"),
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 3.5,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: firstNameKey,
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
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: lastNameKey,
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
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.amberAccent[100],
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Column(
                children: [
                  Center(
                      child: Text(
                    "Select gender",
                    style: TextStyle(color: Colors.black),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: ListTile(
                          title: const Text('Male'),
                          leading: Radio(
                            value: "Male",
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value.toString();
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: ListTile(
                          title: const Text('Female'),
                          leading: Radio(
                            value: "Female",
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value.toString();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "My age is",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                " $_age",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              )
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Platform.isIOS
                ? CupertinoPicker(
                    itemExtent: 30,
                    onSelectedItemChanged: (value) {
                      int data = value + 18;
                      setState(() {
                        _age = data;
                      });
                    },
                    children: [
                        for (int i = 18; i <= 70; i++) Text("$i"),
                      ])
                : Form(
                    key: ageKey,
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value != null) {
                          return null;
                        } else {
                          return "Select age";
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _age = value;
                        });
                      },
                      value: _age,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),

                      items: SpinnerData.spinnerItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        "Age?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: 25.0,
          ),
          MaterialButton(
            onPressed: () {
              if (firstNameKey.currentState!.validate() &
                  lastNameKey.currentState!.validate() &
                  ageKey.currentState!.validate()) {
                _createDatabase();
              }
            },
            child: Text(
              "Next",
              style: TextStyle(color: Colors.white),
            ),
            minWidth: MediaQuery.of(context).size.width / 3,
            color: Colors.blue,
            height: 50.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: loading ? Indicator() : null,
          ),
          SizedBox(
            height: 10,
          )
        ]),
      )),
    );
  }

  Future<void> _createDatabase() async {
    setState(() {
      loading = true;
    });
    FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "first name": firstNameController.value.text,
      "last name": lastNameController.value.text,
      "email": user.email,
      "age": _age,
      "gender": _gender,
      "registration": DateTime.now()
    }, SetOptions(merge: true)).then((value) => {
            Mover.move(context, EmailVerification())
        });
  }
}

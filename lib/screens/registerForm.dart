import 'dart:io';
import 'package:budding_analyst/model/registerFormData.dart';
import 'package:budding_analyst/screens/emailVerification.dart';
import 'package:budding_analyst/widgets/indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  User user = FirebaseAuth.instance.currentUser!;

  TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> nameKey = GlobalKey<FormState>();

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
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Sizer(builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Almost Done!",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: deviceType == DeviceType.tablet ? 30 : 22),
                  ),
                  Container(
                    child: Image.asset("assets/formHeading.png"),
                    width: deviceType == DeviceType.tablet ? MediaQuery.of(context).size.width/1.5 : MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/4 ,
                  ),
                  Text(
                    "What's your name?",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Form(
                      key: nameKey,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your name";
                          } else {
                            return null;
                          }
                        },
                        autofillHints: [AutofillHints.name],
                        controller: nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.black),
                            labelText: "Full Name",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "My age is",
                        style: TextStyle(fontSize: deviceType == DeviceType.tablet ? 22 : 16),
                      ),
                      Text(
                        " $_age",
                        style: TextStyle(fontSize:deviceType == DeviceType.tablet ? 28 : 20, color: Colors.blue),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/4,
                    child: Platform.isIOS
                        ? Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: TextButton(onPressed: () async {
                        await showModalBottomSheet(context: context,isDismissible: true, builder: (context) {
                          return CupertinoPicker(
                              itemExtent: 30,  onSelectedItemChanged: (value) {
                            int data = value + 18;
                            setState(() {
                              _age = data;
                            });
                          },
                              children: [
                                for (int i = 18; i <= 70; i++) Text("$i",style: TextStyle(fontSize: 24),),
                              ]);
                        },);
                      }, child: Text(_age.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                    )

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
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                  ListTile(
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
                  ListTile(
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
                  MaterialButton(
                    onPressed: () {
                      if (nameKey.currentState!.validate() &
                          ageKey.currentState!.validate()) {
                        _createDatabase();
                      }
                    },
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white),
                    ),
                    minWidth: MediaQuery.of(context).size.width / 3,
                    color: Colors.black,
                    height: deviceType == DeviceType.tablet ? 60 : 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Container(
                    child: loading ? Indicator() : null,
                  ),
                ]);
          })),
    );
  }

  Future<void> _createDatabase() async {
    setState(() {
      loading = true;
    });
    FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "first name": nameController.value.text,
      "email": user.email,
      "age": _age,
      "gender": _gender,
      "registration": DateTime.now()
    }, SetOptions(merge: true)).then(
        (value) => {
        if (Platform.isIOS) {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => EmailVerification(),))
  }
    else if (Platform.isAndroid) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EmailVerification(),))
    }

  });
  }


}

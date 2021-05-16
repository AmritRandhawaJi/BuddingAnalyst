import 'package:budding_analyst/assets/my_flutter_app_icons.dart';
import 'package:budding_analyst/screens/home.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailRegister extends StatefulWidget {
  @override
  _EmailRegisterState createState() => _EmailRegisterState();
}

class _EmailRegisterState extends State<EmailRegister> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> stateKey = GlobalKey<FormState>();
  GlobalKey<FormState> stateKey2 = GlobalKey<FormState>();

  bool hiddenState = true;

  bool emailResult = false;
  bool passwordResult = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  firebaseValidation() async {
    String id = emailController.text;
    String pass = passwordController.text;

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: id, password: pass);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          passwordResult = true;
          stateKey2.currentState!.validate();
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          emailResult = true;
          stateKey.currentState!.validate();
        });
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      emailResult = false;
      passwordResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.black54,
      body: SafeArea(
        child:
            Stack(alignment: Alignment.topCenter,
              children: [

                Column(
                  children: [

                    Container(width: MediaQuery.of(context).size.width/1.5,child: Text("Create Better Together.",style: TextStyle(fontSize: 35.0,color: Colors.white),)),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(width: MediaQuery.of(context).size.width/1.5,child: Text("Join our community",style: TextStyle(fontSize: 16.0,color: Colors.white),))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                        Container(
                          height: MediaQuery.of(context).size.height/1.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0))
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 50.0,),
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
                                          return "email is already exist";
                                        } else {
                                          return null;
                                        }
                                      },
                                      autofillHints: [AutofillHints.email],
                                      controller: emailController,
                                      decoration: InputDecoration(

                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30.0)),
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
                                  height: 50.0,
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
                                        } else if (passwordResult) {
                                          return "Choose Strong password";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: passwordController,
                                      decoration: InputDecoration(

                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30.0)),
                                          hintText: "Enter a password",
                                          suffixIcon: GestureDetector(
                                            child: hiddenState
                                                ? Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: Colors.black87,
                                            )
                                                : Icon( Icons.remove_red_eye,color: Colors.black,),
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
                                  height: 50.0,
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    if (stateKey.currentState!.validate() &&
                                        stateKey2.currentState!.validate()) {
                                      setState(() {
                                        firebaseValidation();
                                      });
                                    }
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
                                  minWidth: MediaQuery.of(context).size.width / 2,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              ],
            ),

            ),

        );
  }
}

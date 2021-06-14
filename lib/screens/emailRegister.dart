import 'package:budding_analyst/model/mover.dart';
import 'package:budding_analyst/screens/registerUi.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/indicator.dart';
import 'loginScreen.dart';
import 'registerForm.dart';

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
          .createUserWithEmailAndPassword(email: id, password: pass);
      Mover.move(context, RegisterForm());
    } on FirebaseAuthException catch (e) {
      setState(() {
        buttonState = false;
      });
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
      setState(() {
        buttonState = false;
      });
    }
    setState(() {
      emailResult = false;
      passwordResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Mover.move(context, RegisterUi());
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          "Create Better Together.",
                          style: TextStyle(
                              fontSize: 35.0, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          "Join our community",
                          style: TextStyle(fontSize: 16.0),
                        )),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Column(

                        children: [
                          SizedBox(
                            height: 25.0,
                          ),
                          Form(
                            key: stateKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
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
                                controller: emailController,
                                decoration: InputDecoration(

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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: TextFormField(
                                obscureText: hiddenState,
                                validator: (password) {
                                  if (password!.isEmpty) {
                                    return "Password required";
                                  } else if (password.length < 8) {
                                    return "Minimum 8 characters required";
                                  } else if (passwordResult) {
                                    return "Choose Strong password";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: passwordController,
                                decoration: InputDecoration(


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
                                      setState(() {
                                        _firebaseValidation();
                                      });
                                    }
                                  },
                            child: Text(
                              "Register",
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
                            height: 35.0,
                          ),
                          Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Mover.move(context, LoginScreen());
                            },
                            child: Text("Login",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1.5,
                      child: Text("By clicking Register you are accepting terms & conditions, Would you like to read more click here."),
                    )
                  ],
                ),
              ),
            );
          },
        ),
    );
  }
}

import 'package:budding_analyst/StringData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
            child: Column(
        children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Budding Analyst",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            Expanded(child: PageViewAdaptor()),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Buttons("Back"), Buttons("Next")],
            )
        ],
      ),
          )),
    );
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
  }
}

class Buttons extends StatelessWidget {
  Buttons(this.buttonName);

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          elevation: 5.0,
          minWidth: screenSize.size.width/3,
          height: 35,
          color: Colors.blue,
          child: new Text(buttonName,
              style: new TextStyle(fontSize: 16.0, color: Colors.white))),
    );
  }
}

class PageViewAdaptor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    return PageView(
      children: [

        Center(child: PageViewContent(titleOne, imageOne, descriptionOne)),
        Center(child: PageViewContent(titleTwo, imageTwo, descriptionTwo)),
        Center(child: PageViewContent(titleThree, imageThree, descriptionThree))
      ],
    );
  }
}

class PageViewContent extends StatelessWidget {
  PageViewContent(this.title, this.image, this.description);

  final String title;
  final String image;
  final String description;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Text(this.title),

            Expanded(
              child: Image.asset(
                "assets/$image",
                width: screenSize.size.width / 1.5,
                height: screenSize.size.height / 1.5,
              ),
            ),

            Text(this.description)
          ],
        ),
      ),
    );
  }
}

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
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
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
            Expanded(
                child: PageView(
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              children: [
                Center(
                    child: PageViewContent(titleOne, imageOne, descriptionOne)),
                Center(
                    child: PageViewContent(titleTwo, imageTwo, descriptionTwo)),
                Center(
                    child: PageViewContent(
                        titleThree, imageThree, descriptionThree))
              ],
            )),
            Column(
              children: [
                MaterialButton(
                    onPressed: () {
                      PageController().animateToPage(index++,
                          duration: Duration(milliseconds: 250),
                          curve: Curves.bounceOut);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Colors.black,
                        )
                      ],
                    ),elevation: 5.0,height: 30,)
              ],
            )
          ],
        ),
      )),
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
    return Column(
      children: [
        Text(this.title),
        Expanded(
            child: Image(
          image: AssetImage("assets/$image"),
        )),
        Text(this.description)
      ],
    );
  }
}

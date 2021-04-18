import 'dart:io';

import 'package:budding_analyst/PageViewModel.dart';
import 'package:budding_analyst/SlideItem.dart';
import 'package:budding_analyst/screens/Signup.dart';
import 'package:budding_analyst/widgets/SlideDots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: slideList.length,
              itemBuilder: (ctx, i) => SlideItem(i),
            ),
          ),
        ),
        bottomSheet: _currentPage != slideList.length - 1
            ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text("Skip",style: TextStyle(color: Colors.black),)),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int i = 0; i < slideList.length; i++)
                              if (i == _currentPage)
                                SlideDots(true)
                              else
                                SlideDots(false)
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            _pageController.animateToPage(_currentPage + 1,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.easeIn);
                          },
                          child: Row(
                            children: [
                              Text("Next",style: TextStyle(color: Colors.black),),
                              Icon(Icons.arrow_forward_rounded,color: Colors.black,)
                            ],
                          )),
                    ],
                  ),
                ),
            )
            : MaterialButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignupScreen()));
    },child: Text("Get started",style: TextStyle(color: Colors.white),),height: Platform.isIOS ? 60.0: 50,minWidth: MediaQuery.of(context).size.width,color: Colors.indigoAccent,));
  }
}

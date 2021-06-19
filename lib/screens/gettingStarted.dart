import 'dart:io';
import 'package:budding_analyst/model/PageViewData.dart';
import 'package:budding_analyst/model/SlideItem.dart';
import 'package:budding_analyst/model/networkState.dart';
import 'package:budding_analyst/screens/decision.dart';
import 'package:budding_analyst/widgets/SlideDots.dart';
import 'package:budding_analyst/widgets/internetAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Sizer(
        builder: (BuildContext context, Orientation orientation,
                DeviceType deviceType) =>
            Scaffold(
                body: SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(child: Text("Budding",style: TextStyle(fontSize: 28,fontFamily: "Trocchi"),)),
                          Center(child: Text("Analyst",style: TextStyle(fontSize: 26,fontFamily: "Trocchi"),))
                        ],
                      ),
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: slideList.length,
                        itemBuilder: (ctx, i) => SlideItem(i),
                      ),
                    ],
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
                                    _pageController.animateToPage(
                                        _currentPage - 1,
                                        duration: Duration(milliseconds: 250),
                                        curve: Curves.easeIn);
                                  },
                                  child: Text(
                                    "Back",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: SizerUtil.deviceType ==
                                                DeviceType.tablet
                                            ? 8.sp
                                            : 10.sp),
                                  )),
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
                                    _pageController.animateToPage(
                                        _currentPage + 1,
                                        duration: Duration(milliseconds: 250),
                                        curve: Curves.easeIn);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Next",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: SizerUtil.deviceType ==
                                                DeviceType.tablet
                                                ? 8.sp
                                                : 10.sp),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.black,
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      )
                    : MaterialButton(
                        onPressed: () async {
                          await NetworkState.state();
                          if (NetworkState.status()) {
                            final data = await SharedPreferences.getInstance();
                            data.setInt("userState", 1);
                            if (Platform.isIOS) {
                              Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => Decision(),));
                            }
                            else if (Platform.isAndroid) {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Decision(),));
                            }

                          } else {
                            InternetError(context).show();
                          }
                        },
                        child: Text(
                          "Get started",
                          style:
                              TextStyle(color: Colors.white, fontSize: SizerUtil.deviceType ==
                                  DeviceType.tablet
                                  ? 8.sp
                                  : 11.sp),
                        ),
                        height: Platform.isIOS ? 60.0 : 50,
                        minWidth: MediaQuery.of(context).size.width,
                        color: Colors.indigoAccent,
                      )));
  }
}

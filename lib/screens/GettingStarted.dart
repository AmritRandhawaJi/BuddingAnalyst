import 'package:budding_analyst/PageViewModel.dart';
import 'package:budding_analyst/SlideItem.dart';
import 'package:budding_analyst/widgets/SlideDots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: slideList.length,
        itemBuilder: (ctx, i) => SlideItem(i),
      ),
        bottomSheet: _currentPage != slideList.length - 1
            ? Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () {}, child: Text("Skip")),
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
                        child: Text("Next")),
                  ],
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Theme.of(context).accentColor,
                child: Center(child: Text("Get started",style: TextStyle(color: Colors.white,fontSize: 18),)),
              ),
    );
  }
}

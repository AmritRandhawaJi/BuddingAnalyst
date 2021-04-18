import 'package:budding_analyst/PageViewModel.dart';
import 'package:flutter/material.dart';


class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    return Column(
mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[


       Padding(
         padding: const EdgeInsets.all(18.0),
         child: Container(width: screenSize.size.width,child: Image.asset(slideList[index].image)),
       ),


        Text(
          slideList[index].title,
          style: TextStyle(
            fontSize: 22,
          ),
        ),

        Text(
          slideList[index].description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
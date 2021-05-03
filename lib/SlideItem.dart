import 'package:budding_analyst/PageViewModel.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  final int index;

  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
                child: Image.asset(slideList[index].image),height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.height/1.5,),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    slideList[index].title,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  Text(
                    slideList[index].description,
                    textAlign: TextAlign.center,style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:budding_analyst/model/PageViewData.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  final int index;

  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Container(
          child: Image.asset(slideList[index].image),
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.height / 2.5,
        ),
        SizedBox(
          height: 50.0,
        ),
        Container(
          height: 100,
          child: Column(
            children: [
              Text(
                slideList[index].title,
                style: TextStyle(fontSize: 18, fontFamily: "Ubuntu"),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Text(slideList[index].description,
                    style: TextStyle(
                        fontSize: 14, color: Colors.black54, fontFamily: "Ubuntu"),
                    textAlign: TextAlign.center),
              )
            ],
          ),
        )
      ],
    );
  }
}



import 'package:budding_analyst/model/PageViewData.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SlideItem extends StatelessWidget {
  final int index;

  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return Column(

          children: <Widget>[SizedBox(
            height: 50.0,
          ),
            Image.asset(slideList[index].image,width: 75.w,height: 75.w,),

            SizedBox(
              height: 50.0,
            ),
            Column(
              children: [
                Text(
                  slideList[index].title,textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14.sp, fontFamily: "Ubuntu"),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container( width: MediaQuery.of(context).size.width/1.2,
                  child: Text(slideList[index].description,
                      style: TextStyle(
                          fontSize: 12.sp, color: Colors.black54, fontFamily: "Ubuntu"),
                      textAlign: TextAlign.center),
                )
              ],
            )
          ],
        );
      },
    );
  }
}

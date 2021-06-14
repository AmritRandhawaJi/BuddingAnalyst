import 'package:budding_analyst/model/PageViewData.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SlideItem extends StatelessWidget {
  final int index;

  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(slideList[index].image,width: SizerUtil.deviceType == DeviceType.tablet ? 55.w : 70.w,
              height: SizerUtil.deviceType == DeviceType.tablet ? 55.h : 60.h,),

            Column(
              children: [
                Text(
                  slideList[index].title,
                  style: TextStyle(fontSize: SizerUtil.deviceType == DeviceType.tablet ? 10.sp :14.sp, fontFamily: "Ubuntu"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(slideList[index].description,
                      style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.tablet ? 8.sp :12.sp,
                          color: Colors.black54,
                          fontFamily: "Ubuntu"),
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

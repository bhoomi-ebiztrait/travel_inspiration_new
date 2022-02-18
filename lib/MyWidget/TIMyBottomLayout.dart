import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

import 'MyText.dart';

class MyBottomLayout extends StatelessWidget {
  String imgUrl;

  MyBottomLayout({this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .10,
      width: Get.width,
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
          image: DecorationImage(
              image: AssetImage(imgUrl), fit: BoxFit.fill)),
    );
  }
}

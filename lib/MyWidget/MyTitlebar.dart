import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../utils/MyColors.dart';
import '../utils/MyFontSize.dart';
import '../utils/MyStrings.dart';
import 'MyText.dart';

class MyTitlebar extends StatelessWidget {
 String title;
 MyTitlebar({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 60),
      padding: EdgeInsets.all(2),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40)),
        color: MyColors.buttonBgColor,
      ),
      //margin: EdgeInsets.all(20),
      child: MyText(
        text_name: title.toUpperCase(),
        txtcolor: MyColors.whiteColor,
        txtfontsize: MyFontSize.size23,
        myFont: MyStrings.bodoni72_Bold,
      ),
    );
  }
}

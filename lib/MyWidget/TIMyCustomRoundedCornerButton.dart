import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';

import 'MyText.dart';

class TIMyCustomRoundedCornerButton extends StatelessWidget {
  double buttonWidth, buttonHeight, fontSize;
  Color btnBgColor, textColor;
  String btnText, myFont;
  Function onClickCallback;
  double borderRadius;

  TIMyCustomRoundedCornerButton(
      {this.buttonWidth,
      this.buttonHeight,
      this.btnBgColor,
      this.btnText,
      this.textColor,
      this.fontSize,
      this.myFont,
      this.onClickCallback,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickCallback,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: btnBgColor,
          borderRadius: BorderRadius.all(Radius.circular(
              borderRadius == null ?
              Get.width * .050 :
              borderRadius)),
        ),
        child: MyText(
          text_name: btnText,
          myFont: myFont,
          txtfontsize: fontSize,
          txtcolor: textColor,
          txtAlign: TextAlign.center,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class MyQuotedText extends StatelessWidget {

  Color txtColor;
  Color quoteColor;
  double txtFontSize;
  String myText,myFont;

  MyQuotedText({this.txtColor,this.quoteColor,this.txtFontSize,this.myText,this.myFont});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Get.width * .040, right: Get.width * .040),
      child: Text.rich(
        TextSpan(children: [
          WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(right: Get.width * .030),
                child: Image.asset(MyImageURL.choose_your_leftquote,color: quoteColor,),
              )),
          TextSpan(
            text: myText,
            style: TextStyle(
                color: txtColor,
                fontSize: txtFontSize,
                fontFamily: myFont!=null?myFont:MyFont.Courier_Prime_Italic),
          ),
          WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(left: Get.width * .030),
                child: Image.asset(MyImageURL.choose_your_rightquote,color: quoteColor,),
              )),
        ]),
        textAlign: TextAlign.center,
      ),
    );
  }
}

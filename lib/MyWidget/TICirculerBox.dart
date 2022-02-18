import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class TICirculerBox extends StatelessWidget {

  String imageIcon,title;

  TICirculerBox({this.imageIcon,this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*.050,
      width: Get.width*.55,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: MyColors.expantionTileBgColor,
              offset:Offset(1,1)
            )
          ],
          border: Border.all(
            color: MyColors.expantionTileBgColor,
          ),
          borderRadius:BorderRadius.all(Radius.circular(Get.width*.060))
      ),
      child:Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: Get.width*.050,),
            Image.asset(imageIcon,
              height: Get.height*.025,
              width: Get.height*.025,
              fit: BoxFit.contain,
            ),
            SizedBox(width: Get.width*.030,),
            MyText(
              text_name: title,
              txtfontsize: MyFontSize.size8,
              txtcolor: MyColors.textColor,
              myFont: MyStrings.courier_prime_bold,
            ),
            /*Container(
              width: Get.width*.35,
              child: RichText(text:TextSpan(text:title,
              style: TextStyle(
                fontFamily: MyFont.Courier_Prime_Bold,
                fontSize: MyFontSize.size8,
                color: MyColors.textColor,
              )),
                textAlign: TextAlign.left,
              ),
            )*/

          ],
        ),
      ),
    );
  }
}

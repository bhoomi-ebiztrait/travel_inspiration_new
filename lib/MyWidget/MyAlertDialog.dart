import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';

import 'MyText.dart';

class MyAlertDialog extends StatelessWidget {

  String title,content;
  Function funYes,funNo;


  MyAlertDialog({this.title, this.content,
    this.funYes, this.funNo});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Get.width*.040))
      ),
      child: Container(
        height:Get.height*.20,
        width: Get.width*.50,
        padding: EdgeInsets.all(Get.width*.030),
        child: Column(
          children: [
            MyText(
              text_name:title,
              myFont: MyFont.Courier_Prime_Bold,
              txtfontsize:MyFontSize.size18,
            ),
            SizedBox(height: Get.height*.020,),
            MyText(
              text_name:content,
              myFont: MyFont.Courier_Prime,
              txtfontsize:MyFontSize.size14,
            ),
            SizedBox(height: Get.height*.04,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap:funNo,
                  child:MyText(
                    text_name:"No".tr,
                    myFont: MyFont.Courier_Prime,
                    txtfontsize:MyFontSize.size14,
                  ),
                ),
                SizedBox(width: Get.width*.10,),
                GestureDetector(
                  onTap:funYes,
                  child:MyText(
                    text_name:"Yes".tr,
                    myFont: MyFont.Courier_Prime,
                    txtfontsize:MyFontSize.size14,
                  ),
                )
              ],
            )

          ],
        ),
      )

    );
  }
}

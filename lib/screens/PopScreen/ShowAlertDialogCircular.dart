import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';

class AlertDialogCircular extends StatelessWidget {
  String title;

  AlertDialogCircular({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImageURL.login),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            width: Get.width ,
            height: Get.height * .37,
            // padding: EdgeInsets.only(left: 15,right: 15),
            margin: EdgeInsets.only(
                top: Get.height * .10, left: 6, bottom: 20),
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(500),
                shape: BoxShape.circle,
                color: MyColors.whiteColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      MyImageURL.cross,
                      width: 40,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  margin: EdgeInsets.only(left: 50,right: 50),
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0,right: 5),
                    child: MyText(
                      text_name: title,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size13,
                     // txtAlign: TextAlign.center,
                      myFont: MyFont.Courier_Prime,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

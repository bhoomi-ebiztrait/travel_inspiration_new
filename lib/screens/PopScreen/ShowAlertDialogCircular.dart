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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(350.0),
            child: Container(
              width: Get.width * .61,
              height: Get.height * .37,
              padding: EdgeInsets.only(left: 15,right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
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
                    height: Get.height * 0.04,
                  ),
                  MyText(
                    text_name: title.tr,
                    txtcolor: MyColors.textColor,
                    txtfontsize: MyFontSize.size13,
                    txtAlign: TextAlign.center,
                    myFont: MyFont.Courier_Prime,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

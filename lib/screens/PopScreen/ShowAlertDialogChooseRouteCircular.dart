import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';

class ShowAlertDialogChooseRouteCircular extends StatelessWidget {
  String title;
  String details;

  ShowAlertDialogChooseRouteCircular({Key key, this.title,this.details}) : super(key: key);

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
                  height: Get.height * 0.04,
                ),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyColors.textColor,
                      fontSize: MyFontSize.size13,
                      fontFamily: MyFont.Courier_Prime_Bold),
                ),
                SizedBox(
                  height: Get.height * .008,
                ),
                Container(
                  height: Get.height * .010,
                  width: Get.height * 0.16,
                  decoration: BoxDecoration(
                      color: MyColors.lightGreenColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),

                SizedBox(
                  height: Get.height * .01,
                ),

                Container(
                  margin: EdgeInsets.only(left: 50,right: 50),
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: MyText(
                      text_name: details,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/screens/InspiredMode/InspredModeScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

class TIInspireModeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBodyContent()),
    );
  }

  _buildBodyContent() {
    return Stack(children: [
      _bodyCenterWidget(),
      _buildBackArrow(),
    ]);
  }

  _buildBackArrow() {
    return Padding(
      padding: EdgeInsets.all(Get.height * .010),
      child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(MyImageURL.back,
            width: 25,)),
    );
  }

  _bodyCenterWidget() {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(MyImageURL.inspiremode_bg), fit: BoxFit.fill),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            ScreenTransition.navigateOffAll(screenName: InspredModeScreen());
          },
          child: Container(
            width: Get.width,
            height: Get.height * .18,
            margin: EdgeInsets.only(bottom: Get.height * .082),
            padding: EdgeInsets.only(top: Get.height * .020),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(MyImageURL.curve_whiteshape),
                  fit: BoxFit.fill),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "txtInspireModeCommencerle".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyColors.expantionTileBgColor,
                      fontSize: MyFontSize.size23,
                      fontFamily: MyFont.Cagliostro_reguler),
                ),
                SizedBox(
                  height: Get.height * .010,
                ),
                Image.asset(
                  MyImageURL.arrow3x,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

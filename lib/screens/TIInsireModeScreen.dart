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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * .15,
          ),
          Text(
            "txtInspireModeCommencerle".tr.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: MyColors.whiteColor,
                fontSize: MyFontSize.size50,
                fontFamily: MyStrings.bodoni72_Bold),
          ),
          SizedBox(
            height: Get.height * .22,
          ),
          GestureDetector(
            onTap: (){
              ScreenTransition.navigateOffAll(screenName: InspredModeScreen());
            },
            child: Image.asset(
              MyImageURL.fleche,
              fit: BoxFit.contain,height: 130,width: 130,
            ),
          ),
        ],
      ),
    );
  }


}

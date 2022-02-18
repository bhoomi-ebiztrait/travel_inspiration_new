import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/screens/SettingsMenu/DeleteAcConfirmScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'SettingScreen.dart';

class DeleteAcSecondScreen extends StatelessWidget {
  const DeleteAcSecondScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyTopHeader(
                    headerName: "auters_info".tr,
                    headerImgUrl: MyImageURL.setting_top,
                    logoImgUrl: MyImageURL.haudos_logo,
                  ),
                  SizedBox(
                    height: Get.height * 0.10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: MyText(
                        text_name: "delete_warn_msg".tr,
                        txtfontsize: MyFontSize.size12,
                        txtcolor: MyColors.textColor),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  buildDeleteAcButton(),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  buildChangeMyMindButton(),
                ],
              ),
            ),
          ),
          buildBottomImage(),
        ],
      ),
    );
  }

  buildBottomImage() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          width: Get.width,
          child: Image.asset(
            MyImageURL.setting_bottom,
            fit: BoxFit.fitWidth,
          )),
    );
  }

  buildChangeMyMindButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MyButtonWithoutIcon(
          btn_name: "changed_my_mind".tr,
          txtcolor: MyColors.textColor,
          bgcolor: MyColors.buttonBgColor,
          txtfont: MyFontSize.size13,
          myFont: MyStrings.courier_prime_bold,
          onClick: () {
            ScreenTransition.navigateOff(screenName:SettingScreen());
          },
        ),
      ],
    );
  }

  buildDeleteAcButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
              color: MyColors.whiteColor,
              border: Border.all(color: MyColors.buttonBgColor),
              boxShadow: [
                BoxShadow(
                  color: MyColors.buttonBgColor,
                  blurRadius: 1.0,
                ),
              ]),
          //margin: EdgeInsets.all(20),
          child: MaterialButton(
            onPressed: () {
              ScreenTransition.navigateToScreenLeft(
                  screenName:DeleteAcConfirmScreen());
            },
            minWidth: Get.width * 0.70,
            child: Container(
              width: Get.width * 0.55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(
                      text_name: "delete_my_account".tr,
                      myFont: MyStrings.courier_prime_bold,
                      txtfontsize: MyFontSize.size13,
                      txtcolor: MyColors.redColor),

                  Center(
                    child: Container(
                        // width: Get.width * 0.04,
                        // alignment: Alignment.centerRight,
                        child: Image.asset(MyImageURL.delete_ac)),
                  ),
                ],
              ),

              /*child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Container(
                      width: Get.width * 0.04,
                      alignment: Alignment.topRight,
                      child: Image.asset(MyImageURL.delete_ac)),

                ],
              ),*/
            ),
          ),
        ),
      ],
    );
  }
}

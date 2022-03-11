import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/screens/SettingsMenu/SettingScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class ChangePwConfirmScreen extends StatefulWidget {
  @override
  _ChangePwConfirmScreenState createState() => _ChangePwConfirmScreenState();
}

class _ChangePwConfirmScreenState extends State<ChangePwConfirmScreen> {
  bool isSettingSelected = false;
  bool isMenuSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: MyColors.buttonBgColor,
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(MyImageURL.confirm_bg), fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor.withOpacity(0.86),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 25),
                      child: Column(
                        children: [
                          MyText(
                            text_name: "new_password_validated".tr,
                            txtcolor: MyColors.confirmTextColor,
                            myFont: MyStrings.courier_prime_bold,
                            txtfontsize: MyFontSize.size19,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          MyText(
                            text_name: "confirmation_msg".tr,
                            txtcolor: MyColors.confirmTextColor,
                            txtfontsize: MyFontSize.size18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: Get.height * 0.08,
                    ),
                    backToSetting(),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    buildBackToMenu(),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  backToSetting() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.14),
        child: MyButton(
          btn_name: "back_to_settings".tr,
          txtcolor: MyColors.buttonBgColor,
          myFont: MyStrings.courier_prime_bold,
          txtfont: MyFontSize.size13,
            bgColor: MyColors.whiteColor,
          opacity: 1,
          onClick: (){
            setState(() {
              isSettingSelected = true;
            });
            Get.back();
          },
        ),
      ),
    );
    /*return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButtonWithOnesideRadious(
                btn_name: "back_to_settings".tr,
                btnBgcolor: MyColors.lightGreenColor,
                txtcolor: MyColors.textColor,
                txtfont: MyFontSize.size13,
                myFont: MyStrings.courier_prime_bold,
                onClick: (){
                  setState(() {
                    isSettingSelected = true;  
                  });
                  Get.back();
                },
              ),
            ],
          );*/
  }

   buildBackToMenu() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.14),
        child: MyButton(
          btn_name: "back_to_menu".tr,
          txtcolor: MyColors.buttonBgColor,
          myFont: MyStrings.courier_prime_bold,
          txtfont: MyFontSize.size13,
          bgColor: MyColors.whiteColor,
          opacity: 1,
          onClick: (){
            setState(() {
              isMenuSelected = true;
            });

            CommonMethod.getAppMode();
          },
        ),
      ),
    );

    /*return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MyButtonWithoutIcon(
          btn_name: "back_to_menu".tr,
          txtcolor:
              isMenuSelected ? MyColors.lightGreenColor : MyColors.textColor,
          bgcolor: MyColors.whiteColor,
          txtfont: MyFontSize.size13,
          myFont: MyStrings.courier_prime_bold,
          onClick: () {
            setState(() {
              isMenuSelected = true;
            });

            CommonMethod.getAppMode();
          },
        ),
      ],
    );*/
  }
}

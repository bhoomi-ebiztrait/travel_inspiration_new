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
    return Scaffold(
      backgroundColor: MyColors.buttonBgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child:
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: Get.height*0.15,),
                  Image.asset(MyImageURL.check_circle,),
                  SizedBox(height: Get.height*0.09,),
                  MyText(text_name: "new_password_validated".tr,txtcolor: MyColors.whiteColor,myFont: MyStrings.courier_prime_bold,txtfontsize: MyFontSize.size19,),
                  SizedBox(height: Get.height*0.05,),
                  MyText(text_name: "confirmation_msg".tr,txtcolor: MyColors.whiteColor,txtfontsize: MyFontSize.size18,),
                ],
              ),
            ),
            SizedBox(height: Get.height*0.08,),
            backToSetting(),
            SizedBox(height: Get.height*0.08,),

            buildBackToMenu(),
          ],
        ),
      ),
    );
  }

  Row backToSetting() {
    return Row(
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
          );
  }

  Row buildBackToMenu() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyButtonWithoutIcon(
                btn_name: "back_to_menu".tr,
                txtcolor: isMenuSelected ?MyColors.lightGreenColor:MyColors.textColor,
                bgcolor: MyColors.whiteColor,
                txtfont: MyFontSize.size13,
                myFont: MyStrings.courier_prime_bold,
                onClick: (){
                  setState(() {
                    isMenuSelected = true;
                  });
                  
                  CommonMethod.getAppMode();
                },
              ),
            ],
          );
  }
}

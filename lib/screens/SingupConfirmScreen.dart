import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/screens/CreateProfileScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/SettingScreen.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

class SignupConfirmScreen extends StatelessWidget {
  const SignupConfirmScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.buttonBgColor,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: Get.height*0.15,),
                  Image.asset(MyImageURL.check_circle_confirm,),
                  SizedBox(height: Get.height*0.09,),
                  MyText(text_name: "genial_tu_es".tr,txtcolor: MyColors.whiteColor,myFont: MyStrings.courier_prime_bold,txtfontsize: MyFontSize.size19,),
                  SizedBox(height: Get.height*0.05,),
                  MyText(text_name: "actives_ton_compte".tr,txtcolor: MyColors.whiteColor,txtfontsize: MyFontSize.size18,),

                  Spacer(),

                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(child: MyText(text_name: "commerce_aventure".tr,txtcolor: MyColors.whiteColor,txtfontsize: MyFontSize.size23,myFont: MyStrings.cagliostro,)),
                      SizedBox(height: Get.height*0.02,),
                      GestureDetector(
                        onTap: (){
                          callConfirmUserAPI();
                        /*  ScreenTransition.navigateToScreenLeft(
                              screenName:CreateProfileScreen());                          */

                        },
                          child: Image.asset(MyImageURL.fleche)),
                    ],
                  ),
                ],
              ),



        ),
      ),
    );
  }

   callConfirmUserAPI() async{
    ApiManager apiManager = ApiManager();
    Get.dialog(Loading());
    await apiManager.confirmUserAPI().then((response){
      Get.back();
      if(response == null)
        MyUtility.showErrorMsg("Email not varified");
      else {
        if (response.isSuccess()) {
          var result = response.getDATAJSONArray1()[ApiParameter.userInfo];

          //saved user id and email in pref
          MyPreference.setPrefStringValue(
              key: MyPreference.userId,
              value: result[ApiParameter.userId].toString());
          MyPreference.setPrefStringValue(
              key: MyPreference.emailId, value: result[ApiParameter.EMAIL]);
          MyPreference.setPrefStringValue(
              key: MyPreference.accessToken,
              value: response.getDATAJSONArray1()[ApiParameter.access_token]);

          ScreenTransition.navigateOffAll(screenName: CreateProfileScreen());
        } else {
          MyUtility.showErrorMsg(response.getMessage());
        }
      }
    });
  }
}

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

  String userId;
  SignupConfirmScreen(this.userId);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(MyImageURL.confirm_bg), fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: Get.height*0.05,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.whiteColor.withOpacity(0.86),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 25),
                          child: Column(
                            children: [
                              MyText(text_name: "genial_tu_es".tr,txtcolor: MyColors.confirmTextColor,myFont: MyStrings.courier_prime_bold,txtfontsize: MyFontSize.size19,),
                              SizedBox(height: Get.height*0.02,),
                              MyText(text_name: "actives_ton_compte".tr,txtcolor: MyColors.confirmTextColor,txtfontsize: MyFontSize.size18,),

                            ],
                          ),
                        ),
                      ),
                    ),

                    Spacer(),

                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(child: MyText(text_name: "commerce_aventure".tr,txtcolor: MyColors.whiteColor,txtfontsize: MyFontSize.size33,myFont: MyStrings.bodoni72_Bold,)),
                        SizedBox(height: Get.height*0.04,),
                        GestureDetector(
                          onTap: (){
                            callConfirmUserAPI();
                          /*  ScreenTransition.navigateToScreenLeft(
                                screenName:CreateProfileScreen());                          */

                          },
                            child: Image.asset(MyImageURL.fleche)),
                        SizedBox(height: Get.height*0.01,),
                      ],
                    ),
                  ],
                ),



          ),
        ),
      ),
    );
  }

   callConfirmUserAPI() async{
    ApiManager apiManager = ApiManager();
    Get.dialog(Loading());
    await apiManager.confirmUserAPI(userId).then((response){
      Get.back();
      if(response == null)
        MyUtility.showErrorMsg("Email not varified");
      else {
        if (response.isSuccess()) {
          var result = response.getDATAJSONArray1()[ApiParameter.userInfo];

          print("insiddddddd");
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyAlertDialog.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyCustomDialog.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTextButton.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/SettingsMenu/AutersInformationScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/BecomePremiumScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/ChangePasswordScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/ChangedAddressScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/ChangedDOBScreen.dart';

import 'package:travel_inspiration/screens/SettingsMenu/TIFaqListScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/TIMyAccountLanguageScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/TIMyAccountModeTransportScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/TIMyAccountNotificationScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';
import 'package:travel_inspiration/utils/TIStrings.dart';

import '../HomeScreen.dart';

enum param{DOB,address,language,become_premium,
  terms_condition,privacy_policy,logOut,
  notification,faq,mode_de_transport}
class SettingScreen extends StatefulWidget {

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  MyController dataController = Get.put(MyController());
  ApiManager apiManager=Get.put(ApiManager());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("${dataController.userInfo}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize:MainAxisSize.min,
            children: [
              MyTopHeader(
                headerName: "settings".tr,
                headerImgUrl: MyImageURL.setting_top,
                logoImgUrl: MyImageURL.haudos_logo,
                logoCallback: (){
                  CommonMethod.getAppMode();
                },
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              buildParameters(),

              buildBottomImage(),
            ],
          ),
        ),
      ),
    );
  }

   buildParameters() {
    return Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: MyTextStart(
                        text_name: "my_account".tr,
                        myFont: MyStrings.courier_prime_bold,
                        txtfontsize: MyFontSize.size13,
                        txtcolor: MyColors.textColor),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:10,bottom:10,left: 8.0, right: 30),
                    child: setDivider(MyColors.lightGreenColor, 5),
                  ),
                  MyTextButtonStart(
                    btn_name: "change_my_password".tr,
                    onClick: () {
                      ScreenTransition.navigateToScreenLeft(screenName: ChangePasswordScreen());
                      },
                    txtcolor: MyColors.textColor,
                    txtfont: MyFontSize.size13,
                    myFont: MyStrings.courier_prime_bold,
                  ),
                  setDivider(MyColors.dialog_shadowColor, 1),
                  buildDetails("date_of_birth".tr,MyPreference.getPrefStringValue(key: MyPreference.dob) != "null" ? MyPreference.getPrefStringValue(key: MyPreference.dob) : "",param.DOB),
                  setDivider(MyColors.dialog_shadowColor, 1),
                  buildDetails("address".tr,MyPreference.getPrefStringValue(key: MyPreference.address)!= "null" ? MyPreference.getPrefStringValue(key: MyPreference.address) : "",param.address),
                  setDivider(MyColors.dialog_shadowColor, 1),
                  buildDetails("mode_of_transport_used".tr,null,param.mode_de_transport),
                  setDivider(MyColors.dialog_shadowColor, 1),
                  buildDetails("language".tr,"",param.language),
                  setDivider(MyColors.dialog_shadowColor, 1),
                  buildDetails("become_premium".tr,null,param.become_premium),
                  setDivider(MyColors.dialog_shadowColor, 1),
                  buildDetails("notification".tr,null,param.notification),
                  setDivider(MyColors.dialog_shadowColor, 1),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: MyTextStart(
                        text_name: "other_information".tr,
                        myFont: MyStrings.courier_prime_bold,
                        txtfontsize: MyFontSize.size13,
                        txtcolor: MyColors.textColor),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:10,bottom:10,left: 8.0, right: 30),
                    child: setDivider(MyColors.lightGreenColor, 5),
                  ),
                  buildDetails("terms_conditions".tr,null,param.terms_condition),
                  setDivider(MyColors.dialog_shadowColor, 1),
                  buildDetails("privacy_policy".tr,null,param.privacy_policy),
                  setDivider(MyColors.dialog_shadowColor, 1),
                  buildDetails("faq".tr,null,param.faq),
                  setDivider(MyColors.dialog_shadowColor, 1),
                  buildSignOut(),

                  setDivider(MyColors.dialog_shadowColor, 1),

                  buildDeleteAc(),
                  // buildDetails(MyStrings.delete_my_account,null),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),

                ],
              ),
            );
  }

  Container buildBottomImage() {
    return Container(
                width: Get.width,
                child: Image.asset(MyImageURL.setting_bottom,fit:BoxFit.fitWidth,));
  }

   buildDeleteAc() {
    return GestureDetector(
      onTap: (){
        ScreenTransition.navigateToScreenLeft(
            screenName:AutersInformationScreen(title: "delete_my_account".tr,
              desc:"delete_ac_msg".tr,isDeleteAc: true,));
        },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right:10,top: 20,bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyTextStart(
                              text_name: "delete_my_account".tr,

                              myFont: MyStrings.courier_prime_bold,
                              txtfontsize: MyFontSize.size13,
                              txtcolor: MyColors.redColor),

                          Container(
                              width: Get.width * 0.4,
                              alignment: Alignment.topLeft,
                              child: Image.asset(MyImageURL.delete_ac)),

                        ],
                      ),
                    ),
    );
  }

  _getParam(){
    Map param={
     "userId": MyPreference.getPrefStringValue(key:MyPreference.userId),
    };
    return param;
  }
  buildSignOut() {
    return GestureDetector(
      onTap: (){

        _signOutDialog();

      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right:10,top: 20,bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextStart(
                text_name: "sign_out".tr,

                myFont: MyStrings.courier_prime_bold,
                txtfontsize: MyFontSize.size13,
                txtcolor: MyColors.textColor),
            Container(
                width: Get.width * 0.4,
                alignment: Alignment.topLeft,
                child: Image.asset(MyImageURL.exit_to_app)),

          ],
        ),
      ),
    );
  }

   buildDetails(String title,String value, [param enumVal]) {
    return GestureDetector(
      onTap: ()async{
        if(param.DOB == enumVal){
          dataController.selectedDate.value = value != null ? value : "";
         // final result =  await ScreenTransition.navigateToScreenLeft(screenName: ChangedDOBScreen());
         final result =  await Get.to(()=>ChangedDOBScreen());
         if(result == true){
           setState(() {
           });
         }
        }else if(param.address == enumVal){

          final result =  await Get.to(()=>ChangedAddressScreen());
          if(result == true){
            setState(() {
            });
          }
          // ScreenTransition.navigateToScreenLeft(screenName: ChangedAddressScreen());

        }else if(param.language==enumVal){
         ScreenTransition.navigateToScreenLeft(screenName: TIMyAccountLanguageScreen());

        }else if(param.become_premium==enumVal){
          ScreenTransition.navigateToScreenLeft(screenName: BecomePremiumScreen());

        }else if(param.terms_condition == enumVal){
          callTermsApi(ApiParameter.TERMS_ID);
          //ScreenTransition.navigateToScreenLeft(screenName:AutersInformationScreen(title: MyStrings.terms_conditions,desc: "« Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. » \n\n« Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. »",));

        }else if(param.privacy_policy == enumVal){
          callTermsApi(ApiParameter.PRIVACY_ID);
          // ScreenTransition.navigateToScreenLeft(screenName:AutersInformationScreen(title: MyStrings.privacy_policy,desc: "« Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. » \n\n« Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. »",));

        }else if(param.notification==enumVal){
          ScreenTransition.navigateToScreenLeft(screenName: TIMyAccountNotificationScreen());

        }else if(param.faq==enumVal){
          ScreenTransition.navigateToScreenLeft(screenName: TIFaqListScreen());

        }else if(param.mode_de_transport==enumVal){

          ScreenTransition.navigateToScreenLeft(screenName: TIMYAccountModeTransportScreen());

        }
      },
      child:Padding(
                      padding: const EdgeInsets.only(left: 8.0,right:10,top: 20,bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyTextStart(
                              text_name: title,
                              myFont: MyStrings.courier_prime_bold,
                              txtfontsize: MyFontSize.size13,
                              txtcolor: MyColors.textColor),
                          value != null ?MyTextEnd(
                              text_name: "$value",
                              txtfontsize: MyFontSize.size13,
                              txtcolor: MyColors.textColor):Container(),
                        ],
                      ),
                    ),
    );
  }

  setDivider(Color dividerColor, double height) {
    return Container(
      color: dividerColor,
      height: height,
      width: Get.width,
    );
  }

   callTermsApi(int id) async{
     ApiManager apiManager = ApiManager();
     Get.dialog(Loading());

     await apiManager.getAuthInfo(id).then((response){
       Get.back();
       if(response != null)
         ScreenTransition.navigateToScreenLeft(screenName:AutersInformationScreen(title: response["page_title"],desc: response["details"],));
     });


   }

  _signOutDialog(){
    Get.dialog(MyAlertDialog(title: "sign_out".tr,
      content: "logoutMsg".tr,
    funYes: (){
      Get.dialog(Loading());
      apiManager.signOutApiCall(_getParam()).then((response){
         Get.back();
         if(response.isSuccess()){
           MyPreference.clearPref();
           ScreenTransition.navigateOffAll(screenName: HomeScreen());
         }else{
           MyUtility.showErrorMsg(response.getMessage());
         }
      });
    },
    funNo: (){
      Get.back();
    },),barrierDismissible: false);

  }
}

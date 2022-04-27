import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyGradientBottomMenu.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MySettingTop.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/screens/HomeScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

class DeleteAcConfirmScreen extends StatefulWidget {
 
  
  @override
  _DeleteAcConfirmScreenState createState() => _DeleteAcConfirmScreenState();
}

class _DeleteAcConfirmScreenState extends State<DeleteAcConfirmScreen> with SingleTickerProviderStateMixin{
  AnimationController animationController;

  ApiManager apiManager=Get.put(ApiManager());

  
  @override
  void initState() {
    // TODO: implement initState

   _callDeleteAccountApi();

    super.initState();
  }

  _callDeleteAccountApi()async{
    _animateLoading();
    apiManager.deleteAccountApiCall().then((response){
        animationController.stop();
        if(response.isSuccess()){
          MyPreference.clearPref();
          ScreenTransition.navigateOffAll(screenName:HomeScreen());
        }else{
          MyUtility.showErrorMsg(response.getMessage());

        }
    });
  }
  _animateLoading(){
    animationController =
        AnimationController(duration:Duration(seconds:2),
            vsync: this);
    // animationController.addStatusListener((Animtatus) {
    //    TIPrint(tag: "Status",value: Animtatus.toString());
    //    if(Animtatus==AnimationStatus.completed){
    //      ScreenTransition.navigateOffAll(screenName:HomeScreen());
    //    }
    // });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.settingBgColor,
      bottomNavigationBar:  MyGradientBottomMenu(selString:MyStrings.settings,iconList: [MyImageURL.profile_icon,MyImageURL.galerie,MyImageURL.home_menu,MyImageURL.world_icon,MyImageURL.setting_selected],bgImg: MyImageURL.change_pw_bottom,bgColor: MyColors.buttonBgColorHome.withOpacity(0.7),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MySettingTop(title: "auters_info".tr,),

              Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.09,
                  ),
                  RotationTransition(
                      turns: Tween(begin: 0.0,end: 1.0).animate(animationController),
                      child: Image.asset(MyImageURL.arrow3x,height: 50,)),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 30),
                    child: MyText(
                        text_name: "account_deletion".tr,
                        txtfontsize: MyFontSize.size11,
                        myFont: MyStrings.courier_prime_bold,
                        txtcolor: MyColors.textColor),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: MyText(
                        text_name: "account_deletion_msg".tr,
                        txtfontsize: MyFontSize.size11,
                        txtcolor: MyColors.textColor),
                  ),
                  SizedBox(
                    height: Get.height * 0.07,
                  ),
                  buildwithSocialNetwork(),
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }

   buildwithSocialNetwork() {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(MyImageURL.instagram),
                          SizedBox(width: Get.width*0.02,),
                          MyTextStart(
                            text_name: "haudosapp".tr,
                            txtfontsize: MyFontSize.size10,
                            txtcolor: MyColors.textColor,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(MyImageURL.facebook),
                          SizedBox(width: Get.width*0.02,),
                          MyTextStart(
                            text_name: "haudosapp".tr,
                            txtfontsize: MyFontSize.size10,
                            txtcolor: MyColors.textColor,
                          ),
                        ],
                      ),
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
}

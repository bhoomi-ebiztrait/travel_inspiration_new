import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyAlertDialog.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MySettingTop.dart';
import 'package:travel_inspiration/MyWidget/MyTextFieldWithImage.dart';
import 'package:travel_inspiration/TIController/MyValidatorController.dart';
import 'package:travel_inspiration/screens/PopScreen/ShowAlertDialogCircular.dart';
import 'package:travel_inspiration/screens/SettingsMenu/ChangePwConfirmScreen.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import '../../MyWidget/MyGradientBottomMenu.dart';
import '../../MyWidget/MyText.dart';
import '../../MyWidget/MyTitlebar.dart';
import '../../utils/MyFontSize.dart';
import '../PopScreen/ShowAlertSignIn.dart';
import '../PopScreen/ShowAlertWithBgColor.dart';




class ChangePasswordScreen extends StatefulWidget {
  bool isVisibleCurrPw = true;
  bool isVisibleNewPw = true;

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  MyValidatorController myController = Get.put(MyValidatorController());
  final _formKey = GlobalKey<FormState>();
  ApiManager apiManager=Get.put(ApiManager());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body:Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MySettingTop(title: "my_account".tr,),



               SizedBox(
                 height: Get.height * 0.06,
               ),
               MyText(
                 text_name: "current_password".tr,
                 txtcolor: MyColors.textColor.withOpacity(1),
                 txtfontsize:MyFontSize.size15,
                 myFont: MyStrings.courier_prime_bold,
               ),
               SizedBox(
                 height: Get.height * 0.02,
               ),
               MyTextFieldWithImage(
                 labelColor: MyColors.textColor,
                 mycontroller: oldPasswordController,
                 myFont: MyStrings.courier_prime_bold,
                 imageUrl: MyImageURL.password,
                 suffixImageUrl:
                 widget.isVisibleCurrPw ? MyImageURL.eye : MyImageURL.eye_off,
                 suffixOnTap: () {
                   setState(() {
                     widget.isVisibleCurrPw = !widget.isVisibleCurrPw;
                   });
                 },
                 //addlabel: "current_password".tr,
                 readonly: false,
                 edinputType: TextInputType.visiblePassword,
                 obscureText: widget.isVisibleCurrPw,
                 validator: myController.validateOldPassword,
               ),
               SizedBox(
                 height: Get.height * 0.06,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   MyText(
                     text_name: "new_password".tr,
                     txtcolor: MyColors.textColor.withOpacity(1),
                     txtfontsize:MyFontSize.size15,
                     myFont: MyStrings.courier_prime_bold,
                   ),
                   SizedBox(width: Get.width*0.02,),
                   GestureDetector(
                     onTap: (){
                       Get.to(() => ShowAlertWithBgColor(title: "password_rules".tr ,myContent: "",));
                           /*MyCommonMethods.showInfoCenterDialog(
                           msgContent: "password_rules".tr));*/
                     },
                       child: Image.asset(MyImageURL.info_blue,height: 20,width: 20,)),
                 ],
               ),
               SizedBox(
                 height: Get.height * 0.02,
               ),
               MyTextFieldWithImage(
                 labelColor: MyColors.textColor,
                 mycontroller: newPasswordController,
                 myFont: MyStrings.courier_prime_bold,
                 imageUrl: MyImageURL.password,
                 suffixImageUrl:
                 widget.isVisibleNewPw ? MyImageURL.eye : MyImageURL.eye_off,
                 suffixOnTap: () {
                   setState(() {
                     widget.isVisibleNewPw = !widget.isVisibleNewPw;
                   });
                 },
               //  addlabel: "new_password".tr,
                 readonly: false,
                 edinputType: TextInputType.visiblePassword,
                 obscureText: widget.isVisibleNewPw,
                 validator: myController.validatePassword,
               ),

               SizedBox(height: Get.height*0.06,),
               Container(
                   width: Get.width,
                   height: Get.height*0.1,
                   child: GestureDetector(
                       onTap: (){
                         if(_formKey.currentState.validate()) {
                           _formKey.currentState.save();
                           _changePasswordApiCall();

                         }
                         MyUtility().focusOut(context);
                       },
                       child: Image.asset(MyImageURL.green_check))),
              ],
            ),
          ),
        ),
        backgroundColor: MyColors.settingBgColor,
        bottomNavigationBar:  MyGradientBottomMenu(selString:MyStrings.settings,iconList: [MyImageURL.profile_icon,MyImageURL.galerie,MyImageURL.home_menu,MyImageURL.world_icon,MyImageURL.setting_selected],bgImg: MyImageURL.change_pw_bottom,bgColor: MyColors.buttonBgColorHome.withOpacity(0.7),),
      ),
    );

  }


  _getParam(){
    Map param={
       ApiParameter.userId:MyPreference.getPrefStringValue(key:MyPreference.userId),
       ApiParameter.old_password:oldPasswordController.text,
      ApiParameter.new_password:newPasswordController.text,
    };
    return param;
  }

  _changePasswordApiCall()async{
    Get.dialog(Loading());
    apiManager.changePasswordApiCall(param:_getParam()).
    then((response){
        Get.back();
        setState((){
          oldPasswordController.text="";
          newPasswordController.text="";
        });
        if(response.isSuccess()){
          ScreenTransition.navigateOff(
              screenName:ChangePwConfirmScreen());
        }else{
          MyUtility.showErrorMsg(response.getMessage());
        }


    });
  }

}

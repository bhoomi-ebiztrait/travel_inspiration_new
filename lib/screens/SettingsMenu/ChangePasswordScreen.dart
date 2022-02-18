import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyTextFieldWithImage.dart';
import 'package:travel_inspiration/TIController/MyValidatorController.dart';
import 'package:travel_inspiration/screens/SettingsMenu/ChangePwConfirmScreen.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';




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
                MyTopHeader(headerName: "my_account".tr.toUpperCase(),
                  headerImgUrl: MyImageURL.setting_top,
                  logoImgUrl: MyImageURL.haudos_logo,
                ),
                SizedBox(
                  height: Get.height * 0.06,
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
                  addlabel: "current_password".tr,
                  readonly: false,
                  edinputType: TextInputType.visiblePassword,
                  obscureText: widget.isVisibleCurrPw,
                  validator: myController.validateOldPassword,
                ),
                SizedBox(
                  height: Get.height * 0.04,
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
                  addlabel: "new_password".tr,
                  readonly: false,
                  edinputType: TextInputType.visiblePassword,
                  obscureText: widget.isVisibleNewPw,
                  validator: myController.validatePassword,
                ),

                SizedBox(height: Get.height*0.09,),
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
                        child: Image.asset(MyImageURL.check_circle))),

              ],
            ),
          ),
        ),
        bottomNavigationBar:buildBottomImage(),
      ),
    );

  }
   buildBottomImage() {
    return Container(
      height: Get.height*.10,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: Get.width,

            child: Image.asset(MyImageURL.setting_bottom,fit:BoxFit.fitWidth,)),
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

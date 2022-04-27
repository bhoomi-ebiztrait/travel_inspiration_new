import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTextFieldWithImage.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/TIController/MyValidatorController.dart';
import 'package:travel_inspiration/screens/HomeScreen.dart';
import 'package:travel_inspiration/screens/LoginScreen.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';



class ModifyPhoneNumberScreen extends StatelessWidget {

  ApiManager apiManager=ApiManager.getInstance();
  MyValidatorController myController = Get.put(MyValidatorController());
  TextEditingController phoneController=TextEditingController();
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    apiManager.isVisibleMsg.value=false;
    return WillPopScope(
      onWillPop: (){
        Get.back(result: true);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child:Obx(()=>
            Form(
              key:_formKey,
             // autovalidateMode:apiManager.forgotAutoValidate.value ? AutovalidateMode.always : AutovalidateMode.disabled ,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(MyImageURL.login), fit: BoxFit.fill)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back(result: true);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset(
                            MyImageURL.back,
                            width: 25,
                          ),
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          MyImageURL.haudos_splash,
                          width: 200,
                        ),
                      ),
                      SizedBox(
                          height: Get.height * 0.06
                      ),
                      MyTitlebar(title: "${"change_my_number".tr}".toUpperCase()),

                      SizedBox(
                        height: Get.height * 0.06,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 70,bottom: 10),
                        child: MyTextStart(
                          text_name: "phone_number".tr,
                          txtcolor: MyColors.whiteColor,
                          txtfontsize:MyFontSize.size15,
                          myFont: MyStrings.courier_prime,
                        ),
                      ),
                      MyTextFieldWithImage(
                        //imageUrl: MyImageURL.email,
                        //addlabel: "email".tr,
                        readonly: false,
                        labelColor: MyColors.lightGreenColor,
                        edinputType: TextInputType.phone,
                        obscureText: false,
                        mycontroller:phoneController,
                        validator:myController.validatePhoneNo,
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: MyText(
                          text_name:
                          apiManager.isVisibleMsg == true ?
                          "sent_mail_msg".tr : "",
                          txtfontsize: MyFontSize.size10,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),

                      GestureDetector(
                        onTap: (){
                          if(_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                           _changePhoneNumberApiCall();

                          }
                          MyUtility().focusOut(context);
                        },
                        child: Container(
                            width: Get.width,
                            height: Get.height*0.1,
                            child: Image.asset(
                              MyImageURL.green_check,
                            )),
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      )
                    ],
                  ),
                ),
               ),
          ),
          ),
        ),
      ),
    );
  }

  _getParam(){
    Map param ={
      "userId":MyPreference.getPrefStringValue(key: MyPreference.userId),
      "phoneNumber":phoneController.text,
    };
    return param;

  }
  _validate(){

    _formKey.currentState.save();
    if(_formKey.currentState.validate()){
      Get.dialog(Loading());
      apiManager.forgotPasswordApiCall(param:_getParam()).
      then((response){
        Get.back();
        apiManager.isVisibleMsg.value = true;
      });

    }else{
      apiManager.forgotAutoValidate.value=true;
    }
  }

   _changePhoneNumberApiCall() async{
     Get.dialog(Loading());
     apiManager.changePhoneNumberApiCall(param:_getParam()).
     then((response){
       Get.back();
       MyPreference.setPrefStringValue(key: MyPreference.phoneNumber, value: phoneController.text);
       Get.back(result: true);
     /*  setState((){
         oldPasswordController.text="";
         newPasswordController.text="";
       });
       if(response.isSuccess()){
         ScreenTransition.navigateOff(
             screenName:ChangePwConfirmScreen());
       }else{
         MyUtility.showErrorMsg(response.getMessage());
       }*/

     });
   }
}

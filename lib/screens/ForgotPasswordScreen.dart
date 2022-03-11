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
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';



class ForgotPasswordScreen extends StatelessWidget {

  ApiManager apiManager=ApiManager.getInstance();
  MyValidatorController myController = Get.put(MyValidatorController());
  TextEditingController email=TextEditingController();
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    apiManager.isVisibleMsg.value=false;
    return Scaffold(
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
                    MyTitlebar(title: "${"je_suis_haudosseen_multiline".tr}".toUpperCase()),

                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 70,bottom: 10),
                      child: MyTextStart(
                        text_name: "email".tr,
                        txtcolor: MyColors.whiteColor,
                        txtfontsize:MyFontSize.size15,
                        myFont: MyStrings.courier_prime,
                      ),
                    ),
                    MyTextFieldWithImage(
                      imageUrl: MyImageURL.email,
                      //addlabel: "email".tr,
                      readonly: false,
                      labelColor: MyColors.lightGreenColor,
                      edinputType: TextInputType.emailAddress,
                      obscureText: false,
                      mycontroller:email,
                      validator:myController.validateEmail,
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
                    MyText(
                      text_name: apiManager.isVisibleMsg== true ?
                      "spam_verify".tr : "",
                      txtfontsize: MyFontSize.size13,
                      myFont: MyStrings.courier_prime_bold,
                    ),
                    SizedBox(
                      height: Get.height * 0.07,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                      child: MyButton(
                        btn_name: apiManager.isVisibleMsg== true
                            ? "return_homepage".tr
                            : "envoyer_email".tr,
                        bgColor: MyColors.buttonBgColor,
                        opacity: 1.0,
                        txtcolor: MyColors.whiteColor,
                        txtfont: MyFontSize.size15,
                        myFont: MyStrings.courier_prime,
                        onClick: () {
                          if(apiManager.isVisibleMsg == true){
                            ScreenTransition.navigateOffAll(
                                screenName:LoginScreen());
                          }else{
                            _validate();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    )
                  ],
                ),
              ),
             /* child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTopHeader(
                headerName: "je_suis_haudosseen".tr.toUpperCase(),
                headerImgUrl: MyImageURL.header,
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              MyTextFieldWithImage(
                imageUrl: MyImageURL.email,
                addlabel: "email".tr,
                readonly: false,
                labelColor: MyColors.lightGreenColor,
                edinputType: TextInputType.emailAddress,
                obscureText: false,
                mycontroller:email,
                validator:myController.validateEmail,
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
              MyText(
                text_name: apiManager.isVisibleMsg== true ?
                "spam_verify".tr : "",
                txtfontsize: MyFontSize.size13,
                myFont: MyStrings.courier_prime_bold,
              ),
              SizedBox(
                height: Get.height * 0.07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButtonWithOnesideRadious(
                    btn_name:apiManager.isVisibleMsg== true
                        ? "return_homepage".tr
                        : "envoyer_email".tr,
                    btnBgcolor: MyColors.buttonBgColor,
                    txtcolor: MyColors.textColor,
                    txtfont: MyFontSize.size13,
                    myFont: MyStrings.courier_prime_bold,
                    onClick:() {
                      if(apiManager.isVisibleMsg == true){
                        ScreenTransition.navigateOffAll(
                            screenName:LoginScreen());
                      }else{
                        _validate();
                      }

                    },
                  ),
                ],
              ),
            ],
          )*/),
        ),
        ),
      ),
    );
  }

  _getParam(){
    Map param ={
      ApiParameter.EMAIL:email.text,
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
}

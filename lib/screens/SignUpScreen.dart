import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTextFieldWithImage.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/TIController/MyValidatorController.dart';
import 'package:travel_inspiration/screens/PopScreen/ShowAlertSignIn.dart';
import 'package:travel_inspiration/screens/SingupConfirmScreen.dart';
import 'package:travel_inspiration/services/AuthenticationService.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';
class SignUpScreen extends StatefulWidget {
  bool isVisible = true;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isAgree = true;
  bool autoValidate = true;
  MyValidatorController myController = Get.put(MyValidatorController());
  final _formKey = GlobalKey<FormState>();
  ApiManager apiManager = Get.put(ApiManager());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SafeArea(
          child: buildSignupLayout(),
        ),
      ),
    );
  }

  buildSignupLayout() {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImageURL.login), fit: BoxFit.fill)),
      child: SingleChildScrollView(
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
            MyTitlebar(title: "${"devenir_haudosseen_multiLine".tr}".toUpperCase(),),

            SizedBox(
              height: Get.height * 0.06,
            ),
            Container(
              margin: const EdgeInsets.only(left: 70,bottom: 10),
              child: MyTextStart(
                text_name: "email".tr,
                txtcolor: MyColors.whiteColor,
                txtfontsize:MyFontSize.size15,
                myFont: MyStrings.courier_prime,
              ),
            ),
            MyTextFieldWithImage(
              mycontroller: email,
              imageUrl: MyImageURL.email,
              //addlabel: "email".tr,
              readonly: false,
              labelColor: MyColors.lightGreenColor,
              edinputType: TextInputType.emailAddress,
              obscureText: false,
              validator: myController.validateEmail,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: MyTextStart(
                      text_name: "mot_de_passe".tr,
                      txtcolor: MyColors.whiteColor,
                      txtfontsize:MyFontSize.size15,
                      myFont: MyStrings.courier_prime,
                    ),
                  ),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => AlertDialogSignIn(title: "password_rules",myContent: "",));
                    },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Icon(Icons.info_outline,size: 22,color: MyColors.whiteColor,),
                      ))
                ],
              ),
            ),
            MyTextFieldWithImage(
              mycontroller: password,
              labelColor: MyColors.lightGreenColor,
              imageUrl: MyImageURL.password,
              suffixImageUrl:
              widget.isVisible ? MyImageURL.eye : MyImageURL.eye_off,
              suffixOnTap: () {
                setState(() {
                  widget.isVisible = !widget.isVisible;
                });
              },
              //addlabel: "mot_de_passe".tr,
              readonly: false,
              edinputType: TextInputType.visiblePassword,
              obscureText: widget.isVisible,
              validator: myController.validateLoginPassword,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Center(
              child: buildAcceptCGV(),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
              child: MyButton(
                btn_name: "devenir_haudosseen".tr,
                bgColor: MyColors.buttonBgColor,
                opacity: 1.0,
                txtcolor: MyColors.whiteColor,
                txtfont: MyFontSize.size15,
                myFont: MyStrings.courier_prime,
                onClick: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    MyUtility().focusOut(context);
                    if (apiManager.isAgree.value) {
                      autoValidate = false;
                      _signApiCall();
                      // ScreenTransition.navigateOffAll(
                      //     screenName: SignupConfirmScreen());
                    } else {
                      MyCommonMethods.showInfoCenterDialog(
                          msgContent:  "cgvvalid".tr,myFont:  MyStrings.courier_prime_bold);
                    }
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
    );
  }

  buildSignUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MyButtonWithOnesideRadious(
          btn_name: "devenir_haudosseen".tr,
          txtcolor: MyColors.textColor,
          btnBgcolor: MyColors.buttonBgColor,
          txtfont: MyFontSize.size13,
          myFont: MyStrings.courier_prime_bold,
          onClick: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              MyUtility().focusOut(context);
              if (apiManager.isAgree.value) {
                autoValidate = false;
                _signApiCall();
                // ScreenTransition.navigateOffAll(
                //     screenName: SignupConfirmScreen());
              } else {
                MyCommonMethods.showInfoCenterDialog(
                   msgContent:  "cgvvalid".tr,myFont:  MyStrings.courier_prime_bold);
              }
            }
          },
        ),
      ],
    );
  }

  buildAcceptCGV() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Checkbox(
                checkColor: MyColors.textColor,
                activeColor: MyColors.whiteColor,
                value: apiManager.isAgree.value,
                onChanged: (value) {
                  apiManager.isAgree.value = value;
                }),
          ),
          MyText(
            text_name: "accept_cgv".tr,
            txtcolor: MyColors.whiteColor,
            txtfontsize: MyFontSize.size15,
            myFont: MyStrings.courier_prime,
          ),
          GestureDetector(
              onTap: () {
                cgvApiCall();
                // MyCommonMethods.showAlertDialog(
                //    msgContent:  MyStrings.cvg_rules, myFont: MyStrings.courier_prime);
              },
              child: MyText(
                text_name: " ${"cgv".tr}",
                txtcolor: MyColors.whiteColor,
                txtfontsize: MyFontSize.size15,
                myFont: MyStrings.courier_prime_bold,
              )),
        ],
      ),
    );
  }

  /*buildSignUpWithGoogle() {
    return GestureDetector(
      onTap: () {
        AuthenticationService.signInWithGoogle();
      },
      child: Container(
        width: Get.width * 0.70,
        height: Get.height * 0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyButtonWithIcon(
              btn_name: MyStrings.signin_with_google,
              txtcolor: MyColors.textColor,
              txtfont: MyFontSize.size13,
              myFont: MyStrings.courier_prime_bold,
            ),
          ],
        ),
      ),
    );
  }*/

  _getParam(){
    var param={
      ApiParameter.EMAIL: email.text,
      ApiParameter.PASSWORD: password.text,
      ApiParameter.ISCGVCHECKED: apiManager.isAgree.value?"1":"0",
      ApiParameter.DEVICETOKEN:MyPreference.getPrefStringValue(key: MyPreference.deviceToken)
    };
    return param;
  }

  _signApiCall() async {
    Get.dialog(Loading());

    await apiManager.signUpApiCall(_getParam()).then((response){
     Get.back();
     print(response.isSuccess());
     if(response.isSuccess()){

       /*MyPreference.setPrefStringValue(
           key: MyPreference.accessToken,value:response.getDATAJSONArray1()[ApiParameter.access_token]);*/
       var result = response.getDATAJSONArray1()[ApiParameter.userInfo];
       /*MyPreference.setPrefStringValue(
           key: MyPreference.userId,value:result[ApiParameter.userId].toString());*/
       String userId = result[ApiParameter.userId].toString();
       // String token = response.getDATAJSONArray1()[ApiParameter.access_token];
       ScreenTransition.navigateOffAll(screenName:SignupConfirmScreen(userId,email.text));
     }else{
       MyUtility.showErrorMsg(response.getMessage());
     }

    });
  }

  passwordInfo(){
    MyCommonMethods.showAlertDialog(
        msgContent: "password_rules".tr, myFont: MyStrings.courier_prime);
  }

   cgvApiCall() async{
    Get.dialog(Loading());
    await apiManager.getAuthInfo(ApiParameter.CGV_ID).then((response){
      Get.back();
      if(response != null) {
        Get.to(() => AlertDialogSignIn(title: "",myContent: response["details"],));
        // MyCommonMethods.showAlertDialog(
        //     msgContent: response["details"], myFont: MyStrings.courier_prime);
      }else{
        Get.to(() => AlertDialogSignIn(title: "txtNoRecordFound",myContent: "",));
       /* MyCommonMethods.showInfoCenterDialog(
            msgContent: "txtNoRecordFound".tr);*/
      }
    });
  }
}

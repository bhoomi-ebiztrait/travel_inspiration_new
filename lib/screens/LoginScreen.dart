import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTextButton.dart';
import 'package:travel_inspiration/MyWidget/MyTextFieldWithImage.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/TIController/MyValidatorController.dart';
import 'package:travel_inspiration/screens/CreateProfileScreen.dart';
import 'package:travel_inspiration/screens/DashboardScreen.dart';
import 'package:travel_inspiration/screens/ForgotPasswordScreen.dart';
import 'package:travel_inspiration/screens/PopScreen/ShowAlertSignIn.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeScreen.dart';
import 'package:travel_inspiration/services/AuthenticationService.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';
import 'InspiredMode/InspredModeScreen.dart';
import 'ReflectMode/ReflectModeCreateProjectScreen.dart';
import 'TIChoseRouteModeScreen.dart';
import 'TIInsireModeScreen.dart';

class LoginScreen extends StatefulWidget {
  bool isVisible = true;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isDeviceSupportBio = false;
  bool isFaceBio = false;
  ApiManager aPIManager = ApiManager();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  MyValidatorController myController = Get.put(MyValidatorController());
  final _formKey = GlobalKey<FormState>();
  bool autoValidate = true;

  bool isActiveBio = false;

  bool isBioOn = false;

  @override
  void initState() {
    super.initState();
    getDeviceToken();
    /*checkDeviceSupport().then((value) {
      setState(() {
        isDeviceSupportBio = value;
        AuthenticationService.checkFace().then((value) {
          setState(() {
            isFaceBio = value;
          });
        });
      });
    });*/
    checkActiveSupport().then((value) {
      if (value) {
        setState(() {
          isActiveBio = true;
        });
      }
    });
  }

  Future<bool> checkDeviceSupport() async {
    // return await AuthenticationService.isDeviceSupportBio();
    return await AuthenticationService.checkingForBioMetrics();
  }

  Future<bool> checkActiveSupport() async {
    return await AuthenticationService.enrolledBiometrics();
    // return await AuthenticationService.checkActiveBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SafeArea(
          child: Container(
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
                  MyTitlebar(title: "${"je_suis_haudosseen_multiline".tr}".toUpperCase(),),

                  SizedBox(
                    height: Get.height * 0.06,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70,bottom: 10),
                    child: MyTextStart(
                      text_name: "email".tr,
                      txtcolor: MyColors.whiteColor,
                      txtfontsize:MyFontSize.size15,
                      myFont: MyStrings.courier_prime,
                    ),
                  ),
                  MyTextFieldWithImage(
                    mycontroller: emailController,
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
                              // passwordInfo();
                              Get.to(() => AlertDialogSignIn(title: "password_rules",myContent: "",));
                            },child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                              child: Icon(Icons.info_outline,size: 22,color: MyColors.whiteColor,),
                            ))
                      ],
                    ),
                  ),
                  MyTextFieldWithImage(
                    mycontroller: passwordController,
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
                  buildWithBIO(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  passwordInfo(){
    MyCommonMethods.showAlertDialog(
        msgContent: "password_rules".tr, myFont: MyStrings.courier_prime);
  }

  buildWithBIO() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MyTextButton(
          btn_name: "mot_de_passe_oublie".tr,
          onClick: () {
            ScreenTransition.navigateToScreenLeft(
                screenName: ForgotPasswordScreen());
          },
          txtcolor: MyColors.whiteColor,
          txtfont: MyFontSize.size15,
          myFont: MyStrings.courier_prime,
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Center(
          child: Container(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,bottom: 15),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        isBioOn = !isBioOn;
                      });

                    },
                    child: Image.asset(
                      isBioOn ? MyImageURL.toggle_on:MyImageURL.toggle_off,
                      width: 50,
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                      onTap: () async {
                        bool isAuthenticated =
                            await AuthenticationService.authenticateWithBiometrics();
                        if (isAuthenticated) {
                          print("msg: success");
                          String email = MyPreference.getPrefStringValue(
                                      key: MyPreference.emailId) !=
                                  null
                              ? MyPreference.getPrefStringValue(key: MyPreference.emailId)
                              : emailController.text;
                          print("email : $email");
                          if (email != null && !email.isEmpty)
                            callLoginWithBioApi(email);
                          else {
                            MyUtility.showErrorMsg("Please authenticate your email");
                          }
                        } else {
                          print("msg: error");
                          // MyUtility.showErrorMsg("Please authenticate your device");
                        }
                      },
                      // child: isDeviceSupportBio
                      //     ?  Image.asset(MyImageURL.fingerprint)
                      //     : Container()),

                      child: isActiveBio
                          ? Image.asset(MyImageURL.fingerprint,height: 80,)
                          : Container()),
                ),
              ],
            ),
          ),
        ),
        /*child: isDeviceSupportBio
                ?  isFaceBio ?Image.asset(MyImageURL.face_id) :Image.asset(MyImageURL.fingerprint)
                : Container()),*/
        SizedBox(
          height: Get.height * 0.03,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
          child: MyButton(
            btn_name: "se_connecter".tr,
            bgColor: MyColors.buttonBgColor,
            opacity: 1.0,
            txtcolor: MyColors.whiteColor,
            txtfont: MyFontSize.size15,
            myFont: MyStrings.courier_prime,
            onClick: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                autoValidate = false;
                callLoginApi();
              }
              MyUtility().focusOut(context);
            },
          ),
        ),
        SizedBox(
          height: Get.height * 0.04,
        )
      ],
    );
  }

  callLoginApi() async {
    Get.dialog(Loading());
    Map param = {
      ApiParameter.EMAIL: emailController.text,
      ApiParameter.PASSWORD: passwordController.text,
      ApiParameter.DEVICETOKEN:
          MyPreference.getPrefStringValue(key: MyPreference.deviceToken)

      // "email":emailController.text,
      // "password":passwordController.text,
      // "deviceToken": MyPreference.getPrefStringValue(key: MyPreference.deviceToken)
    };
    TIPrint(tag: "Param", value: param.toString());
    await aPIManager.getLoginAPI(param).then((value) async {
      Get.back();
      if (value == true) {
        print("mVal $value");
        int mode = MyPreference.getPrefIntValue(key: MyPreference.APPMODE);
        mode == ApiParameter.REFLECT_MODE
            ? ScreenTransition.navigateOffAll(screenName: ReflectModeScreen())
            : ScreenTransition.navigateOffAll(screenName: InspredModeScreen());
      } else {
        print("mVal $value");
      }
    });
  }

  callLoginWithBioApi(String email) async {
    Get.dialog(Loading());
    Map param = {
      // "email": "bhoomi@gmail.com",
      // "deviceToken" : "fAH3FUXrSumpWfB2TEHbiV:APA91bHMEj-6-EwcaF_rvqbuK3rGfh6nhrmxr0IMniTpmNVpKsEeUQuciw9Mo4ZE6pNx6WEswoNA3UT5uGT8nHMvnfb9K8ru6rlRvnuGjD6hDxvOrig6iWWbltxm-qWy7k9rKjEF171W"

      "email": email,
      // "password":passwordController.text,
      "deviceToken":
          MyPreference.getPrefStringValue(key: MyPreference.deviceToken)
    };
    TIPrint(tag: "Param", value: param.toString());
    await aPIManager.getLoginWithBIOAPI(param).then((value) async {
      Get.back();
      if (value) {
        print("mVal $value");
        int mode = MyPreference.getPrefIntValue(key: MyPreference.APPMODE);
        mode == ApiParameter.REFLECT_MODE
            ? ScreenTransition.navigateOffAll(screenName: ReflectModeScreen())
            : ScreenTransition.navigateOffAll(screenName: InspredModeScreen());
        /* mode == ApiParameter.REFLECT_MODE
            ? ScreenTransition.navigateOffAll(
            screenName: ReflectModeCreateProjectScreen())
            : ScreenTransition.navigateOffAll(
            screenName: InspredModeScreen());*/

      } else {
        print("mVal $value");
      }
    });
  }
}

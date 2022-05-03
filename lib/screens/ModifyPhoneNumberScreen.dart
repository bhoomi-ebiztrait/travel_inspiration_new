import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyGradientBottomMenu.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MySettingTop.dart';
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

class ModifyPhoneNumberScreen extends StatefulWidget {
  @override
  State<ModifyPhoneNumberScreen> createState() =>
      _ModifyPhoneNumberScreenState();
}

class _ModifyPhoneNumberScreenState extends State<ModifyPhoneNumberScreen> {
  ApiManager apiManager = ApiManager.getInstance();

  MyValidatorController myController = Get.put(MyValidatorController());

  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String countryCode;



  onChanged(CountryCode mcountryCode) {
     countryCode = mcountryCode.toString();
    print("code : ${countryCode.toString()}");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiManager.isVisibleMsg.value = false;
  }
  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () {
        Get.back(result: true);
      },
      child: Scaffold(
        backgroundColor: MyColors.settingBgColor,
        bottomNavigationBar: MyGradientBottomMenu(
          selString: MyStrings.settings,
          iconList: [
            MyImageURL.profile_icon,
            MyImageURL.galerie,
            MyImageURL.home_menu,
            MyImageURL.world_icon,
            MyImageURL.setting_selected
          ],
          bgImg: MyImageURL.change_pw_bottom,
          bgColor: MyColors.buttonBgColorHome.withOpacity(0.7),
        ),
        body: Obx(
          () => Form(
            key: _formKey,
            // autovalidateMode:apiManager.forgotAutoValidate.value ? AutovalidateMode.always : AutovalidateMode.disabled ,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Get.height * 0.30,
                      width: Get.width,
                      color: MyColors.buttonBgColorHome.withOpacity(0.7),
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
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          MyTitlebar(title: "${"my_account".tr}".toUpperCase()),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                        MyText(
                          text_name: "change_phone_no".tr,
                          txtcolor: MyColors.textColor,
                          txtfontsize: MyFontSize.size15,
                          myFont: MyStrings.courier_prime_bold,
                        ),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        MyText(
                          text_name: "new_number".tr,
                          txtcolor: MyColors.textColor,
                          txtfontsize: MyFontSize.size15,
                          myFont: MyStrings.courier_prime_bold,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        buildActualNo(),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: MyText(
                            text_name: apiManager.isVisibleMsg.value == true
                                ? "dob_update_msg".tr
                                : "",
                            txtfontsize: MyFontSize.size10,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              _changePhoneNumberApiCall();
                            }
                            MyUtility().focusOut(context);
                          },
                          child: Container(
                              width: Get.width,
                              height: Get.height * 0.1,
                              child: Image.asset(
                                MyImageURL.green_check,
                              )),
                        ),
                        SizedBox(
                          height: Get.height * 0.04,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildActualNo() {
    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                CountryCodePicker(
                                  onChanged: onChanged,
                                  initialSelection: 'FR',
                                  favorite: const ['FR', 'IN'],
                                  showCountryOnly: false,
                                  showFlag: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),
                                Container(
                                  color: MyColors.buttonBgColor,
                                  height: 1,
                                  width: 70,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:12.0),
                              child: Container(
                                width: 200,
                                child: MyTextFieldHint(
                                  //imageUrl: MyImageURL.email,
                                  //addlabel: "email".tr,
                                  addHint: "phone_number".tr,
                                  maxlimit: 10,
                                  // myFont: MyStrings.courier_prime,
                                  readonly: false,
                                  labelColor: MyColors.lightGreenColor,
                                  edinputType: TextInputType.phone,
                                  obscureText: false,
                                  mycontroller:phoneController,
                                  validator:myController.validatePhoneNo,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
  }

  _getParam() {
    Map param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "phoneNumber": phoneController.text,
      "countryCode":countryCode.toString(),
    };
    return param;
  }

  _validate() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      Get.dialog(Loading());
      apiManager.forgotPasswordApiCall(param: _getParam()).then((response) {
        Get.back();
        apiManager.isVisibleMsg.value = true;
      });
    } else {
      apiManager.forgotAutoValidate.value = true;
    }
  }

  _changePhoneNumberApiCall() async {
    Get.dialog(Loading());
    apiManager.changePhoneNumberApiCall(param: _getParam()).then((response) {
      Get.back();
      MyPreference.setPrefStringValue(
          key: MyPreference.phoneNumber, value: phoneController.text);
      apiManager.isVisibleMsg.value = true;
     // Get.back(result: true);
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

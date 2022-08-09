import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyDOBPicker.dart';
import 'package:travel_inspiration/MyWidget/MyDropdown.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTextFieldWithImage.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIController/MyValidatorController.dart';
import 'package:travel_inspiration/screens/PopScreen/ShowAlertDialogCreateProfile.dart';
import 'package:travel_inspiration/services/GeoLocationService/AskForPermission.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';
import 'PhotoPreviewScreen.dart';
import 'TIChoseRouteModeScreen.dart';

class CreateProfileScreen extends StatefulWidget {
  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  File croppedImg;
  TextEditingController dateEditingController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  MyValidatorController myController = Get.put(MyValidatorController());
  MyController dataController = Get.put(MyController());
  final _formKey = GlobalKey<FormState>();
  bool autoValidate = true, blurScreen = false;
  AskForPermission askPermisssion = AskForPermission();

  @override
  void initState() {
    super.initState();
    askPermisssion.requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                color: MyColors.buttonBgColorHome.withOpacity(0.69)
               /* image: DecorationImage(
                    image: AssetImage(
                      MyImageURL.bg,
                    ),
                    fit: BoxFit.fill),*/
              ),
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
              SizedBox(height: Get.height * 0.02),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 60),
                    width: MediaQuery.of(context).size.width * 90 /100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40)),
                      color: MyColors.buttonBgColor,
                    ),
                    //margin: EdgeInsets.all(20),
                    child: Padding(
                      padding: const EdgeInsets.only(top:5,left: 48.0),
                      child: MyText(
                        text_name: "${"create_profile".tr.toUpperCase()}",
                        txtcolor: MyColors.whiteColor,
                        txtfontsize: MyFontSize.size25,
                        myFont: MyStrings.bodoni72_Bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () {
                          showImageOptionDialog();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(300.0),
                          child: Container(
                            height: 130,
                            width: 130,
                            child: croppedImg == null
                                ? Image.asset(
                                    MyImageURL.profile_avtar,
                                    fit: BoxFit.fill,
                                  )
                                : Image.file(
                                    croppedImg,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              MyTextFieldWithImage(
                mycontroller: nameController,
                imageUrl: MyImageURL.user_img,
                addlabel: "add_nickname".tr,
                readonly: false,
                labelColor: MyColors.textColor,
                edinputType: TextInputType.name,
                obscureText: false,
                validator: myController.validateName,
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              MyText(
                text_name: "date_of_birth".tr,
                txtcolor: MyColors.whiteColor,
                txtfontsize: MyFontSize.size15,
                myFont: MyFont.Courier_Prime_Bold,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              MyDOBPicker(
                minDate: ApiParameter.DOB_START,
                maxDate: ApiParameter.DOB_END,
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Center(
                child: Container(
                    width: Get.width * 0.70,
                    child: TextFormField(
                      cursorColor: Colors.black45,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.phone,
                      obscureText: false,
                      controller: phoneNoController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColors.whiteColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColors.whiteColor),
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.whiteColor)),
                        hintText: "phone_number".tr,
                        hintStyle: TextStyle(
                          color: MyColors.whiteColor,
                        ),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                /*blurScreen = true;
                                telephoneInfo();*/
                                Get.to(() => AlertDialogCreateProfile(title: "telephone_info",myContent: "",));

                              });
                            },
                            child: Icon(
                              Icons.info_outline,
                              size: 22,
                              color: MyColors.whiteColor,
                            )),
                      ),
                      validator: myController.validatePhoneNo,
                      style: TextStyle(color: MyColors.whiteColor),
                    ),),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    goToNextScreen();
                  },
                  child: Image.asset(
                    MyImageURL.check_circle,
                    height: 60,width: 60,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 80 /100,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      color: MyColors.buttonBgColor,
                    ),
                    //margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 14),
                        Container(
                          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 15 /100),
                          child: MyTextStart(
                            text_name: "create_later".tr,
                            txtcolor: MyColors.whiteColor,
                            txtfontsize: MyFontSize.size15,
                            myFont: MyStrings.bodoni72_Book,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                      child: GestureDetector(
                    onTap: () {
                      // goToNextScreen();
                      /* ScreenTransition.navigateToScreenLeft(
                  screenName: TIChoseRouteModeScreen());*/

                      callCreateProfileLaterAPI();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Image.asset(
                        MyImageURL.fleche,
                        height: 90,
                        width: 90,
                      ),
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: Get.height * 0.08,
              ),
            ],
          ),
          /*child: Stack(
            overflow:Overflow.visible,
            children: [
              buildProfileHeader(),
              Align(
                alignment: Alignment.bottomCenter,
                child:buildBottomLayout(),
              ),
              Visibility(
                visible: blurScreen,
                child: Align(
                    alignment: Alignment.center,
                    child: BackdropFilter(
                        filter: blurScreen
                            ? ImageFilter.blur(sigmaX: 2, sigmaY: 2)
                            : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: Container(
                          width: Get.width * 0.6,
                          padding: EdgeInsets.all(Get.width * .020),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.30)),
                              boxShadow: [
                                BoxShadow(blurRadius: 10, color: Colors.grey)
                              ],
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Get.width * .040))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    blurScreen = false;
                                  });
                                },
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset(MyImageURL.cross,width: 30,)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: MyText(
                                  text_name: "telephone_info".tr,
                                  txtcolor: MyColors.textColor,
                                  txtfontsize: MyFontSize.size13,
                                  myFont: MyStrings.courier_prime_bold,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                            ],
                          ),
                        ))),
              ),
            ],
          ),*/
        )),
      ),
    );
  }

  telephoneInfo() {
    MyCommonMethods.showAlertDialog(
        msgContent: "telephone_info".tr, myFont: MyStrings.courier_prime);
  }

  buildProfileHeader() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                MyImageURL.top_img,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: Get.height * 0.09,
              ),
              buildBodyContent(),

              // buildBottomLayout(),
            ],
          ),
        ),
        // buildBottomLayout(),
        buildProfileImage(),
        buildHeaderText(),
      ],
    );
  }

  buildBodyContent() {
    return Container(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextFieldHintWithImage(
                  imageUrl: MyImageURL.user_img,
                  mycontroller: nameController,
                  addHint: "add_nickname".tr,
                  readonly: false,
                  labelColor: MyColors.textColor,
                  edinputType: TextInputType.name,
                  obscureText: false,
                  iconPadding: 40,
                  validator: myController.validateName,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            MyText(
              text_name: "date_of_birth".tr,
              txtcolor: MyColors.textColor.withOpacity(1.0),
              txtfontsize: MyFontSize.size13,
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            MyDOBPicker(
              minDate: ApiParameter.DOB_START,
              maxDate: ApiParameter.DOB_END,
            ),

            SizedBox(
              height: Get.height * 0.03,
            ),
            // MyDatePickerWidget(title: MyStrings.date_of_birth,),
           // buildAddressRow(),
            buildCityPhoneNo(),
            SizedBox(
              height: Get.height * 0.04,
            ),
         //   buildCountry(),
            SizedBox(
              height: 95,
            ),

            //buildBottomLayout(),
          ],
        ),
      ),
    );
  }

  buildCountry() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, bottom: 20),
      child: Row(
        children: [
          Container(width: Get.width * 0.45, child: MyDropdown()),
        ],
      ),
    );
  }

  buildHeaderText() {
    return Positioned(
        top: Get.height * 0.09,
        right: Get.width * 0.05,
        child: MyText(
          text_name: "create_profile".tr,
          myFont: MyStrings.cagliostro,
          txtfontsize: MyFontSize.size23,
          txtcolor: MyColors.whiteColor,
        ));
  }

  buildProfileImage() {
    return Positioned(
      top: Get.height * 0.14,
      left: Get.width * 0.05,
      child: GestureDetector(
        onTap: () {
          showImageOptionDialog();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(300.0),
          child: Container(
            height: 160,
            width: 160,
            child: croppedImg == null
                ? Image.asset(
                    MyImageURL.profile_avtar,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    croppedImg,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }

  showImageOptionDialog() {
    return Get.dialog(AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                text_name: "choose_option".tr,
                txtcolor: MyColors.textColor,
                txtfontsize: MyFontSize.size16,
                myFont: MyStrings.courier_prime_bold,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              InkWell(
                  onTap: () async {
                    // _openGallery();
                    /*croppedImg = await ScreenTransition.navigateToScreenLeft(
                            screenName:PhotoPreviewScreen(MyStrings.gallery));*/
                    croppedImg = await Get.to(PhotoPreviewScreen("gallery".tr));

                    if (croppedImg != null) {
                      print("crop ${croppedImg.path}");
                    }
                    setState(() {
                      Get.back();
                      // print("crop ${croppedImg.path}");
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: MyText(
                      text_name: "gallery".tr,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size13,
                    ),
                  )),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InkWell(
                  onTap: () async {
                    /*croppedImg =
                        await ScreenTransition.navigateToScreenLeft(
                        screenName:PhotoPreviewScreen(MyStrings.camera));*/
                    croppedImg = await Get.to(PhotoPreviewScreen("camera".tr));
                    if (croppedImg != null) {
                      print("crop ${croppedImg.path}");
                    }
                    setState(() {
                      Get.back();
                      // print("crop ${croppedImg.path}");
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: MyText(
                      text_name: "camera".tr,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size13,
                    ),
                  )),
            ],
          ),
        )));
  }

  buildCityPhoneNo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Get.height * 0.03,
            ),
            Container(
              width: Get.width * 0.58,
              child: MyTextFieldHintWithImage(
                mycontroller: cityController,
                addHint: "city".tr,
                readonly: false,
                labelColor: MyColors.textColor,
                edinputType: TextInputType.name,
                obscureText: false,
                rightPadding: 10,
                maxlimit: 200,
                validator: myController.validateCity,
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              width: Get.width * 0.58,
              child: MyTextFieldHintWithImage(
                addHint: "phone_number".tr,
                mycontroller: phoneNoController,
                labelColor: MyColors.whiteColor,
                hintColor: MyColors.whiteColor,
                validator: myController.validatePhoneNo,
                suffixImageUrl: MyImageURL.info,
                suffixOnTap: () {
                  setState(() {
                    blurScreen = true;
                  });
                },
                readonly: false,
                edinputType: TextInputType.phone,
                obscureText: false,
                rightPadding: 0,
                // maxlimit: 10,
              ),
            ),
          ],
        ),
        Container(
            width: Get.width * 0.40,
            child: GestureDetector(
              onTap: () {
                goToNextScreen();
              },
              child: Image.asset(
                MyImageURL.check_circle,
                height: 50,
              ),
            ))
      ],
    );
  }

  buildAddressRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: Get.width * 0.58,
          child: MyTextFieldHintWithImage(
            imageUrl: MyImageURL.location_img,
            mycontroller: addressController,
            addHint: "address".tr,
            readonly: false,
            labelColor: MyColors.textColor,
            edinputType: TextInputType.name,
            obscureText: false,
            rightPadding: 10,
            maxlimit: 200,
            validator: myController.validateAddress,
          ),
        ),
        Container(
          width: Get.width * 0.40,
          child: MyTextFieldHintWithImage(
            addHint: "postal_code".tr,
            mycontroller: postalCodeController,
            readonly: false,
            labelColor: MyColors.textColor,
            edinputType: TextInputType.name,
            obscureText: false,
            leftPadding: 0,
            rightPadding: 35,
            validator: myController.validatePostalCode,
          ),
        ),
      ],
    );
  }

  buildBottomLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          // alignment: Alignment.bottomCenter,
          height: 95,
          // height: Get.height * 0.11,
          width: Get.width,
          decoration: BoxDecoration(
            color: MyColors.whiteColor,
            image: DecorationImage(
              image: AssetImage(MyImageURL.bottom_img),
              fit: BoxFit.fill,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              // goToNextScreen();
              /* ScreenTransition.navigateToScreenLeft(
                  screenName: TIChoseRouteModeScreen());*/

              callCreateProfileLaterAPI();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(
                    text_name: "create_later".tr,
                    txtcolor: MyColors.buttonBgColor,
                    txtfontsize: MyFontSize.size13,
                    myFont: MyStrings.cagliostro,
                  ),
                  Image.asset(MyImageURL.fleche_no_shadow),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void goToNextScreen() {
    if (dataController.selectedDate.value == "") {
      return MyCommonMethods.showInfoCenterDialog(
          msgContent: "dateofBirthreq".tr,
          myFont: MyStrings.courier_prime_bold);
    }
    /*if (croppedImg == null) {
      return MyCommonMethods.showInfoCenterDialog(
          msgContent: "validAvtar".tr,
          myFont: MyStrings.courier_prime_bold);
    }*/

    if (nameController.text == null || nameController.text.isEmpty) {
      return MyCommonMethods.showInfoCenterDialog(
          msgContent: "validName".tr,
          myFont: MyStrings.courier_prime_bold);
    }

    if (phoneNoController.text == null || phoneNoController.text.isEmpty) {
      return MyCommonMethods.showInfoCenterDialog(
          msgContent: "validPhoneNo".tr,
          myFont: MyStrings.courier_prime_bold);
    }
    callCreateProfileAPI();
    /*if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      MyUtility().focusOut(context);
      if (dataController.selectedDate.value == "") {
        return MyCommonMethods.showInfoCenterDialog(
            msgContent: "dateofBirthreq".tr,
            myFont: MyStrings.courier_prime_bold);
      }
      if (croppedImg == null) {
        return MyCommonMethods.showInfoCenterDialog(
            msgContent: "validAvtar".tr,
            myFont: MyStrings.courier_prime_bold);
      }
      callCreateProfileAPI();
      // ScreenTransition.navigateToScreenLeft(
      //     screenName: TIChoseRouteModeScreen());

    }*/
  }

  callCreateProfileAPI() async {
    ApiManager apiManager = ApiManager();
    Map<String, String> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      // "userId": "43",
      "userName": nameController.text,
      "dob": dataController.selectedDate.value,
      "address": addressController.text,
      "phoneNo": phoneNoController.text,
      "country": dataController.selectedValue.value.id != null &&
              dataController.selectedValue.value.id != ""
          ? dataController.selectedValue.value.id.toString()
          : "1",
      "city": cityController.text,
      "pincode": postalCodeController.text,
    };
    TIPrint(tag: "param", value: param.toString());
    await apiManager
        .createProfileAPI(param, croppedImg != null ? croppedImg.path : "")
        .then((value) {
      if (value != null) {
        MyPreference.setPrefIntValue(key: MyPreference.isProfile, value: 1);
        setPrefs();
        dataController.selectedDate.value = "";
        dataController.selectedValue.value.id = null;
        ScreenTransition.navigateToScreenLeft(
            screenName: TIChoseRouteModeScreen());
      } else {}
    });
  }

  callCreateProfileLaterAPI() async {
    ApiManager apiManager = ApiManager();
    Map<String, String> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      // "userId": "43",
      "userName": "",
      "dob": "",
      "address": "",
      "phoneNo": "",
      "country": "",
      "city": "",
      "pincode": "",
    };
    TIPrint(tag: "param", value: param.toString());
    await apiManager.createProfileAPI(param, "").then((value) {
      if (value != null) {
        MyPreference.setPrefIntValue(key: MyPreference.isProfile, value: 1);

        setPrefs();
        dataController.selectedDate.value = "";
        dataController.selectedValue.value.id = null;
        ScreenTransition.navigateToScreenLeft(
            screenName: TIChoseRouteModeScreen());
      } else {}
    });
  }

  void setPrefs() {
    /*String country = dataController.selectedValue.value.countryname != null &&
            dataController.selectedValue.value.countryname != ""
        ? dataController.selectedValue.value.countryname.toString()
        : dataController.countryList.value[0].countryname;*/
    MyPreference.setPrefStringValue(
        key: MyPreference.dob,
        value: dataController.selectedDate.value.toString());
    MyPreference.setPrefStringValue(
        key: MyPreference.phoneNumber,
        value: phoneNoController.text);
    /*MyPreference.setPrefStringValue(
        key: MyPreference.address, value: addressController.text);
    MyPreference.setPrefStringValue(
        key: MyPreference.city, value: cityController.text);
    MyPreference.setPrefStringValue(
        key: MyPreference.pinCode, value: postalCodeController.text);
    MyPreference.setPrefStringValue(key: MyPreference.country, value: country);*/
  }
}

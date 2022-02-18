import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'SettingsMenu/AutersInformationScreen.dart';

class TIPremiumInfoScreen extends StatefulWidget {
  @override
  _TIPremiumInfoScreenState createState() => _TIPremiumInfoScreenState();
}

class _TIPremiumInfoScreenState extends State<TIPremiumInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBodyContent(),
      ),
    );
  }

  _buildBodyContent() {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(MyImageURL.premiuminfoBg), fit: BoxFit.fill)),
        child: _buildBodyColumn());
  }

  _buildBodyColumn() {
    return Stack(children: [
      _columnContent(),
      Padding(
        padding: EdgeInsets.only(
          left: Get.height * .14,
          top: Get.height * .20,
        ),
        child: Align(
            alignment: Alignment.center,
            child: Image.asset(MyImageURL.triangle_premium)),
      ),
      _rowContent()
    ]);
  }

  _columnContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height * .07,
        ),
        Center(
          child: Text(
            "txtHaudospremium".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: MyFontSize.size23,
                fontFamily: MyFont.Cagliostro_reguler),
          ),
        ),
        SizedBox(
          height: Get.height * .020,
        ),
        Center(
          child: Text(
            "txtAbonmentMonth".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: MyFontSize.size23,
                fontFamily: MyFont.Cagliostro_reguler),
          ),
        ),
        Container(
          width: Get.width,
          height: Get.height * .18,
          margin:
              EdgeInsets.only(bottom: Get.height * .082, top: Get.height * .10),
          // padding: EdgeInsets.only(top: Get.height * .020),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(MyImageURL.curve_whiteshape),
                fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "£ 4,99",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyColors.lineColor,
                    fontSize: MyFontSize.size28,
                    fontFamily: MyFont.Courier_Prime_Bold),
              ),
              SizedBox(
                height: Get.height * .010,
              ),
              Text(
                "txtProchain".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyColors.lineColor,
                    fontSize: MyFontSize.size13,
                    fontFamily: MyFont.Courier_Prime),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * .030,
        ),
        Container(
          height: Get.height * .30,
          width: Get.height * .36,
          padding: EdgeInsets.only(left: Get.width * .050),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Get.width * .12),
                  bottomRight: Radius.circular(Get.width * .12))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * .06,
              ),
              Text(
                "txtAnnulable".tr,
                style: TextStyle(
                    color: MyColors.textColor,
                    fontSize: MyFontSize.size13,
                    fontFamily: MyFont.Courier_Prime_Bold),
              ),
              SizedBox(
                height: Get.height * .05,
              ),
              Text(
                "txtExclusive".tr,
                style: TextStyle(
                    color: MyColors.textColor,
                    fontSize: MyFontSize.size13,
                    fontFamily: MyFont.Courier_Prime),
              ),
              Text(
                "txtFonctiona".tr,
                style: TextStyle(
                    color: MyColors.textColor,
                    fontSize: MyFontSize.size13,
                    fontFamily: MyFont.Courier_Prime),
              ),
              SizedBox(
                height: Get.height * .04,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "txtVoirles".tr,
                  style: TextStyle(
                      color: MyColors.textColor,
                      fontSize: MyFontSize.size13,
                      fontFamily: MyFont.Courier_Prime_Bold_Italic),
                ),
                TextSpan(
                    text: " T&C",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: MyFontSize.size13,
                        fontFamily: MyFont.Courier_Prime_Bold_Italic),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                      callTermsApi();
                        /*ScreenTransition.navigateToScreenLeft(
                            screenName: AutersInformationScreen(
                          title: MyStrings.terms_conditions,
                          desc:
                              "« Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. » \n\n« Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa"
                              " qui officia deserunt mollit anim id est laborum. »",
                        ));*/
                      })
              ])),
              Container(
                width: Get.width * .40,
                height: Get.height * .010,
                margin: EdgeInsets.all(Get.height * .005),
                decoration: BoxDecoration(
                    color: MyColors.lightGreenColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Get.height * .020))),
              )
            ],
          ),
        )
      ],
    );
  }

  _rowContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: Get.height * .015, left: Get.width * .03),
          child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(MyImageURL.back,
                width: 25,)),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: Get.height * .015, right: Get.width * .015),
          child: GestureDetector(
              onTap: () {
                CommonMethod.getAppMode();
              },
              child: Image.asset(MyImageURL.haudos_logo)),
        )
      ],
    );
  }

   callTermsApi() async{
    ApiManager apiManager = ApiManager();
     Get.dialog(Loading());

     await apiManager.getAuthInfo(ApiParameter.TERMS_ID).then((response){
       Get.back();
       if(response != null)
         ScreenTransition.navigateToScreenLeft(
             screenName: AutersInformationScreen(
               title: "terms_conditions".tr,
               desc:response["details"],

             ));
     });


   }
}

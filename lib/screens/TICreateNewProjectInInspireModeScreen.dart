import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

import 'InspiredMode/ChooseProjectNameScreen.dart';

class TICreateNewProjectInInspireModeScreen extends StatefulWidget {
  @override
  _TICreateNewProjectInInspireModeScreenState createState() =>
      _TICreateNewProjectInInspireModeScreenState();
}

class _TICreateNewProjectInInspireModeScreenState
    extends State<TICreateNewProjectInInspireModeScreen> {
  bool showPopup = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Scaffold(
              body: _buildBodyContent()),
    );
  }

  /*_buildBodyContent() {
    return _buildCreateProjectOption();
  }*/



  _buildBodyContent() {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImageURL.login),
              fit: BoxFit.fill)),
      child: Column(
        children: [
          MyTopHeader(logoImgUrl: MyImageURL.home_icon,),
          MyTitlebar(title:"txtASTU".tr ,),

          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: Get.height * .05,left: Get.width*0.30),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(ChooseProjectNameScreen(mKey: MyStrings.insp_key));
                      },
                      child: Container(
                        height: Get.height * .20,
                        width: Get.height * .20,
                        decoration: BoxDecoration(
                            border: Border.all(color: MyColors.whiteColor,width: 1.0),
                           shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    AssetImage(MyImageURL.createprojectcircle1))),
                        child: Center(
                          child: Text(
                            "txtOUI".tr,
                            style: TextStyle(
                                fontFamily: MyFont.Courier_Prime_Bold,
                                color: Colors.white,
                                fontSize: MyFontSize.size28),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.02,),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            CommonMethod.getAppMode();
                          },
                          child: Container(
                            height: Get.height * .20,
                            width: Get.height * .20,
                            decoration: BoxDecoration(
                                border: Border.all(color: MyColors.whiteColor,width: 1.0),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        AssetImage(MyImageURL.createprojectcircle2))),
                            child: Center(
                              child: Text(
                                "txtNON".tr,
                                style: TextStyle(
                                    fontFamily: MyFont.Courier_Prime_Bold,
                                    color: Colors.white,
                                    fontSize: MyFontSize.size28),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: Get.width * .03,top: 40),

                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showPopup = true;
                                  });
                                },
                                child: Image.asset(
                                  MyImageURL.info_big,
                                  height: Get.height * .030,
                                  width: Get.height * .030,
                                  fit: BoxFit.contain,
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
              _buildPopup(),
            ],
          ),

          SizedBox(
            height: Get.height * .060,
          ),
          Container(
            margin: EdgeInsets.only(
                left: Get.width * .040, right: Get.width * .040),
            child: showPopup == false ? Text.rich(
              TextSpan(children: [
                WidgetSpan(
                    child: Padding(
                  padding: EdgeInsets.only(right: Get.width * .030),
                  child: Image.asset(MyImageURL.choose_your_leftquote),
                )),
                TextSpan(
                  text: "txtLeVoyage".tr,
                  style: TextStyle(
                      color: MyColors.whiteColor.withOpacity(1),
                      fontSize: MyFontSize.size14,
                      fontFamily: MyFont.Courier_Prime_Italic),
                ),
                WidgetSpan(
                    child: Padding(
                  padding: EdgeInsets.only(left: Get.width * .030),
                  child: Image.asset(MyImageURL.choose_your_rightquote),
                )),
              ]),
              textAlign: TextAlign.center,
            ):Container(),
          ),
          SizedBox(
            height: Get.height * .050,
          ),
          Center(
              child: Container(
            margin: EdgeInsets.only(
                left: Get.width * .040, right: Get.width * .040),
            child: showPopup == false ? Text(
              "txtGuyde".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MyColors.whiteColor.withOpacity(1),
                  fontSize: MyFontSize.size14,
                  fontFamily: MyFont.Courier_Prime_Bold),
            ):Container(),
          )),
        ],
      ),
    );
  }

  _buildPopup() {
    return Visibility(
      visible: showPopup,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: Get.height * .37,
          width: Get.height * .37,
          margin: EdgeInsets.only(top: Get.height * .07),
          decoration: BoxDecoration(
            // The child of a round Card should be in round shape
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 2.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      showPopup = false;
                    });
                  },
                  child: Image.asset(
                    MyImageURL.cross3x,
                    height: 40,width: 40,
                  )),
              SizedBox(
                height: Get.height * .020,
              ),
              Container(
                width: Get.width * .42,
                child: Text(
                  "txtSitun".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MyFontSize.size14,
                      fontFamily: MyFont.Courier_Prime),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
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
          Scaffold(backgroundColor: Colors.black12,
              body: _buildBodyContent()),
    );
  }

  _buildBodyContent() {
    return Stack(
      children: [
        _buildCreateProjectOption(),
        _buildbackArrow(),

        _buildPopup(),
      ],
    );
  }

  _buildbackArrow() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(MyImageURL.back,
                width: 25,)),
          GestureDetector(
              onTap: (){
                CommonMethod.getAppMode();
              },
              child: Image.asset(MyImageURL.haudos_logo)),
        ],
      ),
    );
  }

  _buildCreateProjectOption() {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImageURL.bgchoose_your_route),
              fit: BoxFit.fill)),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: Get.height * .12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(ChooseProjectNameScreen(mKey: MyStrings.insp_key));
                      },
                      child: Container(
                        height: Get.height * .20,
                        width: Get.height * .20,
                        decoration: BoxDecoration(
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
                    GestureDetector(
                      onTap: (){
                        CommonMethod.getAppMode();
                      },
                      child: Container(
                        height: Get.height * .20,
                        width: Get.height * .20,
                        decoration: BoxDecoration(
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
                  ],
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  margin: EdgeInsets.only(right: Get.width * .08),
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
                      )))),
          Container(
            width: Get.width,
            height: Get.height * .18,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    MyImageURL.bgchoose_your_curveshape,
                  ),
                  fit: BoxFit.fill),
            ),
            child: Center(
                child: Text(
              "txtASTU".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MyFontSize.size20,
                  fontFamily: MyFont.Cagliostro_reguler),
            )),
          ),
          SizedBox(
            height: Get.height * .060,
          ),
          Container(
            margin: EdgeInsets.only(
                left: Get.width * .040, right: Get.width * .040),
            child: Text.rich(
              TextSpan(children: [
                WidgetSpan(
                    child: Padding(
                  padding: EdgeInsets.only(right: Get.width * .030),
                  child: Image.asset(MyImageURL.choose_your_leftquote),
                )),
                TextSpan(
                  text: "txtLeVoyage".tr,
                  style: TextStyle(
                      color: MyColors.buttonBgColor,
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
            ),
          ),
          SizedBox(
            height: Get.height * .050,
          ),
          Center(
              child: Container(
            margin: EdgeInsets.only(
                left: Get.width * .040, right: Get.width * .040),
            child: Text(
              "txtGuyde".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MyColors.buttonBgColor,
                  fontSize: MyFontSize.size14,
                  fontFamily: MyFont.Courier_Prime_Bold),
            ),
          )),
        ],
      ),
    );
  }

  _buildPopup() {
    return Visibility(
      visible: showPopup,
      child: BackdropFilter(
        filter: showPopup
            ? ImageFilter.blur(sigmaX: 5, sigmaY: 5)
            : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: Get.height * .28,
            width: Get.height * .28,
            margin: EdgeInsets.only(top: Get.height * .05),
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
      ),
    );
  }
}

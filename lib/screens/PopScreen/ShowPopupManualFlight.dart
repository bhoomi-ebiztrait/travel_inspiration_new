import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';

import '../../MyWidget/TICommonPopup.dart';
import '../../MyWidget/TIMyCustomRoundedCornerButton.dart';

class ShowPopupManualFlight extends StatelessWidget {
  String title;
  String myContent;
  ShowPopupManualFlight({Key key, this.title,this.myContent}) : super(key: key);
MyController myController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:MyColors.buttonBgColorHome.withOpacity(0.3) ,
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          color: MyColors.buttonBgColorHome.withOpacity(0.7),
          child:Column(
            children: [
              MyTopHeader(
                logoImgUrl: MyImageURL.haudos_logo,
              ),
              SizedBox(height: Get.height*0.07,),
              TICommonPopup(
                childWidget: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Get.height * .025, right: Get.height * .02),
                        child: GestureDetector(
                          onTap: () {
                            myController.showFlightAndTrainPopup.value = false;
                            Get.back();
                          },
                          child: Image.asset(
                            MyImageURL.cross3x,
                            height: Get.height * .050,
                            width: Get.height * .050,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .04,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: Get.width * .09, right: Get.width * .09),
                      child: MyText(
                        text_name: "txtFlightPopupData".tr,
                        myFont: MyFont.Courier_Prime,
                        txtfontsize: MyFontSize.size13,
                        txtAlign: TextAlign.center,
                        txtcolor: MyColors.textColor,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .06,
                    ),
                    Image.asset(
                      MyImageURL.document_popup,
                      height: Get.height * .08,
                      width: Get.height * .08,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: Get.height * .06,
                    ),
                    MyText(
                      text_name: "or".tr,
                      myFont: MyFont.Courier_Prime_Bold,
                      txtfontsize: MyFontSize.size18,
                      txtcolor: MyColors.textColor,
                      txtAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: Get.height * .06,
                    ),
                    TIMyCustomRoundedCornerButton(
                      onClickCallback: () {},
                      btnText: "txtDeviensPremium".tr,
                      myFont: MyFont.Courier_Prime_Bold,
                      fontSize: MyFontSize.size18,
                      textColor: Colors.white,
                      buttonWidth: Get.width * .60,
                      buttonHeight: Get.height * .060,
                      borderRadius: Get.width * .060,
                      btnBgColor: MyColors.buttonBgColor,
                    )
                  ],
                ),
              ),
            ],
          ),


        ),
      ),
    );
  }
}

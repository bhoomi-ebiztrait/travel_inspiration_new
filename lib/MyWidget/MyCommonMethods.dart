import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_inspiration/MyWidget/MyTextButton.dart';
import 'package:travel_inspiration/screens/PhotoPreviewScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

import 'MyText.dart';

class MyCommonMethods {
  static bool isSelected = false;

  static int currentYear = 2021;
  static int lastYear = 2040;

  // static List<String> yearList;

  static showAlertDialog({String msgContent, String myFont}) {
    return Get.dialog(
        AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              MyImageURL.cross,
                              width: 30,
                            )),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Html(
                        data: msgContent,
                      ),
                      // MyText(text_name: msgContent,
                      //   txtcolor: MyColors.textColor,
                      //   txtfontsize: MyFontSize.size13,
                      //   txtAlign: TextAlign.start,
                      //   myFont: MyFont.Cagliostro_reguler,),
                    ],
                  ),
                ),
              ),
            )),
        barrierDismissible: false);
  }

  static showAlertDialogCircular({String msgContent, String myFont}) {
    return Get.dialog(
        AlertDialog(
            content: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(MyImageURL.bgchoose_your_route),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColors.whiteColor
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                MyImageURL.cross,
                                width: 30,
                              )),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        // Html(data: msgContent,),
                        MyText(
                          text_name: msgContent,
                          txtcolor: MyColors.textColor,
                          txtfontsize: MyFontSize.size13,
                          txtAlign: TextAlign.start,
                          myFont: MyFont.Cagliostro_reguler,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
        barrierDismissible: false);
  }

  static showInfoCenterDialog({String msgContent, String myFont}) {
    return Get.dialog(
        AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
              child: Container(
                width: Get.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            MyImageURL.cross,
                            width: 30,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: MyText(
                        text_name: msgContent,
                        txtcolor: MyColors.textColor,
                        txtfontsize: MyFontSize.size13,
                        myFont: myFont,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                  ],
                ),
              ),
            )),
        barrierDismissible: false);
  }

  static showImageOptionDialog() {
    return Get.dialog(
        AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText(
                      text_name: "choose_option".tr,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size16,
                      txtAlign: TextAlign.start,
                      myFont: MyStrings.courier_prime_bold,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    GestureDetector(
                        onTap: () {
                          // _openGallery();
                          Get.to(PhotoPreviewScreen("gallery".tr));
                        },
                        child: MyText(
                          text_name: "gallery".tr,
                          txtcolor: MyColors.textColor,
                          txtfontsize: MyFontSize.size13,
                          txtAlign: TextAlign.start,
                        )),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(PhotoPreviewScreen("camera".tr));
                        },
                        child: MyText(
                          text_name: "camera".tr,
                          txtcolor: MyColors.textColor,
                          txtfontsize: MyFontSize.size13,
                          txtAlign: TextAlign.start,
                        )),
                  ],
                ),
              ),
            )),
        barrierDismissible: false);
  }

  static showDateDialog(String selectedDate) {
    return Get.dialog(AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            side: BorderSide.none),
        content: Container(
          // height: 300,
          width: Get.width * 0.6,
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.all(Radius.circular(30)),
              color: MyColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: MyColors.whiteColor,
                  blurRadius: 1.0,
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                text_name: "select_date".tr,
                txtcolor: MyColors.textColor,
                txtfontsize: MyFontSize.size13,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              setDivider(),
              Container(
                padding: const EdgeInsets.only(top: 10),
                height: Get.height * 0.30,
                width: Get.width,
                // color: MyColors.buttonBgColor,
                child: GridView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 31,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: Get.height / 580,
                      // mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Get.back(result: (index + 1).toString());
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (index + 1).toString() == selectedDate
                                    ? MyColors.lightGreenColor
                                    : MyColors.whiteColor,
                              ),
                              // color: (index +1).toString() == selectedDate? MyColors.lightGreenColor:MyColors.whiteColor,
                              child: MyTextButton(
                                btn_name: (index + 1).toString(),
                                txtcolor: MyColors.textColor,
                              )));
                    }),
              ),
            ],
          ),
        )));
  }

  static showMonthDialog(String selectedMonth) {
    return Get.dialog(AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            side: BorderSide.none),
        content: Container(
          width: Get.width * 0.9,
          decoration: BoxDecoration(color: MyColors.whiteColor, boxShadow: [
            BoxShadow(
              color: MyColors.whiteColor,
              blurRadius: 1.0,
            ),
          ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                text_name: "select_month".tr,
                txtcolor: MyColors.textColor,
                txtfontsize: MyFontSize.size13,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              setDivider(),
              Container(
                padding: const EdgeInsets.only(top: 10),
                height: Get.height * 0.30,
                width: Get.width,
                child: GridView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: MyStrings.monthList.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: Get.height / 390,
                      mainAxisSpacing: 20.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Get.back(result: MyStrings.monthList[index]);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color:
                                    MyStrings.monthList[index] == selectedMonth
                                        ? MyColors.lightGreenColor
                                        : MyColors.whiteColor,
                              ),
                              child: MyTextButton(
                                btn_name: MyStrings.monthList[index],
                                txtcolor: MyColors.textColor,
                              )));
                    }),
              ),
            ],
          ),
        )));
  }

  static showYearDialog(String selectedYear) {
    // getYearList();
    // print("yearrr: ${yearList[0]}");
    return Get.dialog(AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            side: BorderSide.none),
        content: Container(
          width: Get.width * 0.9,
          decoration: BoxDecoration(color: MyColors.whiteColor, boxShadow: [
            BoxShadow(
              color: MyColors.whiteColor,
              blurRadius: 1.0,
            ),
          ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                text_name: "select_year".tr,
                txtcolor: MyColors.textColor,
                txtfontsize: MyFontSize.size13,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              setDivider(),
              Container(
                padding: const EdgeInsets.only(top: 10),
                height: Get.height * 0.25,
                width: Get.width,
                child: GridView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: MyStrings.yearList.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: Get.height / 390,
                      mainAxisSpacing: 20.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Get.back(result: MyStrings.yearList[index]);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: MyStrings.yearList[index] == selectedYear
                                    ? MyColors.lightGreenColor
                                    : MyColors.whiteColor,
                              ),
                              child: MyTextButton(
                                btn_name: MyStrings.yearList[index],
                                txtcolor: MyColors.textColor,
                              )));
                    }),
              ),
            ],
          ),
        )));
  }

  static getYearList() {
    /* yearList = [];
     for(int i= lastYear;i<currentYear;i--){
       yearList.add(i.toString());
     }*/
  }

  static setDivider() {
    return Container(
      color: MyColors.lightGreenColor,
      height: 3,
      width: Get.width * 0.4,
    );
  }
}

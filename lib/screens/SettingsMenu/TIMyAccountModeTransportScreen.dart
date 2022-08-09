import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIMyAccountNotificationModel.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

import '../../MyWidget/MyGradientBottomMenu.dart';
import '../../MyWidget/MySettingTop.dart';

class TIMYAccountModeTransportScreen extends StatelessWidget {
  MyController myController = Get.put(MyController());
  double mSize = 60;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColors.settingBgColor,
      body: _buildBodyContent(),

      bottomNavigationBar:  MyGradientBottomMenu(selString:MyStrings.settings,iconList: [MyImageURL.profile_icon,MyImageURL.galerie,MyImageURL.home_menu,MyImageURL.world_icon,MyImageURL.setting_selected],bgImg: MyImageURL.change_pw_bottom,bgColor: MyColors.buttonBgColorHome.withOpacity(0.7),),
    );
  }

  _buildBodyContent() {
    return Obx(() => SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MySettingTop(title: "txtmyCompte".tr,),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: Get.height * .040,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0,right: 10),
                        child: MyTextStart(
                          text_name: "txtmodede".tr,
                          txtcolor: MyColors.textColor,
                          myFont: MyFont.Courier_Prime_Bold,
                          txtfontsize: MyFontSize.size13,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .020,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0,right: 10),
                        child: MyTextStart(
                          text_name: "txtchoisdetes".tr,
                          txtcolor: MyColors.textColor,
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size13,
                        ),
                      ),

                      SizedBox(
                        height: Get.height * .04,
                      ),
                      _buildTransportSwitchWidget(),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
  }

  _buildTransportSwitchWidget() {
    return Table(
      children: [
        _tableRow1(),
        _tableRow2(),
        _tableRow3(),
      ],
    );
  }

  _tableRow1() {
    return TableRow(
      children: [
        TableCell(
            child: Column(
          children: [
            Container(
                height:mSize,
                width:mSize,
                child: Image.asset(MyImageURL.car)),
            SizedBox(
              height: Get.height * .010,
            ),
            GestureDetector(
                onTap: () {
                  resetValue();
                  myController.isCarSwitchOn.value =
                      !myController.isCarSwitchOn.value;
                },
                child: myController.isCarSwitchOn.value
                    ? Image.asset(MyImageURL.switch_on)
                    : Image.asset(MyImageURL.switch_off))
          ],
        )),
        TableCell(
            child: Column(
          children: [
            Container(
                height:mSize,
                width:mSize,
                child: Image.asset(MyImageURL.bike)),
            SizedBox(
              height: Get.height * .010,
            ),
            GestureDetector(
                onTap: () {
                  resetValue();
                  myController.isBikeSwitchOn.value =
                      !myController.isBikeSwitchOn.value;
                },
                child: myController.isBikeSwitchOn.value
                    ? Image.asset(MyImageURL.switch_on)
                    : Image.asset(MyImageURL.switch_off))
          ],
        )),
        TableCell(
            child: Column(
          children: [
            Container(
                height:mSize,
                width:mSize,
                child: Image.asset(MyImageURL.train)),
            SizedBox(
              height: Get.height * .010,
            ),
            GestureDetector(
                onTap: () {
                  resetValue();
                  myController.isTrainSwitchOn.value =
                      !myController.isTrainSwitchOn.value;
                },
                child: myController.isTrainSwitchOn.value
                    ? Image.asset(MyImageURL.switch_on)
                    : Image.asset(MyImageURL.switch_off))
          ],
        )),
      ],
    );
  }

  _tableRow2() {
    return TableRow(children: [
      SizedBox(
        height: Get.height * .040,
      ),
      SizedBox(
        height: Get.height * .040,
      ),
      SizedBox(
        height: Get.height * .040,
      ),
    ]);
  }

  _tableRow3() {
    return TableRow(children: [
      TableCell(
          child: Column(
        children: [
          Container(
              height:mSize,
              width:mSize,
              child: Image.asset(MyImageURL.cycle)),
          SizedBox(
            height: Get.height * .010,
          ),
          GestureDetector(
              onTap: () {
                resetValue();
                myController.isCycleSwitchOn.value =
                    !myController.isCycleSwitchOn.value;
              },
              child: myController.isCycleSwitchOn.value
                  ? Image.asset(MyImageURL.switch_on)
                  : Image.asset(MyImageURL.switch_off))
        ],
      )),
      TableCell(
          child: Column(
        children: [
          Container(
              height:mSize,
              width:mSize,
              child: Image.asset(MyImageURL.scooter)),
          SizedBox(
            height: Get.height * .010,
          ),
          GestureDetector(
              onTap: () {
                resetValue();
                myController.isScooterSwitchOn.value =
                    !myController.isScooterSwitchOn.value;
              },
              child: myController.isScooterSwitchOn.value
                  ? Image.asset(MyImageURL.switch_on)
                  : Image.asset(MyImageURL.switch_off))
        ],
      )),
      TableCell(
          child: Column(
        children: [
          Container(
              height:mSize,
              width:mSize,
              child: Image.asset(MyImageURL.walkingman)),
          SizedBox(
            height: Get.height * .010,
          ),
          GestureDetector(
              onTap: () {
                resetValue();
                myController.isManSwitchOn.value =
                    !myController.isManSwitchOn.value;
              },
              child: myController.isManSwitchOn.value
                  ? Image.asset(MyImageURL.switch_on)
                  : Image.asset(MyImageURL.switch_off))
        ],
      )),
    ]);
  }

  void resetValue() {
   /* myController.isCarSwitchOn.value = false;
    myController.isBikeSwitchOn.value = false;
    myController.isCycleSwitchOn.value = false;
    myController.isScooterSwitchOn.value = false;
    myController.isTrainSwitchOn.value = false;
    myController.isManSwitchOn.value = false;*/
  }
}

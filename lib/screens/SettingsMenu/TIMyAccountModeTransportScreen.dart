import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIMyAccountNotificationModel.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class TIMYAccountModeTransportScreen extends StatelessWidget {
  MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyContent(),
      bottomSheet: Container(
        height: Get.height * .10,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(MyImageURL.setting_bottom),
                fit: BoxFit.fill)),
      ),
    );
  }

  _buildBodyContent() {
    return Obx(() => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTopHeader(
                headerImgUrl: MyImageURL.setting_top,
                headerName: "txtmyCompte".tr,
                logoImgUrl: MyImageURL.haudos_logo,
              ),
              SizedBox(
                height: Get.height * .030,
              ),
              Container(
                margin: EdgeInsets.only(left: Get.width * .08),
                child: Column(
                  children: [
                    Text(
                      "txtmodede".tr,
                      style: TextStyle(
                          color: MyColors.textColor,
                          fontFamily: MyFont.Courier_Prime_Bold,
                          fontSize: MyFontSize.size13),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * .030,
              ),
              Container(
                margin: EdgeInsets.only(left: Get.width * .08),
                child: Text(
                  "txtchoisdetes".tr,
                  style: TextStyle(
                      color: MyColors.textColor,
                      fontFamily: MyFont.Courier_Prime,
                      fontSize: MyFontSize.size13),
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              _buildTransportSwitchWidget(),
            ],
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
                height:50,
                width:50,
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
            Image.asset(MyImageURL.bike),
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
            Image.asset(MyImageURL.train),
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
        height: Get.height * .030,
      ),
      SizedBox(
        height: Get.height * .030,
      ),
      SizedBox(
        height: Get.height * .030,
      ),
    ]);
  }

  _tableRow3() {
    return TableRow(children: [
      TableCell(
          child: Column(
        children: [
          Container(
              height:50,
              width:50,
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
          Image.asset(MyImageURL.scooter),
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
          Image.asset(MyImageURL.walkingman),
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

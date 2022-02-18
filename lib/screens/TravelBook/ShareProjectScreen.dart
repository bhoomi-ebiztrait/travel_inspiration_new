import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareProjectScreen extends StatefulWidget {
  int id, index;

  ShareProjectScreen(this.id, this.index);

  @override
  _ShareProjectScreenState createState() => _ShareProjectScreenState();
}

class _ShareProjectScreenState extends State<ShareProjectScreen> {
  MyController myController = Get.put(MyController());

  bool isHaudosContact = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
    };
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myController.getHaudosUser(param);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyTopHeader(
                // headerName:_centerTitle(),
                headerName:
                    "${myController.allProjectList[widget.index].title.toUpperCase()}\n${myController.allProjectList[widget.index].pinDestination != null ? myController.allProjectList[widget.index].pinDestination.toUpperCase() : ""}",
                headerImgUrl: MyImageURL.travel_book_top,
                logoImgUrl: MyImageURL.haudos_logo,
                logoCallback: () {
                  CommonMethod.getAppMode();
                },
              ),
              SizedBox(
                height: Get.height * .020,
              ),
              MyText(
                text_name: "toShare".tr,
                myFont: MyFont.Courier_Prime_Bold,
                txtfontsize: MyFontSize.size13,
                txtcolor: MyColors.textColor,
                txtAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height * .020,
              ),
              _buildTitle(),
              isHaudosContact == true
                  ? _buildContactView()
                  : _buildOptionView(),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomLayout(
          imgUrl: MyImageURL.travel_book_bottom,
        ),
      ),
    );
  }

  _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMyContactBtn(),
        _buildOtherBtn(),
      ],
    );
  }

  _buildMyContactBtn() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isHaudosContact = true;
        });
      },
      child: Container(
        width: Get.width * .38,
        height: Get.height * .050,
        decoration: BoxDecoration(
          color: isHaudosContact == true
              ? MyColors.expantionTileBgColor
              : MyColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(Get.width * .050)),
        ),
        child: MyText(
          text_name: "myHaudosContacts".tr,
          myFont: MyFont.Courier_Prime_Bold,
          txtfontsize: MyFontSize.size13,
          txtcolor: isHaudosContact == true
              ? MyColors.whiteColor
              : MyColors.textColor,
          txtAlign: TextAlign.center,
        ),
      ),
    );
  }

  _buildOtherBtn() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isHaudosContact = false;
        });
      },
      child: Container(
        width: Get.width * .38,
        height: Get.height * .050,
        decoration: BoxDecoration(
          color: isHaudosContact == false
              ? MyColors.expantionTileBgColor
              : MyColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(Get.width * .050)),
        ),
        child: MyText(
          text_name: "others".tr,
          myFont: MyFont.Courier_Prime_Bold,
          txtfontsize: MyFontSize.size13,
          txtcolor: isHaudosContact == false
              ? MyColors.whiteColor
              : MyColors.textColor,
          txtAlign: TextAlign.center,
        ),
      ),
    );
  }

  _buildOptionView() {
    return Column(
      //  mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        _buildOption(MyImageURL.whatsapp_icon, "whatsApp".tr, 0),
        SizedBox(
          height: 20,
        ),
        _buildOption(MyImageURL.email_icon, "email".tr, 1),
        SizedBox(
          height: 20,
        ),
        _buildOption(MyImageURL.txt_icon, "txtMsg".tr, 2),
      ],
    );
  }

  _buildOption(imgUrl, mText, index) {
    return GestureDetector(
      onTap: () {
        if (index == 0)
          openWatsapp();
        else if (index == 1)
          openEmail();
        else if (index == 2) openSMS();
      },
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(imgUrl),
                ],
              )),
          SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: MyTextStart(
                text_name: mText,
                txtfontsize: MyFontSize.size13,
                txtcolor: MyColors.textColor,
                myFont: MyStrings.courier_prime_bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildContactView() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: ListView.builder(
          itemCount: myController.haudosUserList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                callSendNotificationApi(index);
              },
              child: Column(
                children: [
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: MyTextStart(
                        text_name: myController.haudosUserList[index].userName,
                        txtcolor: MyColors.textColor,
                        myFont: MyStrings.courier_prime_bold,
                        txtfontsize: MyFontSize.size13,
                      ),
                    ),
                    tileColor: MyColors.expantionTileBgColor.withOpacity(0.32),
                  ),
                  Container(
                    width: Get.width,
                    height: Get.height * 0.001,
                    color: MyColors.buttonBgColor.withOpacity(0.50),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  callSendNotificationApi(int index) async {
    ApiManager apiManager = ApiManager();
    Map<String, dynamic> params = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "sendTo": myController.haudosUserList[index].userId,
      "projectId": widget.id.toString(),
    };

    await apiManager.sendNotificationToUser(params);
  }

  getSharedMsg() {
    // ADENTURE2023 - MONTPELLIER
    // Project in reflective mode - 525 km
    // 2 people - June 20, 2023
    StringBuffer sbHotel = new StringBuffer();
    StringBuffer sbRestarant = new StringBuffer();
    StringBuffer sbActivity = new StringBuffer();

    if (myController.allProjectList[widget.index].typePin != null) {
      if (myController.allProjectList[widget.index].typePin.length > 0) {
        for (int i = 0;
            i < myController.allProjectList[widget.index].typePin.length;
            i++) {
          if (myController.allProjectList[widget.index].typePin[i].type ==
              ApiParameter.hotelType) {
            sbHotel.write(
                myController.allProjectList[widget.index].typePin[i].title);
            sbHotel.writeln(", ");
          } else if (myController
                  .allProjectList[widget.index].typePin[i].type ==
              ApiParameter.resturantType) {
            sbRestarant.write(
                myController.allProjectList[widget.index].typePin[i].title);
            sbRestarant.writeln(", ");
          } else if (myController
                  .allProjectList[widget.index].typePin[i].type ==
              ApiParameter.activityType) {
            sbActivity.write(
                myController.allProjectList[widget.index].typePin[i].title);
            sbActivity.writeln(", ");
          }
        }
      }
    }

    DateTime mDate = DateFormat('yyyy-MM-dd')
        .parse((myController.allProjectList[widget.index].projectVacationDate));
    String mDateStr = DateFormat('MMMM dd, yyyy').format(mDate);
    String msg =
        "${myController.allProjectList[widget.index].title.toUpperCase()} - ${myController.allProjectList[widget.index].pinDestination != null ? myController.allProjectList[widget.index].pinDestination.toUpperCase() : ""}\n Project in ${myController.allProjectList[widget.index].modeName} - ${myController.allProjectList[widget.index].totalKm} km\n${myController.allProjectList[widget.index].projectNoPerson} people - ${mDateStr}\n\nHotel- ${sbHotel.toString()}\nRestaurant- ${sbRestarant.toString()}\nActivity- ${sbActivity.toString()}";
    return msg;
  }

  openWatsapp() async {
    // var whatsapp ="+919712821750";
    var androidUrl = "whatsapp://send?text=${getSharedMsg()}";
    // var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
    // var whatsappURl_android = "https://wa.me/$phone/?text=${Uri.parse(message)}";
    var iosURL = "https://wa.me?text=${Uri.parse(getSharedMsg())}";

    launchURL(androidUrl, iosURL);
  }

  openEmail() async {
    var androidUrl = "mailto:?subject=" "&body=${getSharedMsg()}";
    var iosURL = "mailto:?subject=" "&body=${Uri.parse(getSharedMsg())}";
    launchURL(androidUrl, iosURL);
  }

  openSMS() {
    var androidUrl = "sms:?body=${getSharedMsg()}";
    var iosURL = "sms:?body=${Uri.parse(getSharedMsg())}";
    launchURL(androidUrl, iosURL);
  }

  void launchURL(String androidUrl, String iosURL) async {
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(iosURL)) {
        await launch(iosURL, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("App not installed")));
      }
    } else {
      // android , web
      if (await canLaunch(androidUrl)) {
        await launch(androidUrl);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("App not installed")));
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyCustomListWithStar.dart';
import 'package:travel_inspiration/MyWidget/MyCustomRowViewWIthImage.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyCustomRoundedCornerButton.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIDestinationInProgressModel.dart';
import 'package:travel_inspiration/screens/TIPinDestinationToProjectScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

import 'TravelBook/TITravelougeScreen.dart';

class TIDestinationInProgressScreen extends StatefulWidget {
  @override
  State<TIDestinationInProgressScreen> createState() =>
      _TIDestinationInProgressScreenState();
}

class _TIDestinationInProgressScreenState
    extends State<TIDestinationInProgressScreen> {
  MyController myController = Get.find();
  bool isStopped = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double radious =
        (double.parse(myController.selectedProject.value.totalKm)) * 1000;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myController.getCities(50000);
      // myController.getCities(radious);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyContent();
  }

  _buildBodyContent() {
    return Container(
      margin:
          EdgeInsets.only(top: Get.height * 0.02, bottom: Get.height * 0.02),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(Get.width * 0.12))),
      child: _buildColumn(),
    );
  }

  _buildColumn() {
    String btn_text = isStopped == true
        ? "stop_journey".tr
        : "txtArretermonparcours".tr;
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
                top: Get.height * .020, right: Get.height * .020),
            child: GestureDetector(
              onTap: () {
                myController.showDestinationInProgressPopup.value = false;
              },
              child: Image.asset(
                // MyImageURL.cross_gray3x,
                MyImageURL.cross,
                height: Get.height * .035,
                width: Get.height * .035,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: MyText(
            text_name: isStopped == true
                ? "choose_destination_complete_vacation_plan".tr
                : "current_destination".tr,
            myFont: MyFont.Courier_Prime_Bold,
            txtfontsize: MyFontSize.size13,
            txtcolor: MyColors.textColor,
            txtAlign: TextAlign.center,
            //height: 1,
          ),
        ),
        SizedBox(
          height: Get.height * .030,
        ),
        TIMyCustomRoundedCornerButton(
          onClickCallback: () {
            setState(() {
              isStopped = true;
              if (btn_text == "stop_journey".tr) {
                Get.to(() => TITravelougeScreen(
                    double.parse(myController.selectedProject.value.totalKm)));
              }
            });
          },
          btnText: btn_text,
          fontSize: MyFontSize.size9,
          textColor: MyColors.txtWhiteColor,
          myFont: MyFont.Courier_Prime_Bold,
          btnBgColor: MyColors.buttonBgColor,
          buttonWidth: Get.width * .40,
          buttonHeight: Get.height * .040,
        ),
        SizedBox(
          height: Get.height * 0.05,
        ),
        Expanded(child: _desinationInProgressList()),
      ],
    );
  }

  _desinationInProgressList() {
    return Obx(() {
      return ListView.builder(
          itemCount: myController.mList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (isStopped == true) {
                  myController.selectedPlace.value = myController.mList[index];
                  // call pin destination api
                  callPinDestinationAPI();
                }
              },
             /* child: MyCustomRowViewWithImage(
                heading: myController.mList[index].name,
                title: myController.mList[index].description,
                subTitle: myController.mList[index].content,
                imageUrl: myController.mList[index].photo_ref != null ?getPhotoImage(myController.mList[index].photo_ref) : myController.mList[index].imgUrl,
              ),*/
              child: MyCustomRowViewWithImage(
                  myController.mList[index]
              ),
            );
          });
    });
    /*if(myController.mList != null && myController.mList.length >0) {

    }else{
      return Container();
    }*/
  }

  callPinDestinationAPI() async {
    ApiManager apiManager = ApiManager();
    Map<String, dynamic> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "project_id": myController.selectedProject.value.id,
      "pin_destination": myController.selectedPlace.value.name,
    };

    await apiManager.pinDestinationAPI(param).then((value) {
      if (value) {
        Get.to(TIPinDestinationToProjectScreen(travelLougeTitle: "txtPinDestination".tr,));
      }
    });
  }
}

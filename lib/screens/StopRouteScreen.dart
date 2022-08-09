import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyCustomRowViewWIthImage.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyCustomRoundedCornerButton.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/TIPinDestinationToProjectScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TITravelougeScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';

class StopRouteScreen extends StatefulWidget {
String projId,km;
StopRouteScreen(this.projId,this.km);
  @override
  _StopRouteScreenState createState() => _StopRouteScreenState();
}

class _StopRouteScreenState extends State<StopRouteScreen> {
  MyController myController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
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
    /*String btn_text = isStopped == true
        ? "stop_journey".tr
        : "txtArretermonparcours".tr;*/
    return Column(
      children: [
        SizedBox(
          height: Get.height * .040,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
                top: Get.height * .020, right: Get.height * .020),
            child: GestureDetector(
              onTap: () {
                Get.back();
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
          padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 30),
          child: MyText(
            text_name: "choose_destination_complete_vacation_plan".tr,
            // text_name: isStopped == true
            //     ? "notify_title".tr
            //     : "current_destination".tr,
            myFont: MyFont.Courier_Prime_Bold,
            txtfontsize: MyFontSize.size13,
            txtcolor: MyColors.textColor,
            txtAlign: TextAlign.center,
            //height: 1,
          ),
        ),

        TIMyCustomRoundedCornerButton(
          onClickCallback: () {
            setState(() {
              // isStopped = true;
              Get.to(() => TITravelougeScreen(
                  double.parse(widget.km)));

            });
          },
          btnText: "txtCARNETDEVOYAGE".tr,
          fontSize: MyFontSize.size9,
          textColor: MyColors.txtWhiteColor,
          myFont: MyFont.Courier_Prime_Bold,
          btnBgColor: MyColors.buttonBgColor,
          buttonWidth: Get.width * .40,
          buttonHeight: Get.height * .040,
        ),
        SizedBox(
          height: Get.height * 0.02,
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
              //  openModelCitydetail(myController.mList[index]);
                myController.selectedPlace.value = myController.mList[index];
                // call pin destination api
                callPinDestinationAPI();
              },
              child: MyCustomRowViewWithImage(myController.mList[index]),
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
      "project_id": widget.projId,
      "pin_destination": myController.selectedPlace.value.name,
      "end_lat":myController.selectedPlace.value.lat,
      "end_long":myController.selectedPlace.value.lng,
    };

    await apiManager.pinDestinationAPI(param).then((value) {
      if (value) {
        Get.to(TIPinDestinationToProjectScreen(travelLougeTitle: "txtPinDestination".tr,));
      }
    });
  }
}

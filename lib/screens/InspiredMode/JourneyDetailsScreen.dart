import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class JourneyDetailsScreen extends StatefulWidget {
  double updatedKm;

  JourneyDetailsScreen(this.updatedKm);

  @override
  State<JourneyDetailsScreen> createState() => _JourneyDetailsScreenState();
}

class _JourneyDetailsScreenState extends State<JourneyDetailsScreen> {
  MyController myController = Get.put(MyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.timer = Timer.periodic(Duration(seconds: 30), (timer) {
      getEndLatLong();
    });
  }

  getEndLatLong() async {
    Position _endPosition = await determineCurrentPosition();

    print("curr : ${_endPosition.latitude}, ${_endPosition.longitude}");

    double distance =
        calculateDistance(_endPosition.latitude, _endPosition.longitude);
    // calculateDistance(23.007950, 72.553757);
    print("distance km : $distance");
    callUpdateKm(distance);
  }

  callUpdateKm(double distance) async {
    ApiManager apiManager = ApiManager();
    String updatedKm = (double.parse((distance).toStringAsFixed(2))).toString();
    print("updated km $updatedKm");

    Map<String, dynamic> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "projectId": myController.selectedProject != null
          ? myController.selectedProject.value.id
          : 0,
      "projectMode": "1",
      "updatedKm": updatedKm,
    };

    await apiManager.updateKmAPI(param).then((value) {
      if (value == true) {
        setState(() async {
          if (myController.selectedProject != null &&
              myController.selectedProject.value.totalKm != null) {
            myController.selectedProject.value.totalKm =
                ((distance).toStringAsFixed(2));
          } else {
            
            widget.updatedKm = double.parse((distance).toStringAsFixed(2));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  MyImageURL.inspred_bg,
                ),
                fit: BoxFit.fill),
          ),
          child: buildContent(),
        ),
      ),
    );
  }

  buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildCloseButton(),
        SizedBox(
          height: Get.height * 0.2,
        ),
        MyText(
          text_name:
              "${(myController.selectedProject != null && myController.selectedProject.value.totalKm != null) ? myController.selectedProject.value.totalKm : widget.updatedKm} KM",
          txtcolor: MyColors.whiteColor,
          myFont: MyStrings.cagliostro,
          txtfontsize: MyFontSize.size58,
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Image.asset(
          MyImageURL.metro_steps,
          height: 60,
          width: 70,
        ),
        /*  Padding(
          padding: const EdgeInsets.all(30.0),
          child: MyText(text_name: "Plus que 3 jours pour recevoir tes destinations !",txtcolor: MyColors.whiteColor,myFont: MyStrings.courier_prime_bold,txtfontsize: MyFontSize.size18,),
        ),*/
        SizedBox(
          height: Get.height * 0.08,
        ),
        buildButtonInfo(),
      ],
    );
  }

  buildButtonInfo() {
    return myController.allProjectList.value.length > 1
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Container(
                  width: Get.width * 0.60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: MyColors.whiteColor,
                  ),
                  //margin: EdgeInsets.all(20),
                  child: MaterialButton(
                    onPressed: () {
                      myController.stopTracking();
                      String myMode =
                          myController.secondProject.value.projectMode;
                      // if (myController.secondProject.value.projectMode == "0") {
                      MyPreference.setPrefIntValue(
                          key: MyPreference.APPMODE,
                          value: int.parse(
                              myController.secondProject.value.projectMode));
                      myController
                          .setSelectedProj(myController.secondProject.value);
                      // Get.back();
                      if (myMode == "0") {
                        Get.back(result: true);
                      } else {
                        CommonMethod.getAppMode();
                      }
                      // }
                    },
                    minWidth: Get.width * 0.50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text_name: myController.secondProject.value != ""
                                ? myController.secondProject.value.title
                                : "",
                            txtcolor:
                                myController.secondProject.value.projectMode ==
                                        "1"
                                    ? MyColors.lightGreenColor
                                    : MyColors.lineColor,
                            txtfontsize: MyFontSize.size10,
                            myFont: MyStrings.courier_prime_bold,
                          ),
                          MyText(
                            text_name: myController.secondProject.value != ""
                                ? "${myController.secondProject.value.totalKm} KM"
                                : "0 KM",
                            txtcolor:
                                myController.secondProject.value.projectMode ==
                                        "1"
                                    ? MyColors.lightGreenColor
                                    : MyColors.lineColor,
                            txtfontsize: MyFontSize.size10,
                            myFont: MyStrings.courier_prime_bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                myController.allProjectList.value.length > 2
                    ? Container(
                        width: Get.width * 0.60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: MyColors.whiteColor,
                        ),
                        //margin: EdgeInsets.all(20),
                        child: MaterialButton(
                          onPressed: () {
                            // if (myController.thirddProject.value.projectMode ==
                            //     "0") {
                            myController.stopTracking();
                            String myMode =
                                myController.thirddProject.value.projectMode;
                            MyPreference.setPrefIntValue(
                                key: MyPreference.APPMODE,
                                value: int.parse(myController
                                    .thirddProject.value.projectMode));
                            myController.setSelectedProj(
                                myController.thirddProject.value);

                            if (myMode == "0") {
                              Get.back(result: true);
                            } else {
                              CommonMethod.getAppMode();
                            }
                          },
                          minWidth: Get.width * 0.50,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  text_name: myController.thirddProject.value !=
                                          ""
                                      ? myController.thirddProject.value.title
                                      : "",
                                  txtcolor: myController.thirddProject.value
                                              .projectMode ==
                                          "1"
                                      ? MyColors.lightGreenColor
                                      : MyColors.lineColor,
                                  txtfontsize: MyFontSize.size10,
                                  myFont: MyStrings.courier_prime_bold,
                                ),
                                MyText(
                                  text_name: myController.thirddProject.value !=
                                          ""
                                      ? "${myController.thirddProject.value.totalKm} KM"
                                      : "0 KM",
                                  txtcolor: myController.thirddProject.value
                                              .projectMode ==
                                          "1"
                                      ? MyColors.lightGreenColor
                                      : MyColors.lineColor,
                                  txtfontsize: MyFontSize.size10,
                                  myFont: MyStrings.courier_prime_bold,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          )
        : Container();
  }

  buildCloseButton() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: InkWell(
        onTap: () {
          myController.stopTracking();
          Get.back();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              MyImageURL.cross,
              width: 40,
              color: MyColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}

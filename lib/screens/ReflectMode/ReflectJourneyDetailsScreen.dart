import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/TIDestinationInProgressScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class ReflectJourneyDetailsScreen extends StatefulWidget {
  double updatedKm;

  ReflectJourneyDetailsScreen(this.updatedKm);

  @override
  State<ReflectJourneyDetailsScreen> createState() =>
      _ReflectJourneyDetailsScreenState();
}

class _ReflectJourneyDetailsScreenState
    extends State<ReflectJourneyDetailsScreen> {
  MyController myController = Get.put(MyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myController.timer = Timer.periodic(Duration(seconds: 20), (timer) {
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
          //  widget.updatedKm = double.parse((distance).toStringAsFixed(2));

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
    return WillPopScope(
      onWillPop: () async {
        myController.showDestinationInProgressPopup.value = false;
        return true;
      },
      child: Scaffold(
          body: SafeArea(
        child: Container(
            height: Get.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    MyImageURL.rm_bg,
                  ),
                  fit: BoxFit.fill),
            ),
            child: Obx(
              () => Stack(
                children: [
                  buildContent(),
                  Visibility(
                      visible:
                          myController.showDestinationInProgressPopup.value,
                      child: BackdropFilter(
                          filter:
                              myController.showDestinationInProgressPopup.value
                                  ? ImageFilter.blur(
                                      sigmaX: 5,
                                      sigmaY: 5,
                                    )
                                  : ImageFilter.blur(
                                      sigmaX: 0,
                                      sigmaY: 0,
                                    ),
                          child: TIDestinationInProgressScreen())),
                ],
              ),
            )),
      )),
    );
  }

  buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          buildCloseButton(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: MyButton(
              onClick: () {
                myController.stopTracking();
                myController.showDestinationInProgressPopup.value = true;
              },
              btn_name: "current_destination".tr,
              txtcolor: MyColors.textColor,
              bgColor: MyColors.whiteColor,
              opacity: 0.7,
              txtfont: MyFontSize.size13,
            ),
          ),
          SizedBox(
            height: Get.height * 0.15,
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
          /*  Image.asset(
            MyImageURL.metro_steps,
            height: 60,
            width: 70,
          ),*/
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: MyText(
              text_name:
                  "${myController.selectedProject != null ? myController.selectedProject.value.msg : ""}",
              txtcolor: MyColors.whiteColor,
              myFont: MyStrings.courier_prime_bold,
              txtfontsize: MyFontSize.size18,
            ),
          ),
          SizedBox(
            height: Get.height * 0.06,
          ),
          buildButtonInfo(),
          SizedBox(
            height: Get.height * 0.02,
          ),
        ],
      ),
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
                      // if (myController.secondProject.value.projectMode == "1") {
                      String myMode =
                          myController.secondProject.value.projectMode;
                      MyPreference.setPrefIntValue(
                          key: MyPreference.APPMODE,
                          value: int.parse(
                              myController.secondProject.value.projectMode));
                      myController
                          .setSelectedProj(myController.secondProject.value);
                      // CommonMethod.getAppMode();
                      // Get.back(result: true);
                      // }
                      if (myMode == "1") {
                        Get.back(result: true);
                      } else {
                        CommonMethod.getAppMode();
                      }
                    },
                    minWidth: Get.width * 0.50,
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
                            //   "1") {
                            myController.stopTracking();
                            String myMode =
                                myController.thirddProject.value.projectMode;
                            MyPreference.setPrefIntValue(
                                key: MyPreference.APPMODE,
                                value: int.parse(myController
                                    .thirddProject.value.projectMode));
                            myController.setSelectedProj(
                                myController.thirddProject.value);
                            // Get.back(result: true);
                            //  CommonMethod.getAppMode();
                            // }
                            if (myMode == "1") {
                              Get.back(result: true);
                            } else {
                              CommonMethod.getAppMode();
                            }
                          },
                          minWidth: Get.width * 0.50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text_name:
                                    myController.thirddProject.value != ""
                                        ? myController.thirddProject.value.title
                                        : "",
                                txtcolor: myController
                                            .thirddProject.value.projectMode ==
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
                                txtcolor: myController
                                            .thirddProject.value.projectMode ==
                                        "1"
                                    ? MyColors.lightGreenColor
                                    : MyColors.lineColor,
                                txtfontsize: MyFontSize.size10,
                                myFont: MyStrings.courier_prime_bold,
                              ),
                            ],
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
          Get.back(result: true);
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

  @override
  void dispose() {
    myController.stopTracking();
    super.dispose();
  }
}

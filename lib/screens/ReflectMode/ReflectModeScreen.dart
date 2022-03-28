import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/Models/AllProjectModel.dart';
import 'package:travel_inspiration/MyWidget/MyBottomMenu.dart';
import 'package:travel_inspiration/MyWidget/MyFlyMenu.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/InspiredMode/InspredModeScreen.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectJourneyDetailsScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/TIFaqListScreen.dart';
import 'package:travel_inspiration/screens/TIStartNewAdventureScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TITravelougeScreen.dart';
import 'package:travel_inspiration/services/GeoLocationService/AskForPermission.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

//  0 for inspire mode
//  1 for reflective mode
class ReflectModeScreen extends StatefulWidget {
  const ReflectModeScreen({Key key}) : super(key: key);

  @override
  _ReflectModeScreenState createState() => _ReflectModeScreenState();
}

class _ReflectModeScreenState extends State<ReflectModeScreen>
    with SingleTickerProviderStateMixin {
  bool isVisible = false;
  MyController myController = Get.put(MyController());
  AnimationController rotateArrow360;
  bool goToDetail = false;

  AllProjectModel selectedProj;

  @override
  initState() {
    // TODO: implement initState
    rotateArrow360 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    super.initState();
    getStartLatLong();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      myController.getAllProject();
    });
  }

  getStartLatLong() async {
    Position _startPosition = await determineCurrentPosition();
    print("curr : ${_startPosition.latitude}, ${_startPosition.longitude}");
    MyPreference.setPrefDoubleValue(
        key: MyPreference.startLat, value: _startPosition.latitude);
    MyPreference.setPrefDoubleValue(
        key: MyPreference.startLng, value: _startPosition.longitude);
  }

  getEndLatLong(mGoToDetail) async {
    Position _endPosition = await determineCurrentPosition();

    print("curr : ${_endPosition.latitude}, ${_endPosition.longitude}");

    double distance =
        calculateDistance(_endPosition.latitude, _endPosition.longitude);
    // calculateDistance(23.007950, 72.553757);
    print("distance km : $distance");
    callUpdateKm(distance, mGoToDetail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      MyImageURL.rm_bg,
                    ),
                    fit: BoxFit.fill),
              ),
              child: Stack(
                children: [
                  buildContent(),
                  buildQuestion(),
                  buildMenu(),
                  openMenu(),
                  MyBottomMenu(
                    bgImg: MyImageURL.bottom_bg,
                    homeMenuCallback: () {
                      myController.showHomeIcon.value = false;
                      myController.isFloatingMenuVisible.value = true;
                    },
                  ),
                  Visibility(
                    visible: myController.isFloatingMenuVisible.value,
                    child: Center(
                      child: BackdropFilter(
                        filter: myController.isFloatingMenuVisible.value
                            ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
                            : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: Container(
                          margin: EdgeInsets.only(bottom: Get.height * .020),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              myController.isSwitchClicked.value
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          bottom: Get.height * .10),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: RotationTransition(
                                          turns: Tween(begin: 0.0, end: 1.0)
                                              .animate(rotateArrow360),
                                          child: Image.asset(
                                            MyImageURL.arrow3x,
                                            fit: BoxFit.contain,
                                            height: Get.height * .08,
                                            width: Get.height * .08,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              MyFlyMenu(
                                homeButtonClick: () {
                                  myController.isFloatingMenuVisible.value =
                                      false;
                                  myController.showHomeIcon.value = true;
                                  myController.isSwitchClicked.value = false;
                                  myController.isEditClicked.value = false;
                                },
                                editCallback: () {
                                  myController.isSwitchClicked.value = false;
                                  myController.isEditClicked.value = true;
                                  Get.to(() => TIStartNewAdventureScreen());
                                },
                                switchCallback: () {
                                  myController.isSwitchClicked.value = true;
                                  myController.isEditClicked.value = false;
                                  rotateArrow360.forward();
                                  Future.delayed(Duration(seconds: 2), () {
                                    myController.isFloatingMenuVisible.value =
                                        false;
                                    myController.isSwitchClicked.value = false;
                                    myController.showHomeIcon.value = true;
                                    myController.resetProj();
                                    callSelectModeAPI();
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  buildQuestion() {
    return Positioned(
        top: 10,
        right: 15,
        child: InkWell(
            onTap: () {
              ScreenTransition.navigateToScreenLeft(
                  screenName: TIFaqListScreen());
            },
            child: Image.asset(
              MyImageURL.metro_question,
              fit: BoxFit.contain,
            )));
  }

  buildMenu() {
    return Positioned(
        top: 10,
        left: 15,
        child: InkWell(
            onTap: () {
              setState(() {
                isVisible = true;
              });
            },
            child: Image.asset(MyImageURL.arrow_down_white)));
  }

  openMenu() {
    return Visibility(
      visible: isVisible,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: Get.width,
          height: Get.height * 0.4,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(MyImageURL.top_wave), fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = false;
                        });
                      },
                      child: Image.asset(MyImageURL.arrow_dropdown_up,color: MyColors.buttonBgColor)),
                 /* InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = false;
                        });
                      },
                      child: Image.asset(MyImageURL.cross,width: 30,)),*/
                ],
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () {
                          /*if (myController.selectedProject != null &&
                              myController.selectedProject.value != "" &&
                              myController.selectedProject.value.projectMode ==
                                  "1") {
                            getEndLatLong(false);
                          }*/
                          getEndLatLong(false);
                        },
                        child: Image.asset(MyImageURL.gaia,height: 60,width: 60,)),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    MyTextStart(
                      text_name: "my_trvel_book".tr,
                      txtcolor: MyColors.expantionTileBgColor,
                      txtfontsize: MyFontSize.size10,
                      myFont: MyStrings.courier_prime_bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          MyText(
            text_name: "reflect_mode".tr.toUpperCase(),
            myFont: MyStrings.courier_prime_bold,
            txtfontsize: MyFontSize.size20,
            txtcolor: MyColors.whiteColor,
          ),
          /*SizedBox(
            height: Get.height * 0.05,
          ),
          MyText(
            text_name: "journey_always_start".tr,
            myFont: MyStrings.courier_prime_italic,
            txtfontsize: MyFontSize.size16,
            txtcolor: MyColors.whiteColor,
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          MyText(
            text_name: "lao_tseu".tr,
            myFont: MyStrings.courier_prime_bold,
            txtfontsize: MyFontSize.size16,
            txtcolor: MyColors.whiteColor,
          ),*/
          // Container(
          //   color: MyColors.lightGreenColor,
          //   height: Get.height * 0.005,
          //   width: Get.width * 0.32,
          // ),
          SizedBox(
            height: Get.height * 0.06,
          ),
          Obx(() {
            return MyText(
              text_name: getSelectedProj(),
              myFont: MyStrings.courier_prime_italic,
              txtfontsize: MyFontSize.size16,
              txtcolor: MyColors.whiteColor,
            );
          }),
          Spacer(),
          GestureDetector(
            onTap: () {
              getEndLatLong(true);
             /* if (myController.selectedProject != null &&
                  myController.selectedProject.value != "" &&
                  myController.selectedProject.value.projectMode == "1") {
                getEndLatLong(true);
              }*/
              /*if(goToDetail == true) {
                final result = await Get.to(ReflectJourneyDetailsScreen());
                if (result == true) setState(() {});
              }*/
            },
            child: MyText(
              text_name: "see_my_journey".tr.toUpperCase(),
              myFont: MyStrings.cagliostro,
              txtfontsize: MyFontSize.size25,
              txtcolor: MyColors.whiteColor,
            ),
          ),
          SizedBox(
            height: Get.height * 0.14,
          ),
        ],
      ),
    );
  }

  callSelectModeAPI() async {
    ApiManager apiManager = ApiManager();
    Map param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      // "userId" : "43",
      "mode": "0",
    };

    TIPrint(tag: "param", value: param.toString());
    await apiManager.selectModeAPI(param).then((value) {
      if (value == true) {
        //change reflective mode  to inspire mode
        // MyPreference.setPrefIntValue(key: MyPreference.APPMODE, value: 0);
        ScreenTransition.navigateOffAll(screenName: InspredModeScreen());
      }
    });
  }

  getSelectedProj() {
    if (myController.selectedProject != null &&
        myController.selectedProject.value != "" &&
        myController.selectedProject.value.projectMode == "1") {
      return myController.selectedProject.value.title;
    }

    if (myController.allProjectList.value != null &&
        myController.allProjectList.value.length > 0) {
      int appMode = MyPreference.getPrefIntValue(key: MyPreference.APPMODE);
      for (int i = 0; i < myController.allProjectList.value.length; i++) {
        if ("1" == myController.allProjectList.value[i].projectMode) {
          // myController.selectedProject.value =
          // myController.allProjectList.value[i];
          myController.allProjectList.value[i].isSelected = true;
          myController.getSelectedProj();
          return myController.allProjectList.value[i].title;
        }else{
          myController.allProjectList.value[i].isSelected = false;
        }
      }
    }
    return "";
  }

  callUpdateKm(double distance, mGoToDetails) async {
    ApiManager apiManager = ApiManager();
    String updatedKm = (double.parse((distance).toStringAsFixed(2))).toString();
    print("updated km $updatedKm");

    Map<String, dynamic> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "projectId": myController.selectedProject!= null ?myController.selectedProject.value.id:0,
      "projectMode": "1",
      "updatedKm": updatedKm,
    };

    await apiManager.updateKmAPI(param).then((value) {
      if (value == true) {
        setState(() async {
          goToDetail = mGoToDetails;
          if (goToDetail == false) {
            Get.to(() => TITravelougeScreen(
                double.parse((distance).toStringAsFixed(2))));
          } else {
            final result = await Get.to(ReflectJourneyDetailsScreen(double.parse((distance).toStringAsFixed(2))));
            if (result == true) setState(() {});
          }
        });
      }
    });
  }
}

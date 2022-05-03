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
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeCreateProjectScreen.dart';
import 'package:travel_inspiration/screens/TICreateNewProjectInInspireModeScreen.dart';
import 'package:travel_inspiration/screens/TIPinDestinationToProjectScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'TravelBook/TITravelougeScreen.dart';

class NotificationReflectScreen extends StatefulWidget {
  Map<String, dynamic> data;
  NotificationReflectScreen({this.data});
  @override
  State<NotificationReflectScreen> createState() => NotificationReflectScreenState();
}

class NotificationReflectScreenState extends State<NotificationReflectScreen> {
  MyController myController = MyController();
  bool isStopped = false;
  bool isVisible = false;

  bool isContinueSel = false;

  bool isNewSelected = false;

  @override
  void initState() {
    if(widget.data!=null)
    print(widget.data["project_id"]);
    print("No");
    super.initState();
    double radious =
        // myController.selectedProject.value.totalKm
        (double.parse("40")) * 1000;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myController.getCities(50000);
      // myController.getCities(radious);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: Get.height * 0.03),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyImageURL.notify_img),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            !isVisible ? buttonUI() : openMenu(),
            _buildBodyContent()
          ],
        ),
      )
    );
    /*return ;*/
  }

  openMenu() {
    return Visibility(
      visible: isVisible,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: Get.width,
          height: Get.height * 0.35,
          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(MyImageURL.top_wave), fit: BoxFit.fill),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center ,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(Get.width * .030),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Image.asset(
                      MyImageURL.arrow_dropdown_up,
                      color: MyColors.buttonBgColor,
                      height: Get.height * .035,
                      width: Get.height * .035,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              MyTextStart(
                text_name: "go_on_way".tr.toUpperCase(),
                txtcolor: MyColors.buttonBgColor,
                txtfontsize: MyFontSize.size13,
                myFont: MyStrings.courier_prime_bold,
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Container(
                padding: EdgeInsets.all(Get.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TIMyCustomRoundedCornerButton(
                      onClickCallback: () {
                        setState(() {
                          isNewSelected = true;
                          isContinueSel = false;
                        });
                        /*ScreenTransition.navigateToScreenLeft(
                            screenName: (widget.data["mode"]) == 0
                                ? TICreateNewProjectInInspireModeScreen()
                                : ReflectModeCreateProjectScreen());*/
                      },
                      btnText: "txtArretermonparcours".tr,
                      fontSize: MyFontSize.size9,
                      textColor: isNewSelected == true ? MyColors.whiteColor:MyColors.buttonBgColor,
                      myFont: MyFont.Courier_Prime_Bold,
                      btnBgColor: isNewSelected == true ? MyColors.buttonBgColor:MyColors.whiteColor,
                      buttonWidth: Get.width * .40,
                      buttonHeight: Get.height * .040,
                    ),
                    TIMyCustomRoundedCornerButton(
                      onClickCallback: () {
                        setState(() {
                          isContinueSel = true;
                          isNewSelected = false;
                        });
                        /*ScreenTransition.navigateToScreenLeft(
                            screenName: (widget.data["mode"]) == 0
                                ? TICreateNewProjectInInspireModeScreen()
                                : ReflectModeCreateProjectScreen());*/
                      },
                      btnText: "go_on_way".tr,
                      fontSize: MyFontSize.size9,
                      textColor: isContinueSel == true ? MyColors.whiteColor:MyColors.buttonBgColor,
                      myFont: MyFont.Courier_Prime_Bold,
                      btnBgColor: isContinueSel == true ? MyColors.buttonBgColor:MyColors.whiteColor,
                      buttonWidth: Get.width * .40,
                      buttonHeight: Get.height * .040,
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



  buttonUI() {
    return Column(

      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(Get.width * .030),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              child: Image.asset(
                MyImageURL.arrow_dropdown_down,
                color: MyColors.whiteColor,
                height: Get.height * .035,
                width: Get.height * .035,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(Get.width * .030),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                MyImageURL.cross_gray3x,
                color: MyColors.whiteColor,
                height: Get.height * .035,
                width: Get.height * .035,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    ),
   Container(
    margin: EdgeInsets.symmetric( vertical:Get.height*0.05),

    child: GestureDetector(
    onTap: () {
    //myController.showDestinationInProgressPopup.value = false;
    },

    child: MyText(
    text_name: "${"you_hv_done".tr} 305 ${"km".tr} ",
    // text_name: "${"you_hv_done".tr} ${widget.data["km"]} ${"km".tr} ",
    myFont: MyFont.Cagliostro_reguler,
    txtfontsize: MyFontSize.size23,
    txtcolor: MyColors.whiteColor ,
    //height: 1,
    ),
    ),
    )
      ],
    );

  }

  _buildBodyContent() {
    return Container(
      margin: EdgeInsets.only(
        top: Get.height * 0.30,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Get.width * 0.12),
              topRight: Radius.circular(Get.width * 0.12))),
      child: _buildColumn(),
    );
  }

  _buildColumn() {
    String btn_text = isStopped == true
        ? "stop_journey".tr
        : "txtArretermonparcours".tr;
    return Column(
      children: [
        SizedBox(
          height: Get.height * .040,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: MyText(
            text_name: "notify_title".tr,
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
        SizedBox(
          height: Get.height * .030,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: MyText(
            text_name: "notify_subtitle".tr,
            // text_name: isStopped == true
            //     ? "notify_subtitle".tr
            //     : "current_destination".tr,
            myFont: MyFont.Courier_Prime,
            txtfontsize: MyFontSize.size11,
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
                openModelCitydetail(myController.mList[index]);
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

  openModelCitydetail(TIDestinationInProgressModel mList) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              margin: EdgeInsets.only(
                  top: Get.height * 0.07, bottom: Get.height * 0.02),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height - 10,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(Get.width * .030),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          MyImageURL.cross_gray3x,
                          color: MyColors.buttonBgColor,
                          height: Get.height * .035,
                          width: Get.height * .035,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: MyText(
                      text_name: "choose_dest_title".tr,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size14,
                      myFont: MyStrings.courier_prime_bold,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Container(
                    height: Get.height * 0.20,
                    width: Get.height * .60,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(Get.width * .08)),
                        image: DecorationImage(
                            image: NetworkImage(mList.photo_ref != null
                                ? getPhotoImage(mList.photo_ref)
                                : mList.imgUrl),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Container(
                    width: Get.width,
                    child: MyTextStart(
                      text_name: mList.name,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size12,
                      myFont: MyStrings.courier_prime_bold,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    child: MyTextStart(
                      text_name: mList.description,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size10,
                      myFont: MyStrings.courier_prime,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .08,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: TIMyCustomRoundedCornerButton(
                          onClickCallback: () {
                            setState(() {});
                          },
                          btnText: "carnet de voyage",
                          fontSize: MyFontSize.size10,
                          textColor: MyColors.txtWhiteColor,
                          myFont: MyFont.Courier_Prime_Bold,
                          btnBgColor: MyColors.buttonBgColor,
                          buttonWidth: Get.width * .40,
                          buttonHeight: Get.height * .040,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });

    Get.dialog(
        AlertDialog(
            /*  shape: RoundedRectangleBorder(borderRadius:
            BorderRadius.all(Radius.circular(30))),*/
            content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
          child: Container(
            height: Get.width,
            width: Get.width,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(MyImageURL.cross)),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MyText(
                    text_name: "msgContent",
                    txtcolor: MyColors.textColor,
                    txtfontsize: MyFontSize.size13,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
              ],
            ),
          ),
        )),
        barrierDismissible: true);
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
        Get.to(TIPinDestinationToProjectScreen(
          travelLougeTitle: "txtPinDestination".tr,
        ));
      }
    });
  }
}

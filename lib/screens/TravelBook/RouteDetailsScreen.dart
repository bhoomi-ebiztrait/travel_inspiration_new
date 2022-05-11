import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTextButton.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/TravelBook/MyRouteListScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

class RouteDetailsScreen extends StatefulWidget {
  String currCity, currAddress;
  Position currPos;

  RouteDetailsScreen({this.currCity, this.currAddress, this.currPos});

  @override
  _RouteDetailsScreenState createState() => _RouteDetailsScreenState();
}

class _RouteDetailsScreenState extends State<RouteDetailsScreen> {
  bool isVisible = false;
  MyController myController = Get.put(MyController());
  String name, desc;

  String startAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // height: Get.height,
                width: Get.width,
                color: MyColors.buttonBgColorHome.withOpacity(0.7),
                child: Column(
                  children: [
                    MyTopHeader(
                      logoImgUrl: MyImageURL.haudos_logo,
                    ),
                    buildHeader(),
                  ],
                ),
              ),


              Container(
                height: Get.height,
                width: Get.width,
                color: MyColors.buttonBgColorHome.withOpacity(0.3),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    buildDetails(),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20),
                      child: MyButton(
                        btn_name: "addRoute".tr,
                        onClick: () {
                          callAddRouteAPI();
                        },
                        bgColor: MyColors.buttonBgColor,
                        txtcolor: MyColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        opacity: 1,
                        txtfont: MyFontSize.size16,
                      ),
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

  buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top:5.0,bottom: 40,right: 20,left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
               // buildInfo("ruleOne".tr),
                SizedBox(
                  height: 2,
                ),
             //   buildInfo("ruleTwo".tr),
                SizedBox(
                  height: 2,
                ),
              //  buildInfo("ruleThree".tr),
                SizedBox(
                  height: 2,
                ),
             //   buildInfo("ruleFour".tr),
                SizedBox(
                  height: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* buildInfo(rule) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, right: 40),
      // child: Row(

           // padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex:1,child:   Image.asset(MyImageURL.back),),

              */ /*  SizedBox(
                  width: 10,
                ),*/ /*
                Expanded(flex:8,child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildInfo("ruleOne".tr),
                    buildInfo("ruleTwo".tr),
                    buildInfo("ruleThree".tr),
                    buildInfo("ruleFour".tr),
                  ],
                ),)

              ],
            ),
          );
  }*/

  buildInfo(rule) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 40,
        ),
        Container(
          height: 5,
          width: 5,
          decoration: BoxDecoration(
            color: MyColors.whiteColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
            width: 8,
          ),
        Expanded(
          // flex: 5,
          child: MyTextStart(
            text_name: rule,
            txtcolor: MyColors.textColor,
            myFont: MyStrings.courier_prime,
            txtfontsize: MyFontSize.size8,
          ),
        )
      ],
    );
  }

  buildListItem(index) {
    if (index == 1) {
      name = myController.selectedPlace.value.name;
      desc = myController.selectedPlace.value.description;
    } else {
      if (widget.currAddress.contains(",")) {
        int endIndex = widget.currAddress.indexOf(",");
        name = "${widget.currAddress.substring(0, endIndex)}";
      } else {
        name = widget.currAddress;
      }
      startAddress = name;
      desc = widget.currAddress;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7,
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Image.asset(MyImageURL.circle3x)),
                    /*SizedBox(
                      width: 10,
                    ),*/
                    Expanded(
                      flex: 5,
                      child: MyTextStart(
                        text_name: "$name",
                        txtfontsize: MyFontSize.size15,
                        txtcolor: MyColors.textColor,
                        myFont: MyStrings.courier_prime_bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Image.asset(isVisible == true
                        ? MyImageURL.arrow_route_up
                        : MyImageURL.arrow_route_down,color: MyColors.buttonBgColor,),
                  )),
            ],
          ),
          isVisible
              ? Container(
                  child: index == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          height: 80,
                                          width: 80,
                                          child: Image.asset(
                                            MyImageURL.arrow_route,
                                            height: 80,
                                            width: 80,
                                          ))),
                                  /* SizedBox(
                              width: 10,
                            ),*/
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyTextStart(
                                          text_name: "$desc",
                                          txtfontsize: MyFontSize.size14,
                                          txtcolor: MyColors.textColor,
                                          myFont: MyStrings.courier_prime,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: MyTextStart(
                                            text_name: "${myController.distance.value}",
                                            txtfontsize: MyFontSize.size14,
                                            txtcolor: MyColors.textColor,
                                            myFont: MyStrings.courier_prime_bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                )
              : Container(),
        ],
      ),
    );
  }

  buildDetails() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return buildListItem(index);
        });
  }

  callAddRouteAPI() async {
    ApiManager apiManager = ApiManager();
    Map<String, dynamic> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "originLat": widget.currPos.latitude,
      "originLng": widget.currPos.longitude,
      "destLat": myController.selectedPlace.value.lat,
      "destLng": myController.selectedPlace.value.lng,
      "startAddress": startAddress,
      "endAddress": myController.selectedPlace.value.name,
      "selectedPlace": myController.selectedPlace.value.name
    };
    await apiManager.addRouteAPI(param).then((value) {
      if (value == true) {
        ScreenTransition.navigateToScreenLeft(screenName: MyRouteListScreen());
      }
    });
  }
}

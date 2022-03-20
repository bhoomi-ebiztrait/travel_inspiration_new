import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyFlyMenu.dart';
import 'package:travel_inspiration/MyWidget/MyFlyMenus.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyPopupBottomMenu.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/MyWidget/TICommonPopup.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/MyWidget/TIPopupGridviewMenu.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIPopupGridViewModel.dart';
import 'package:travel_inspiration/TIModel/TITravelLougeListModel.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';
import 'package:travel_inspiration/utils/TITag.dart';

import 'TIFlightTrainCarCommonScreen.dart';
import 'TIHotelListScreen.dart';
import 'TIRestaurantListScreen.dart';

class TIMyHaudosDestinationScreen extends StatefulWidget {
  double updatedKm;
  String travelLougeTitle, popupTitle = "";
  TIMyHaudosDestinationScreen({this.travelLougeTitle,this.updatedKm});

  @override
  State<TIMyHaudosDestinationScreen> createState() => _TIMyHaudosDestinationScreenState();
}

class _TIMyHaudosDestinationScreenState extends State<TIMyHaudosDestinationScreen> {




  var flyMenusList = [
    // MyImageURL.cross2x_icon,
    MyImageURL.favor2x_icon,
    MyImageURL.pin_icon,
    MyImageURL.edit_medium_icon,
    MyImageURL.arrowUp3x,
  ];

  MyController myController = Get.put(MyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.showPrepareProjectPopup.value = false;
    myController.showPrepareProjectMenu.value = false;
    myController.isFavMenu.value = false;
    getStartLatLong();
    print("radious km : ${widget.updatedKm}");


    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(myController.mList.length > 0){
        myController.mList.clear();

      }
      myController.nextPage_token.value = "";
      myController.getCities((widget.updatedKm)*10000);
    });

  }
  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {

        myController.getCities((widget.updatedKm)*10000);
      } else {
        // MyPrint(tag: "CallAPI", value: "Not Call NOW");
      }
    }
    return true;
  }

  getStartLatLong() async {
    Position _startPosition = await determineCurrentPosition();
    print("curr : ${_startPosition.latitude}, ${_startPosition.longitude}");
    MyPreference.setPrefDoubleValue(
        key: MyPreference.startLat, value: _startPosition.latitude);
    MyPreference.setPrefDoubleValue(
        key: MyPreference.startLng, value: _startPosition.longitude);
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(MyImageURL.login),fit: BoxFit.fill)
              ),
              child: Column(
            children: [
            MyTopHeader(
            logoImgUrl: MyImageURL.haudos_logo,
              logoCallback: () {
                CommonMethod.getAppMode();
              },
            ),
            Obx((){
              return  myController.showPrepareProjectPopup.value == true ? Container(): MyTitlebar(title: widget.travelLougeTitle.toUpperCase(),);
            }),
            // myController.showPrepareProjectPopup.value == true ? Container(): MyTitlebar(title: widget.travelLougeTitle.toUpperCase(),),
            SizedBox(
              height: Get.height * .020,
            ),
            NotificationListener(
                onNotification: onNotification,
                child:Obx((){
                  return myController.showPrepareProjectPopup.value == true ? Container(): Expanded(child: _travelLougeList());
                })),
             // Spacer(),
          ],
        ),
            ),

            Obx((){
              return myController.showPrepareProjectPopup.value == true ? Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: MyPopupBottomMenu(iconList: [
                    MyImageURL.profile_icon,MyImageURL.galerie,MyImageURL.fleche,MyImageURL.world_icon,MyImageURL.setting_icon],bgImg: MyImageURL.change_pw_bottom,),
                ),
              ) :Container();
            }),
            Obx(() => Visibility(
                visible: myController.showPrepareProjectPopup.value,
                child: Container(
                    width: Get.width,
                    // color: Colors.red,
                    child: Stack(
                      children: [
                        TICommonPopup(
                            childWidget: Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: Get.height * .025,
                                    right: Get.height*.02,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: Get.width * .55,
                                      child: MyText(
                                        text_name:
                                            widget.popupTitle.toUpperCase() ?? "",
                                        myFont: MyFont.Cagliostro_reguler,
                                        txtfontsize: MyFontSize.size18,
                                        txtcolor: MyColors.buttonBgColorHome,
                                        txtAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    myController.showPrepareProjectPopup
                                        .value = false;
                                    myController.isFavMenu.value = false;
                                  },
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: Get.height * .020,
                                          right: Get.height * .020),
                                      child: Image.asset(
                                        MyImageURL.cross3x,
                                        height: Get.height * .045,
                                        width: Get.height * .045,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * .025,
                            ),
                            MyText(
                              text_name: MyPreference.getPrefIntValue(key: MyPreference.APPMODE) == ApiParameter.REFLECT_MODE ?"reflect_mode".tr:"inspire_mode".tr,
                              myFont: MyFont.Courier_Prime_Bold,
                              txtfontsize: MyFontSize.size18,
                              txtcolor: MyColors.textColor,
                              txtAlign: TextAlign.center,
                              height: 0.8,
                            ),
                            MyText(
                              text_name: "${myController.selectedPlace.value.km != null ?myController.selectedPlace.value.km.toStringAsFixed(2): "0"} KM",
                              myFont: MyFont.Courier_Prime_Bold,
                              txtfontsize: MyFontSize.size18,
                              txtcolor: MyColors.textColor,
                              txtAlign: TextAlign.center,
                              height: 1,
                            ),
                            SizedBox(
                              height: Get.height * .05,
                            ),
                            Container(
                              height: Get.height * .010,
                              width: Get.width * .60,
                              decoration: BoxDecoration(
                                  color: MyColors.buttonBgColor,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Get.width * .020))),
                            ),
                            SizedBox(
                              height: Get.height * .05,
                            ),
                            Container(
                              height: Get.height * .25,
                              child: TIPopupGridviewMenu(popupTitle: widget.popupTitle,startIndex: 0,endIndex: 5,),
                            )
                          ],
                        )),

                      ],
                    )))),
            Obx(() => Visibility(
                  visible: myController.showPrepareProjectMenu.value,
                  child: BackdropFilter(
                    filter: myController.showPrepareProjectMenu.value
                        ? ImageFilter.blur(sigmaY: 30, sigmaX: 30)
                        : ImageFilter.blur(sigmaY: 0, sigmaX: 0),
                    child: Container(
                      height: Get.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(MyImageURL.login),fit: BoxFit.fill)
                      ),
                      child: Stack(
                        children: [
                          Visibility(
                            visible: myController.isFavMenu.value,
                            child: Container(
                              height: Get.height * .90,
                              decoration: BoxDecoration(
                                 color: MyColors.buttonBgColor.withOpacity(0.46)),
                            ),
                          ),
                          Container(
                            // color: MyColors.buttonBgColorHome.withOpacity(0.46),
                            color: myController.isFavMenu.value == true ?MyColors.buttonBgColorHome.withOpacity(0.46):Colors.transparent,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(top: Get.height * .45),
                                child: MyFlyMenus(
                                  flyMenusList: flyMenusList,
                                  itemWidth: Get.height * .12,
                                  itemHeight: Get.height * .12,
                                  fromWhere: MyStrings.fromHaudos,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),

      ),
    );
  }

  _travelLougeList() {
    return Obx((){
      return Container(
        margin: EdgeInsets.only(top: Get.height * .06),
        child: ListView.builder(
            itemCount: myController.mList.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {

              double distance = calculateDistance(myController.mList[index].lat,myController.mList[index].lng);
              myController.mList[index].km = distance;
              return GestureDetector(
                onTap: () {
                  widget.popupTitle = myController.mList[index].name;
                  myController.selectedPlace.value = myController.mList[index];
                  myController.showPrepareProjectPopup.value = true;
                  myController.isFavMenu.value=false;
                },
                child: Container(
                 height: Get.height * .16,
                  width: Get.width * .80,
                  margin: EdgeInsets.only(
                      left: Get.width * .06,
                      right: Get.width * .06,
                      bottom: Get.width * .030),
                  padding: EdgeInsets.all(Get.width * .035),

                  decoration: BoxDecoration(
                    // color: MyColors.buttonBgColor,
                    color: MyColors.whiteColor,
                   /* image: DecorationImage(
                      image: NetworkImage(myController.mList[index].photo_ref != null ?getPhotoImage(myController.mList[index].photo_ref) : myController.mList[index].imgUrl),
                      fit: BoxFit.fill,
                    ),*/
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: Get.height * .10,
                        width: Get.height * .12,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(Get.width*.08)),
                            image: DecorationImage(
                                image: NetworkImage(myController.mList[index].photo_ref != null ?getPhotoImage(myController.mList[index].photo_ref) : myController.mList[index].imgUrl),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                child: MyTextwithMaxLine(
                                  text_name: myController.mList[index].name,
                                  myFont: MyFont.Cagliostro_reguler,
                                  txtfontsize: MyFontSize.size18,
                                  txtcolor: MyColors.buttonBgColor,
                                  txtAlign: TextAlign.center,
                                  maxLine: 2,
                                  // height: 0.5,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: MyText(
                                  // text_name: myController.mList[index].description,
                                  text_name:"${distance.toStringAsFixed(2)} KM",

                                  myFont: MyFont.Courier_Prime_Bold,
                                  txtfontsize: MyFontSize.size13,
                                  txtcolor: MyColors.buttonBgColor,
                                  txtAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    });
  }
}

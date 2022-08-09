import 'dart:ui';

import 'package:flutter/material.dart';
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

class TIMyFavoriteCitiesScreen extends StatefulWidget {
  String travelLougeTitle, popupTitle = "";
  TIMyFavoriteCitiesScreen({this.travelLougeTitle});

  @override
  State<TIMyFavoriteCitiesScreen> createState() => _TIMyFavoriteCitiesScreenState();
}

class _TIMyFavoriteCitiesScreenState extends State<TIMyFavoriteCitiesScreen> {




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
    getFavCities();

  }

  getFavCities() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myController.getFav();
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBodyContent(),
          // myController.showPrepareProjectPopup.value
      ),
    );
  }

  _buildBodyContent() {
    return Container(
      height: Get.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image:AssetImage(MyImageURL.login),fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              MyTopHeader(
                logoImgUrl: MyImageURL.haudos_logo,
              ),
              SizedBox(
                height: Get.height * .020,
              ),
              Obx((){
                return myController.showPrepareProjectPopup.value == true ? Container():MyTitlebar(title: widget.travelLougeTitle.toUpperCase(),);
              }),

              SizedBox(
                height: Get.height * .07,
              ),
              Obx((){
                return myController.showPrepareProjectPopup.value == true ? Container():Expanded(child: _travelLougeList());
              }),

            ],
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
          _buildPopupWidget(),
          _buildMenus(),
        ],
      ),
    );
  }

  _buildPopupWidget() {
    return Obx(() => Visibility(
        visible: myController.showPrepareProjectPopup.value,
        child: Container(
            width: Get.width,
            child: Stack(
              children: [
                Positioned(
                  top: 75,
                  left: 40,
                  right: 40,
                  child: TICommonPopup(
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
                                  text_name: widget.popupTitle.toUpperCase() ?? "",
                                  myFont: MyFont.Cagliostro_reguler,
                                  txtfontsize: MyFontSize.size18,
                                  txtcolor: MyColors.buttonBgColor,
                                  txtAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              myController.showPrepareProjectPopup.value =
                                  false;
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
                        text_name: "${myController.selectedFavPlace.value.km != null ?myController.selectedFavPlace.value.km.toStringAsFixed(2): "0"} KM",
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
                            color: MyColors.lineColor,
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
                ),
                /*Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: Get.height * .04),
                      child: GestureDetector(
                        onTap: () {
                          myController.showPrepareProjectMenu.value = true;
                          myController.isFavMenu.value=false;
                        },
                        child: Image.asset(
                          MyImageURL.fleche,
                          height: Get.height * .13,
                          width: Get.height * .13,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ))*/
              ],
            ))));
  }

  _buildMenus() {
    return Obx(() => Visibility(
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
                    color: myController.isFavMenu.value == true ?MyColors.buttonBgColorHome.withOpacity(0.46):Colors.transparent,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.height * .48),
                        child: MyFlyMenus(
                          flyMenusList: flyMenusList,
                          itemWidth: Get.height * .12,
                          itemHeight: Get.height * .12,
                          fromWhere: MyStrings.fromFavCity,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _travelLougeList() {
    if(myController.favList.value != null && myController.favList.value.length>0){
      return Obx((){
        return Container(
          margin: EdgeInsets.only(
              left: Get.width * .10,
              right: Get.width * .10,
              bottom: Get.height * .10),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 8,
                  crossAxisSpacing: Get.width * .10,
                  mainAxisSpacing: Get.height * .020),
              shrinkWrap: true,
              itemCount: myController.favList.value.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {

                return GestureDetector(
                  onTap: () {
                    myController.selectedFavPlace.value =myController.favList.value[index];
                    widget.popupTitle = myController.favList.value[index].name;
                    myController.showPrepareProjectPopup.value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.all(Get.width * .020),
                    decoration: BoxDecoration(
                      // color: Colors.green,
                      image: DecorationImage(
                        image: NetworkImage(myController.favList.value[index].imgUrl.startsWith("http") ? myController.favList.value[index].imgUrl : getPhotoImage(myController.favList.value[index].imgUrl)),
                        fit: BoxFit.fill,
                      ),
                      borderRadius:
                      BorderRadius.all(Radius.circular(Get.width * .080)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyText(
                          text_name: myController.favList.value[index].name.toUpperCase(),
                          myFont: MyFont.Cagliostro_reguler,
                          txtfontsize: MyFontSize.size13,
                          txtcolor: Colors.white,
                          txtAlign: TextAlign.center,
                          height: 1,
                        ),
                        MyText(
                          text_name: "${myController.favList.value[index].km.toStringAsFixed(2)} KM",
                          myFont: MyFont.Courier_Prime_Bold,
                          txtfontsize: MyFontSize.size13,
                          txtcolor: Colors.white,
                          txtAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      });
    }else{
      return Container();
    }

  }
}

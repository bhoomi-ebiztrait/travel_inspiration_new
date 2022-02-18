import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyFlyMenu.dart';
import 'package:travel_inspiration/MyWidget/MyFlyMenus.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
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
      ),
    );
  }

  _buildBodyContent() {
    return Stack(
      children: [
        Column(
          children: [
            MyTopHeader(
              headerName: widget.travelLougeTitle.toUpperCase(),
              headerImgUrl: MyImageURL.travel_book_top,
              logoImgUrl: MyImageURL.haudos_logo,
            ),
            SizedBox(
              height: Get.height * .020,
            ),
            Obx((){
              return Expanded(child: _travelLougeList());
            }),

          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: MyBottomLayout(
            imgUrl: MyImageURL.travel_book_bottom,
          ),
        ),
        _buildPopupWidget(),
        _buildMenus(),
      ],
    );
  }

  _buildPopupWidget() {
    return Obx(() => Visibility(
        visible: myController.showPrepareProjectPopup.value,
        child: BackdropFilter(
            filter: myController.showPrepareProjectPopup.value
                ? ImageFilter.blur(sigmaY: 5, sigmaX: 5)
                : ImageFilter.blur(sigmaY: 0, sigmaX: 0),
            child: Container(
                width: Get.width,
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
                          text_name: "MODE INSPIRE",
                          myFont: MyFont.Courier_Prime_Bold,
                          txtfontsize: MyFontSize.size18,
                          txtcolor: MyColors.textColor,
                          txtAlign: TextAlign.center,
                          height: 0.8,
                        ),
                        MyText(
                          text_name: "532 KM",
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
                    Align(
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
                        ))
                  ],
                )))));
  }

  _buildMenus() {
    return Obx(() => Visibility(
          visible: myController.showPrepareProjectMenu.value,
          child: BackdropFilter(
            filter: myController.showPrepareProjectMenu.value
                ? ImageFilter.blur(sigmaY: 3, sigmaX: 3)
                : ImageFilter.blur(sigmaY: 0, sigmaX: 0),
            child: Stack(
              children: [
                Container(
                  height: Get.height * .90,
                  decoration: BoxDecoration(
                      color: MyColors.whiteColor.withOpacity(0.97)),
                ),
                Align(
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
              ],
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

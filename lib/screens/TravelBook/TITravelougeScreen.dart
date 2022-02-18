import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/Gallery/GalleryScreen.dart';
import 'package:travel_inspiration/screens/TIPinDestinationToProjectScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TIMyHaudosDestinationScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'TIMyFavoriteCitiesScreen.dart';

class TITravelougeScreen extends StatefulWidget {
  double updatedKm;
  TITravelougeScreen(this.updatedKm);

  @override
  State<TITravelougeScreen> createState() => _TITravelougeScreenState();
}

class _TITravelougeScreenState extends State<TITravelougeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyController myController = Get.put(MyController());
    myController.stopTracking();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBodyContent(widget.updatedKm),
        bottomSheet: MyBottomLayout(
          imgUrl: MyImageURL.travel_book_bottom,
        ),
      ),
    );
  }
}

_buildBodyContent(double updatedKm) {
  return Column(
    children: [
      MyTopHeader(
        headerName: "txtCARNETDEVOYAGE".tr,
        headerImgUrl: MyImageURL.travel_book_top,
        logoImgUrl: MyImageURL.haudos_logo,
      ),
      SizedBox(
        height: Get.height * .06,
      ),
      _buildMyDestination(updatedKm),
      SizedBox(
        height: Get.height * .08,
      ),
      _buildMyCities(),
      SizedBox(
        height: Get.height * .08,
      ),
      _buildMyProject()
    ],
  );
}

_buildMyDestination(double updatedKm){

  return GestureDetector(
    onTap: () {
      ScreenTransition.navigateToScreenLeft(
          screenName: TIMyHaudosDestinationScreen(
        travelLougeTitle: "txtMesdestinations".tr,
            updatedKm: updatedKm,
      ));
    },
    child: Container(
      margin: EdgeInsets.only(left: Get.width * .10),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Image.asset(MyImageURL.glob_icoc),
        SizedBox(
          width: Get.width * .040,
        ),
        MyText(
          text_name: "txtMesdestinations".tr,
          myFont: MyFont.Courier_Prime_Bold,
          txtfontsize: MyFontSize.size13,
          txtcolor: MyColors.textColor,
          txtAlign: TextAlign.left,
        )
      ]),
    ),
  );
}

_buildMyCities() {
  return GestureDetector(
    onTap: () {
      ScreenTransition.navigateToScreenLeft(
          screenName: TIMyFavoriteCitiesScreen(
        travelLougeTitle: "txtMesvilles".tr,
      ));
    },
    child: Container(
      margin: EdgeInsets.only(left: Get.width * .10),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Image.asset(MyImageURL.red_heart),
        SizedBox(
          width: Get.width * .040,
        ),
        MyText(
          text_name: "txtMesvilles".tr,
          myFont: MyFont.Courier_Prime_Bold,
          txtfontsize: MyFontSize.size13,
          txtcolor: MyColors.textColor,
          txtAlign: TextAlign.left,
        )
      ]),
    ),
  );
}

_buildMyProject() {
  return GestureDetector(
    onTap: () {
      ScreenTransition.navigateToScreenLeft(
          screenName: TIPinDestinationToProjectScreen(
        travelLougeTitle: "txtMesprojets".tr,
      ));
    },
    child: Container(
      margin: EdgeInsets.only(left: Get.width * .10),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Image.asset(MyImageURL.projet_icon),
        SizedBox(
          width: Get.width * .040,
        ),
        MyText(
          text_name: "txtMesprojets".tr,
          myFont: MyFont.Courier_Prime_Bold,
          txtfontsize: MyFontSize.size13,
          txtcolor: MyColors.textColor,
          txtAlign: TextAlign.left,
        )
      ]),
    ),
  );
}

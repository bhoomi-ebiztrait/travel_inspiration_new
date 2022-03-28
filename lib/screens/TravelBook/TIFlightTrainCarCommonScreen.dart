import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/screens/TravelBook/MyRouteListScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/MyRouteScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TIFlightAndTrainManualAddScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';
import 'package:travel_inspiration/utils/TITag.dart';

import 'TIMyFlightTrainScreen.dart';

class TIFlightTrainCarCommonScreen extends StatefulWidget {
  String travelLougeListTitle, Tag;

  TIFlightTrainCarCommonScreen({this.travelLougeListTitle, this.Tag});

  @override
  State<TIFlightTrainCarCommonScreen> createState() => _TIFlightTrainCarCommonScreenState();
}

class _TIFlightTrainCarCommonScreenState extends State<TIFlightTrainCarCommonScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyImageURL.login),fit: BoxFit.fill,
          ),
        ),
        child: _commonWidgetForPlain_Train_Car(),
      ),

    ));
  }

  _commonWidgetForPlain_Train_Car() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        MyTopHeader(
          headerImgUrl: MyImageURL.travel_book_top,
          logoImgUrl: MyImageURL.haudos_logo,
        ),
        SizedBox(
          height: Get.height * .020,
        ),
        MyTitlebar(title: widget.travelLougeListTitle,),

        SizedBox(
          height: Get.height * .020,
        ),

        GestureDetector(
            onTap: () {
              switch (widget.Tag) {
                case TITag.TAGPLAIN:
                  ScreenTransition.navigateToScreenLeft(
                      screenName: TiMyFlightTrainScreen(
                    travelLougeListTitle: widget.travelLougeListTitle,
                  ));
                  break;
                case TITag.TAGTRAIN:
                  MyCommonMethods.showInfoCenterDialog(
                      msgContent: "comming_soon".tr);
                 /* ScreenTransition.navigateToScreenLeft(
                      screenName: TiMyFlightTrainScreen(
                    travelLougeListTitle: widget.travelLougeListTitle,
                  ));*/
                  break;
                case TITag.TAGCAR:
                  getCurrLatLng();
                  break;
              }
            },
            child: Container(
                margin: EdgeInsets.only(left: Get.width*0.17,right: Get.width*0.17,top: Get.height*0.06),
                child: Image.asset(_centerImage()))),
        SizedBox(
          height: Get.height * .02,
        ),
        MyText(
          text_name: _commonTextWidget() + "  :",
          myFont: MyStrings.bodoni72_Bold,
          txtfontsize: MyFontSize.size20,
          txtcolor: MyColors.whiteColor,
          txtAlign: TextAlign.center,
        ),
        /*SizedBox(
          height: Get.height * .1,
        ),*/
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 120.0,vertical: 40),
          child: MyButton(
            onClick: () {
              switch (widget.Tag) {
                case TITag.TAGPLAIN:
                  ScreenTransition.navigateToScreenLeft(
                      screenName: TIFlightAndTrainManualAddScreen(
                        travelLougeListTitle: widget.travelLougeListTitle,
                        Tag: TITag.TAGPLAIN,
                      ));
                  break;
                case TITag.TAGTRAIN:
                  ScreenTransition.navigateToScreenLeft(
                      screenName: TIFlightAndTrainManualAddScreen(
                        travelLougeListTitle: widget.travelLougeListTitle,
                        Tag: TITag.TAGTRAIN,
                      ));
                  break;
                case TITag.TAGCAR:
                //getCurrLatLng();
                  ScreenTransition.navigateToScreenLeft(
                      screenName: MyRouteListScreen());
                  break;
              }
            },
            btn_name: _buttonRightText(),
            txtcolor: MyColors.buttonBgColor,
            bgColor: MyColors.whiteColor,
            opacity: 1,
            myFont: MyStrings.courier_prime_bold,
            txtfont: MyFontSize.size13,
          ),
        ),
        /*MyButtonRight(
          onClick: () {
            switch (widget.Tag) {
              case TITag.TAGPLAIN:
                ScreenTransition.navigateToScreenLeft(
                    screenName: TIFlightAndTrainManualAddScreen(
                  travelLougeListTitle: widget.travelLougeListTitle,
                  Tag: TITag.TAGPLAIN,
                ));
                break;
              case TITag.TAGTRAIN:
                ScreenTransition.navigateToScreenLeft(
                    screenName: TIFlightAndTrainManualAddScreen(
                  travelLougeListTitle: widget.travelLougeListTitle,
                  Tag: TITag.TAGTRAIN,
                ));
                break;
              case TITag.TAGCAR:
                //getCurrLatLng();
                ScreenTransition.navigateToScreenLeft(
                    screenName: MyRouteListScreen());
                break;
            }
          },
          btn_name: _buttonRightText(),
          myFont: MyFont.Courier_Prime_Bold,
          txtfont: MyFontSize.size13,
          txtcolor: MyColors.textColor,
          imgeUrl: _buttonImage(),
        )*/
      ],
    );
  }

  _commonTextWidget() {
    switch (widget.Tag) {
      case TITag.TAGPLAIN:
        return "txtRechercherunvol".tr;
        break;
      case TITag.TAGTRAIN:
        return "txtRechercheruntrain".tr;
        break;
      case TITag.TAGCAR:
        return "find_road_route".tr;
        break;
    }
  }

  _centerImage() {
    switch (widget.Tag) {
      case TITag.TAGPLAIN:
        return MyImageURL.plane_circle;
        break;
      case TITag.TAGTRAIN:
        return MyImageURL.train_circle;
        break;
      case TITag.TAGCAR:
        return MyImageURL.car_circle;
        break;
    }
  }

  _buttonRightText() {
    switch (widget.Tag) {
      case TITag.TAGPLAIN:
        return "txtMESVOLS".tr;
        break;
      case TITag.TAGTRAIN:
        return "txtMesTrains".tr;
        break;
      case TITag.TAGCAR:
        return "my_routes".tr;
        break;
    }
  }

  _buttonImage() {
    switch (widget.Tag) {
      case TITag.TAGPLAIN:
        return MyImageURL.plane_icon;
        break;
      case TITag.TAGTRAIN:
        return MyImageURL.train2x_icon;
        break;
      case TITag.TAGCAR:
        return MyImageURL.car;
        break;
    }
  }

   getCurrLatLng() async{
     Position _getCurrentPosition = await determineCurrentPosition();
     ScreenTransition.navigateToScreenLeft(
         screenName: MyRouteScreen(_getCurrentPosition));
   }
}

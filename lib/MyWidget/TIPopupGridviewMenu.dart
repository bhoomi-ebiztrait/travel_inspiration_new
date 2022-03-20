import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIModel/TIPopupGridViewModel.dart';
import 'package:travel_inspiration/screens/TravelBook/TIActivityListScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TIFlightTrainCarCommonScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TIHotelListScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TIRestaurantListScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';
import 'package:travel_inspiration/utils/TITag.dart';

class TIPopupGridviewMenu extends StatefulWidget {

  String popupTitle;
  int startIndex,endIndex;


  TIPopupGridviewMenu({this.popupTitle,this.startIndex,this.endIndex});

  @override
  State<TIPopupGridviewMenu> createState() => _TIPopupGridviewMenuState();
}

class _TIPopupGridviewMenuState extends State<TIPopupGridviewMenu> {
  int selectedIndex = -1;

  var popupItemList = [
    TIPopupGridViewModel(
      iconPath: MyImageURL.hotel_icon,
      title: "txtHOTELS".tr,
    ),
    TIPopupGridViewModel(
      iconPath: MyImageURL.restaurant_icon,
      title: "txtRESTAURANTS".tr,
    ),
    TIPopupGridViewModel(
      iconPath: MyImageURL.activites3x_icon,
      title: "txtACTIVITES".tr,
    ),
    TIPopupGridViewModel(
      iconPath: MyImageURL.plane_icon,
      title: "txtVOLS".tr,
    ),
    TIPopupGridViewModel(
      iconPath: MyImageURL.train2x_icon,
      title: "txtTRAINS".tr,
    ),
    TIPopupGridViewModel(
      iconPath: MyImageURL.car,
      title: "txtROUTE".tr,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: popupItemList.length,
        // itemCount: ((widget.endIndex) - (widget.startIndex)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          if(index < widget.startIndex || index > widget.endIndex)
            return Container();
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              switch (index) {
                case 0:
                  ScreenTransition.navigateToScreenLeft(
                      screenName: TIHotelListScreen(
                        travelLougeListTitle: widget.popupTitle.toUpperCase(),
                      ));
                  break;
                case 1:
                  ScreenTransition.navigateToScreenLeft(
                      screenName: TIRestaurantListScreen(
                        travelLougeListTitle: widget.popupTitle.toUpperCase(),
                      ));
                  break;
                case 2:
                  ScreenTransition.navigateToScreenLeft(
                      screenName: TIActivityListScreen(
                        travelLougeListTitle: widget.popupTitle.toUpperCase(),
                      ));
                  break;
                case 3:
                  ScreenTransition.navigateToScreenLeft(
                      screenName: TIFlightTrainCarCommonScreen(
                        travelLougeListTitle: widget.popupTitle.toUpperCase(),
                        Tag: TITag.TAGPLAIN,
                      ));
                  break;
                case 4:
                  ScreenTransition.navigateToScreenLeft(
                      screenName: TIFlightTrainCarCommonScreen(
                        travelLougeListTitle: widget.popupTitle.toUpperCase(),
                        Tag: TITag.TAGTRAIN,
                      ));
                  break;
                case 5:
                  ScreenTransition.navigateToScreenLeft(
                      screenName: TIFlightTrainCarCommonScreen(
                        travelLougeListTitle: widget.popupTitle.toUpperCase(),
                        Tag: TITag.TAGCAR,
                      ));
                  break;
              }
            },
            child:_columnItem(index),
          );
        });
  }

  _columnItem(int index){
    return  Column(
      children: [
        Image.asset(
          popupItemList[index].iconPath,
          height: Get.height * .04,
          width: Get.height * .04,
          fit: BoxFit.contain,
         color: selectedIndex == index ? MyColors.buttonBgColor:MyColors.buttonBgColorHome ,
        ),
        SizedBox(
          height: Get.height * .020,
        ),
        MyText(
          text_name: popupItemList[index].title,
          myFont: MyFont.Courier_Prime_Bold,
          txtfontsize: MyFontSize.size11,
          txtcolor: selectedIndex == index ?MyColors.buttonBgColor:MyColors.textColor,
          txtAlign: TextAlign.center,
          height: 1,
        ),
      ],
    );
  }
}

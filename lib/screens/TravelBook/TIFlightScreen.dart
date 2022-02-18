import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

import 'MyVehicleScreen.dart';

class TIFlightScreen extends StatelessWidget {
  String travelLougeListTitle;

  TIFlightScreen({this.travelLougeListTitle});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body:_buildBodyContent(),
      bottomSheet: MyBottomLayout(
        imgUrl: MyImageURL.travel_book_bottom,
      ),
    ));
  }

  _buildBodyContent(){
    return  Column(
      children: [
        MyTopHeader(
          headerName: travelLougeListTitle,
          headerImgUrl: MyImageURL.travel_book_top,
          logoImgUrl: MyImageURL.haudos_logo,
        ),
        SizedBox(
          height: Get.height * .020,
        ),
        MyText(
          text_name: "txtRechercherunvol".tr + "  :",
          myFont: MyFont.Courier_Prime_Bold,
          txtfontsize: MyFontSize.size13,
          txtcolor: MyColors.textColor,
          txtAlign: TextAlign.center,
        ),
        SizedBox(height: Get.height*.08,),
        // Image.asset(MyImageURL.recherche_vol3x),
        SizedBox(height: Get.height*.04,),
        GestureDetector(
          onTap: (){
            Get.to(()=>MyVehicleScreen(travelLougeListTitle:travelLougeListTitle,subTitle:"txtRechercherunvol".tr + "  :"));
          },
          child:Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: Get.height * .050,
              width: Get.width * .40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Get.width * .045),
                    bottomLeft: Radius.circular(Get.width * .045),
                  ),
                  border: Border.all(
                    color: MyColors.expantionTileBgColor,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: MyColors.expantionTileBgColor,
                        offset:Offset(1,1)
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Image.asset(MyImageURL.plane_icon,
                    height: Get.height*.035,
                    width: Get.height*.035,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: Get.width * .020,
                  ),
                  MyText(
                    text_name:"txtMESVOLS".tr,
                    myFont: MyFont.Courier_Prime_Bold,
                    txtfontsize: MyFontSize.size13,
                    txtcolor: MyColors.textColor,
                    txtAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

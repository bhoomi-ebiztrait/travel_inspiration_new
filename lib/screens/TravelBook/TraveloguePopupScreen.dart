import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class TraveloguePopupScreen extends StatelessWidget {
  String travelLougeListTitle;
  String subTitle;
  String imgLogo;
  String btnIcon;
  String btnName;
  Function btnClick;

  TraveloguePopupScreen({this.travelLougeListTitle,this.subTitle,this.imgLogo,this.btnIcon,this.btnName,this.btnClick});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              MyTopHeader(
                headerName: travelLougeListTitle,
                headerImgUrl: MyImageURL.travel_book_top,
                logoImgUrl: MyImageURL.haudos_logo,
              ),
              SizedBox(
                height: Get.height * .04,
              ),
              MyText(
                text_name: subTitle,
                myFont: MyFont.Courier_Prime_Bold,
                txtfontsize: MyFontSize.size13,
                txtcolor: MyColors.textColor,
                txtAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height*.08,),
              Image.asset(imgLogo),
              SizedBox(height: Get.height*.04,),

              MyButtonRight(
                  btn_name: btnName,
                  imgeUrl: btnIcon,
                  myFont: MyStrings.courier_prime_bold,
                  txtfont: MyFontSize.size10,
                onClick: btnClick,
                ),

            ],
          ),
          bottomSheet: MyBottomLayout(
            imgUrl: MyImageURL.travel_book_bottom,
          ),
        ));
  }
}

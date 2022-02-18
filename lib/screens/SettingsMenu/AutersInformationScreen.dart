import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/screens/SettingsMenu/DeleteAcSecondScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

class AutersInformationScreen extends StatelessWidget {
  String title;
  String desc;
  bool isDeleteAc;
  AutersInformationScreen({this.title,this.desc,this.isDeleteAc = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTopHeader(headerName: "auters_info".tr,
                headerImgUrl: MyImageURL.setting_top,
                logoImgUrl: MyImageURL.haudos_logo,
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:30.0),
                child: MyTextStart(text_name: title,
                  txtfontsize: MyFontSize.size14,txtcolor: MyColors.textColor,myFont: MyStrings.courier_prime_bold,),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child:Html(data: desc,),
                // MyTextStart(text_name: desc,
                //     txtfontsize: MyFontSize.size12,txtcolor: MyColors.textColor),
              ),
              buildDeleteAc(),
            ],
          ),
        ),
        bottomNavigationBar: buildBottomImage(),
      ),
    );
  }

  buildDeleteAc() {
    return Visibility(
      visible: isDeleteAc,
      child: GestureDetector(
        onTap: (){
          ScreenTransition.navigateToScreenLeft(screenName:
          DeleteAcSecondScreen());
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0,right:10,top: 20,bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTextStart(
                  text_name: "delete_my_account".tr,

                  myFont: MyStrings.courier_prime_bold,
                  txtfontsize: MyFontSize.size13,
                  txtcolor: MyColors.redColor),

              Container(
                  width: Get.width * 0.4,
                  alignment: Alignment.topLeft,
                  child: Image.asset(MyImageURL.delete_ac)),

            ],
          ),
        ),
      ),
    );
  }


  buildBottomImage() {
    return Container(
      height: Get.height*.10,
      width: Get.width,
      child: Image.asset(MyImageURL.setting_bottom,
        fit: BoxFit.fitWidth,
        ),
    );
  }
}

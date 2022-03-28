import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/CreateProfileScreen.dart';
import 'package:travel_inspiration/screens/Gallery/GalleryScreen.dart';
import 'package:travel_inspiration/screens/MyProfileScreen.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/SettingScreen.dart';
import 'package:travel_inspiration/screens/TIGiaListScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

class MyPopupBottomMenu extends StatelessWidget {


  List<String> iconList = [];
  String bgImg;
  Color bgColor;
  MyController myController = Get.put(MyController());
  MyPopupBottomMenu({this.iconList,this.bgImg,this.bgColor = Colors.transparent}) ;

  @override
  Widget build(BuildContext context) {
    return buildMenuOptions();
  }



  buildMenuOptions() {
    return Container(
      width: Get.width * 0.85,
      height: Get.height * 0.11,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          // color: MyColors.textColor.withOpacity(0.32),
        image: DecorationImage(image: AssetImage(bgImg),fit: BoxFit.fill),
         // border: Border.all(color: MyColors.textColor.withOpacity(0.32)),
          borderRadius: BorderRadius.circular(50),
         /* boxShadow: [
            BoxShadow(
              color: MyColors.textColor.withOpacity(0.32),
              blurRadius: 1.0,
            ),
          ]*/),

      padding: EdgeInsets.only(right: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: buildMenu(),

        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildProfileGallery(),
            buildGaiyaSetting(),
          ],
        ),*/
      ),
    );
  }

  buildMenu(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            ScreenTransition.navigateOffAll(screenName: MyProfileScreen());
          },
          child: Image.asset(
           // MyImageURL.profile_selected,
            iconList[0],
            height: Get.height * .04,
            width: Get.height * .04,
            // height: Get.height * 0.03,
            // width: Get.height * 0.08,
            fit: BoxFit.contain,
          ),
        ),
        GestureDetector(
          onTap: () {
            ScreenTransition.navigateOffAll(screenName: GalleryScreen());
          },
          child: Image.asset(
            // MyImageURL.galerie,
            iconList[1],
            height: Get.height * .04,
            width: Get.height * .04,
            // height: Get.height * .03,
            // width: Get.height * .03,
            fit: BoxFit.contain,
          ),
        ),

        GestureDetector(
          onTap: (){
            myController
                .showPrepareProjectMenu.value = true;
            myController.isFavMenu.value=false;

          },
          child: Image.asset(
            // MyImageURL.home_menu,
            iconList[2],
            height: Get.height * .08,
            width: Get.height * .08,
            fit: BoxFit.contain,
          ),
        ),
        GestureDetector(
          onTap: () {
            ScreenTransition.navigateOffAll(screenName: TIGiaListScreen());
          },
          child: Image.asset(
            // MyImageURL.world_icon,
            iconList[3],
            height: Get.height * .04,
            width: Get.height * .04,
            fit: BoxFit.contain,
          ),
        ),
    GestureDetector(
    onTap: () {
    ScreenTransition.navigateOffAll(screenName: SettingScreen());
    },
      child:  Image.asset(
          // MyImageURL.setting_icon,
        iconList[4],
          height: Get.height * .04,
          width: Get.height * .04,
          fit: BoxFit.contain,
        ),),
      ],
    );
  }
  buildGaiyaSetting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * 0.02,
            ),
            buildGaia(),
            SizedBox(
              width: Get.width * 0.04,
            ),
            buildSettings(),

          ],
        ),
      ],
    );
  }

  buildProfileGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildProfile(),
            SizedBox(
              width: Get.width * 0.05,
            ),
            buildGallery(),
            SizedBox(
              width: Get.width * 0.02,
            ),
          ],
        ),
      ],
    );
  }

  buildProfile() {
    return GestureDetector(
      onTap: () {
        ScreenTransition.navigateToScreenLeft(screenName: MyProfileScreen());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            MyImageURL.profile_icon,
            height: Get.height * .04,
            width: Get.height * .04,
            fit: BoxFit.contain,
          ),
          // SizedBox(
          //   height: Get.height * 0.005,
          // ),
          // MyText(
          //   text_name: "profile".tr,
          //   txtcolor: MyColors.whiteColor,
          //   myFont: MyStrings.courier_prime_bold,
          //   txtfontsize: MyFontSize.size8,
          // )
        ],
      ),
    );
  }

  buildGallery() {
    return GestureDetector(
      onTap: () {
        ScreenTransition.navigateToScreenLeft(screenName: GalleryScreen());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            MyImageURL.galerie,
            height: Get.height * .04,
            width: Get.height * .04,
            fit: BoxFit.contain,
          ),
          /* SizedBox(
            height: Get.height * 0.005,
          ),
          MyText(
            text_name: "gallery".tr.toUpperCase(),
            txtcolor: MyColors.whiteColor,
            myFont: MyStrings.courier_prime_bold,
            txtfontsize: MyFontSize.size8,
          )*/
        ],
      ),
    );
  }

  buildGaia() {
    return GestureDetector(
      onTap: () {
        ScreenTransition.navigateToScreenLeft(screenName: TIGiaListScreen());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            MyImageURL.world_icon,
            height: Get.height * .04,
            width: Get.height * .04,
            fit: BoxFit.contain,
          ),
          /*SizedBox(
            height: Get.height * 0.005,
          ),
          MyText(
            text_name: "gaia".tr.toUpperCase(),
            txtcolor: MyColors.whiteColor,
            myFont: MyStrings.courier_prime_bold,
            txtfontsize: MyFontSize.size8,
          )*/
        ],
      ),
    );
  }

  buildSettings() {
    return GestureDetector(
      onTap: () {
        ScreenTransition.navigateToScreenLeft(screenName: SettingScreen());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            MyImageURL.setting_icon,
            height: Get.height * .04,
            width: Get.height * .04,
            fit: BoxFit.contain,
          ),
          // SizedBox(
          //   height: Get.height * 0.005,
          // ),
          // MyText(
          //   text_name: "settings".tr.toUpperCase(),
          //   txtcolor: MyColors.whiteColor,
          //   myFont: MyStrings.courier_prime_bold,
          //   txtfontsize: MyFontSize.size8,
          // )
        ],
      ),
    );
  }
}

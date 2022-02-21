import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/CreateProfileScreen.dart';
import 'package:travel_inspiration/screens/Gallery/GalleryScreen.dart';
import 'package:travel_inspiration/screens/MyProfileScreen.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/SettingScreen.dart';
import 'package:travel_inspiration/screens/TIGiaListScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

class MyBottomMenu extends StatelessWidget {
  VoidCallback homeMenuCallback;
  MyController myController = Get.put(MyController());

  MyBottomMenu({Key key, this.homeMenuCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.only(left: 28,right: 28),
          child: Stack(
            children: [
              buildMenuOptions(),
              buildHomeOption()
            ],
          ),
        ));
  }

  buildHomeOption() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          height: Get.height * .17,
          width: Get.height * .11,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.all(Radius.circular(60)),
          //   // borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
          //   /*// border: Border.all(color:MyColors.textColor),
          //           boxShadow: [BoxShadow(
          //               // offset: Offset(0.0,3.0),
          //             color: MyColors.textColor,
          //             // spreadRadius: 2.0
          //             // blurRadius: 5.0
          //           ),]*/
          // ),
          child: GestureDetector(
              onTap: homeMenuCallback,
              child: Obx(() => Visibility(
                  visible: myController.showHomeIcon.value,
                  child: Image.asset(
                    MyImageURL.home_icon,
                  ))))),
    );
  }

  buildMenuOptions() {
    return Positioned(
      bottom: 20,
      child: Container(
        decoration: BoxDecoration(
            color: MyColors.textColor.withOpacity(0.32),
            border: Border.all(color: MyColors.textColor.withOpacity(0.32)),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: MyColors.textColor.withOpacity(0.32),
                blurRadius: 1.0,
              ),
            ]),
        width: Get.width * 0.85,
        height: Get.height * 0.12,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildProfileGallery(),
              buildGaiyaSetting(),
            ],
          ),
        ),
      ),
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
            buildGaia(),
            SizedBox(
              width: Get.width * 0.07,
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
              width: Get.width * 0.07,
            ),
            buildGallery(),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyCustomDialog.dart';
import 'package:travel_inspiration/MyWidget/MyGradientBottomMenu.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class GalleryScreen extends StatelessWidget {
  List<String> titleList = [
    "premium".tr,
    "my_documents".tr,
    "my_budget".tr,
    "my_suitcase".tr,
    "intractive_map".tr,
    "my_haudos".tr
  ];
  List<String> imgList = [
    MyImageURL.diamant_big,
    MyImageURL.documents,
    MyImageURL.budget,
    MyImageURL.valise,
    MyImageURL.carte,
    MyImageURL.haudos
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  MyGradientBottomMenu(iconList: [MyImageURL.profile_icon,MyImageURL.gallery_selected,MyImageURL.home_menu,MyImageURL.world_icon,MyImageURL.setting_icon],bgImg: MyImageURL.botom_bg,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: Get.height * 0.30,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      MyImageURL.gallery_top,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    MyTopHeader(),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: MyTitlebar(
                        title: "gallery".tr.toUpperCase(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
                child: GridView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: titleList.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: Get.height / 800,
                      mainAxisSpacing: 20.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return buildGridItem(index, context);
                    }),
              ),

            ],
          ),

          //  buildBottomImage(),
        ),
      ),
    );
  }

  buildGridItem(index, context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              if (index == 0) {
                return  MyCustomDialog(
                  popupName: "premium".tr,
                  popupInfo: "premium_info".tr,
                  popupDesc: "premium_desc".tr,
                  popupCondition: "see_sales_condition".tr,
                  popupLogo: MyImageURL.diamant_popup,
                );
              }
              if (index == 1) {
                return MyCustomDialog(
                  popupName: "my_documents".tr,
                  popupInfo: "document_info".tr,
                  popupDesc: "document_desc".tr,
                  popupCondition: "see_sales_condition".tr,
                  popupLogo: MyImageURL.document_popup,
                );
              }
              if (index == 2) {
                return MyCustomDialog(
                  popupName: "my_documents".tr,
                  popupInfo: "budget_info".tr,
                  popupDesc: "document_desc".tr,
                  popupCondition: "see_sales_condition".tr,
                  popupLogo: MyImageURL.budget_popup,
                );
              }
              if (index == 3) {
                return MyCustomDialog(
                  popupName: "my_suitcase".tr,
                  popupInfo: "valise_info".tr,
                  popupDesc: "document_desc".tr,
                  popupCondition: "see_sales_condition".tr,
                  popupLogo: MyImageURL.valise_popup,
                );
              }
              if (index == 4) {
                return MyCustomDialog(
                  popupName: "my_documents".tr,
                  popupInfo: "carte_info".tr,
                  popupDesc: "document_desc".tr,
                  popupCondition: "see_sales_condition".tr,
                  popupLogo: MyImageURL.carte_popup,
                );
              }
              if (index == 5) {
                return MyCustomDialog(
                  popupName: "my_documents".tr,
                  popupInfo: "mon_haudos_info".tr,
                  popupDesc: "document_desc".tr,
                  popupCondition: "see_sales_condition".tr,
                  popupLogo: MyImageURL.clock,
                );
              }
            });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(imgList[index])),

              ),
              child: MyText(
                text_name: index == 0 ? "" : "future".tr,
                myFont: MyStrings.courier_prime_bold,
                txtfontsize: MyFontSize.size11,
                txtcolor: MyColors.textColor,
              )),
          SizedBox(
            height: Get.height * 0.01,
          ),
          MyText(
            text_name: titleList[index],
            txtcolor: index == 0
                ? MyColors.buttonBgColor
                : MyColors.buttonBgColorHome,
            txtfontsize: MyFontSize.size10,
            myFont: MyStrings.courier_prime_bold,
          ),
        ],
      ),
    );
  }

  buildBottomImage() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: Get.width,
            child: Image.asset(
              MyImageURL.gallery_bottom,
              fit: BoxFit.fitWidth,
            )));
  }
}

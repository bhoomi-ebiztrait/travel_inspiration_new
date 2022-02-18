import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyCustomDialog.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
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
      body: SafeArea(
        child: Stack(
          children: [
            // SingleChildScrollView(
            //   child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                MyTopHeader(
                  headerName: "gallery".tr.toUpperCase(),
                  headerImgUrl: MyImageURL.gallery_top,
                  logoImgUrl: MyImageURL.logo_icon,
                  logoCallback: (){
                    CommonMethod.getAppMode();
                  },
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                GridView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: titleList.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: Get.height / 700,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return buildGridItem(index,context);
                    }),
              ],
            ),

            // ),
            buildBottomImage(),
          ],
        ),
      ),
    );
  }

  buildGridItem(index,context) {
    return GestureDetector(
      onTap: (){


        showDialog(context: context, builder: (BuildContext context){

          if(index == 0) {
            return MyCustomDialog(
              popupName: "premium".tr,
              popupInfo: "premium_info".tr,
              popupDesc: "premium_desc".tr,
              popupCondition: "see_sales_condition".tr,
              popupLogo: MyImageURL.diamant_popup,);
          }
          if(index == 1) {
            return MyCustomDialog(
              popupName: "my_documents".tr,
              popupInfo: "document_info".tr,
              popupDesc: "document_desc".tr,
              popupCondition: "see_sales_condition".tr,
              popupLogo: MyImageURL.document_popup,);
          }
          if(index == 2) {
            return MyCustomDialog(
              popupName: "my_documents".tr,
              popupInfo: "budget_info".tr,
              popupDesc: "document_desc".tr,
              popupCondition: "see_sales_condition".tr,
              popupLogo: MyImageURL.budget_popup,);
          }
          if(index == 3) {
            return MyCustomDialog(
              popupName: "my_suitcase".tr,
              popupInfo: "valise_info".tr,
              popupDesc: "document_desc".tr,
              popupCondition: "see_sales_condition".tr,
              popupLogo: MyImageURL.valise_popup,);
          }
          if(index == 4) {
            return MyCustomDialog(
              popupName: "my_documents".tr,
              popupInfo: "carte_info".tr,
              popupDesc: "document_desc".tr,
              popupCondition: "see_sales_condition".tr,
              popupLogo: MyImageURL.carte_popup,);
          }
          if(index == 5) {
            return MyCustomDialog(
              popupName: "my_documents".tr,
              popupInfo: "mon_haudos_info".tr,
              popupDesc: "document_desc".tr,
              popupCondition: "see_sales_condition".tr,
              popupLogo: MyImageURL.clock,);
          }
        });


      },
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 90, width: 90,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(imgList[index])),
              ),
              child: MyText(text_name: index ==0 ? "" :"future".tr,myFont: MyStrings.courier_prime_bold,txtfontsize: MyFontSize.size13,txtcolor: MyColors.textColor,)),
          SizedBox(
            height: Get.height * 0.01,
          ),
          MyText(
            text_name: titleList[index],
            txtcolor: MyColors.buttonBgColor,
            txtfontsize: MyFontSize.size8,
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

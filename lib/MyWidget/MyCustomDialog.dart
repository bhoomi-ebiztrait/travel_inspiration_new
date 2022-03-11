import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/screens/SettingsMenu/AutersInformationScreen.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import '../TIController/MyController.dart';
import 'MyButton.dart';
import 'MyText.dart';
import 'MyTextButton.dart';

class MyCustomDialog extends StatefulWidget {
  String popupInfo;
  String popupDesc;
  String popupCondition;
  String popupLogo;
  String popupName;

  MyCustomDialog({this.popupInfo,this.popupDesc,this.popupCondition,this.popupLogo,this.popupName});

  @override
  _MyCustomDialogState createState() => _MyCustomDialogState();
}

class _MyCustomDialogState extends State<MyCustomDialog> {
  bool isSelectedMonthly = false;
  bool isSelectedAnnual = false;
  MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child:Stack(
          children: [
            Container(
                alignment: Alignment.topCenter,
                child: Image.asset(MyImageURL.gallery_top,fit: BoxFit.fill,)),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: contentBox(context),
              ),
            ),
          ],
        ),
        // ),
        /* child: MyCustomDialog(
                      popupName: "premium".tr,
                      popupInfo: "premium_info".tr,
                      popupDesc: "premium_desc".tr,
                      popupCondition: "see_sales_condition".tr,
                      popupLogo: MyImageURL.diamant_popup,
                    ),*/
      ),
    );
   /* return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );*/
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[

        Container(
    padding: EdgeInsets.only(left: 20,top: (20.0), right: 20,bottom: 20
    ),
          margin: EdgeInsets.only(top: 90),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(color: MyColors.dialog_shadowColor,
                    blurRadius: 5
                ),
              ]
          ),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: (){

                      Get.back(result: true);
                    print("clicked");
                    },
                    child: Container(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(MyImageURL.cross,width: 40,))),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MyText(
                    text_name: widget.popupInfo,
                    txtcolor: MyColors.textColor,
                    txtfontsize: MyFontSize.size13,
                    myFont: MyStrings.courier_prime,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                priceContainer(),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MyText(
                    text_name: widget.popupDesc,
                    txtcolor: MyColors.textColor,
                    txtfontsize: MyFontSize.size10,
                    myFont: MyStrings.courier_prime_italic,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    callTermsApi(ApiParameter.TERMS_ID);
                  },
                  child: MyTextButton(
                    btn_name: "see_sales_condition".tr,
                    txtfont: MyFontSize.size10,
                    myFont: MyStrings.courier_prime_bold,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MyButton(
                    btn_name: "to_buy".tr,
                    opacity: 1,
                    onClick: (){
                      Get.back();
                    },
                    txtfont: MyFontSize.size18,
                    bgColor: MyColors.buttonBgColorHome.withOpacity(1),
                    txtcolor: MyColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
              ],
            ),
          ),
        ),

        Positioned(
          right: 40,
          left: 30,

          child: Container(
            height: 160,
            width: 160,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(

              image: DecorationImage(image: AssetImage(widget.popupLogo,),),
            ),
          ),
        ),

      ],
    );
  }

  priceContainer() {
    if(widget.popupName == "premium".tr)
    return buildPremiumPrice();
    else if(widget.popupName == "my_documents".tr)
      return buildDocumentPrice();
    else if(widget.popupName == "my_suitcase".tr)
      return buildValisePrice();
  }

  buildDocumentPrice(){
    return MyText(text_name: "£0,99",txtcolor: MyColors.lightGreenColor,myFont: MyStrings.cagliostro,txtfontsize: MyFontSize.size38,);
  }
   buildPremiumPrice() {
    return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        flex: 1,
        child: GestureDetector(
          onTap: (){
            setState(() {
              isSelectedMonthly = false;
              isSelectedAnnual = true;
            });
          },
          child: Container(
            // width: Get.width*0.3,
            // padding: EdgeInsets.all(14),
            height: 100,
            decoration: BoxDecoration(
              color: isSelectedAnnual ? MyColors.lightGreenColor : MyColors.whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(14)),
              border: Border.all(color: MyColors.lightGreenColor),
                boxShadow: [
                  BoxShadow(color: MyColors.dialog_shadowColor,
                      // offset: Offset(0,10),
                      blurRadius: 5
                  ),
                ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyText(
                  text_name: "premium_annual".tr,
                  txtfontsize: MyFontSize.size10,
                  txtcolor: isSelectedAnnual ? MyColors.whiteColor:MyColors.textColor,
                ),
                MyText(
                  text_name: "£49,99",
                  txtfontsize: MyFontSize.size15,
                  txtcolor: isSelectedAnnual ? MyColors.whiteColor:MyColors.lightGreenColor,
                  myFont: MyStrings.cagliostro,
                ),
              ],
            ),
          ),
        ),
      ),
SizedBox(width: Get.width*0.03,),
      Flexible(
        flex: 1,
        child: GestureDetector(
          onTap: (){
            setState(() {
              isSelectedMonthly = true;
              isSelectedAnnual = false;
            });
          },
          child: Container(
            // padding: EdgeInsets.all(14),
            // width: Get.width*0.3,
            height: 100,
            decoration: BoxDecoration(
              color: isSelectedMonthly ? MyColors.lightGreenColor : MyColors.whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(14)),
              border: Border.all(color: MyColors.lightGreenColor),
                boxShadow: [
                  BoxShadow(color: MyColors.dialog_shadowColor,
                      // offset: Offset(0,10),
                      blurRadius: 5
                  ),
                ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyText(
                  text_name: "premium_monthly".tr,
                  txtfontsize: MyFontSize.size10,
                  txtcolor: isSelectedMonthly ? MyColors.whiteColor:MyColors.textColor,
                ),
                MyText(
                  text_name: "£4,99",
                  txtfontsize: MyFontSize.size15,
                  txtcolor: isSelectedMonthly?MyColors.whiteColor:MyColors.lightGreenColor,
                  myFont: MyStrings.cagliostro,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
  }
  buildValisePrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: (){
              setState(() {
                isSelectedMonthly = false;
                isSelectedAnnual = true;
              });
            },
            child: Container(
              // width: Get.width*0.3,
              padding: EdgeInsets.all(5),
              height: 90,
              decoration: BoxDecoration(
                  color: isSelectedAnnual ? MyColors.lightGreenColor : MyColors.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  border: Border.all(color: MyColors.lightGreenColor),
                  boxShadow: [
                    BoxShadow(color: MyColors.dialog_shadowColor,
                        // offset: Offset(0,10),
                        blurRadius: 5
                    ),
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyTextStart(
                    text_name: "purchase_only".tr,
                    txtfontsize: MyFontSize.size8,
                    txtcolor: MyColors.textColor,
                  ),
                  MyTextEnd(
                    text_name: "£0,99",
                    txtfontsize: MyFontSize.size10,
                    txtcolor: isSelectedAnnual ? MyColors.whiteColor:MyColors.lightGreenColor,
                    myFont: MyStrings.cagliostro,
                  ),
                  MyTextStart(
                    text_name: "each_item_added".tr,
                    txtfontsize: MyFontSize.size8,
                    txtcolor: MyColors.textColor,
                  ),
                  MyTextEnd(
                    text_name: "£0,20",
                    txtfontsize: MyFontSize.size10,
                    txtcolor: isSelectedAnnual ? MyColors.whiteColor:MyColors.lightGreenColor,
                    myFont: MyStrings.cagliostro,
                  ),
                  MyTextStart(
                    text_name: "items_offered".tr,
                    txtfontsize: MyFontSize.size7,
                    txtcolor: MyColors.textColor,
                  ),

                ],
              ),
            ),
          ),
        ),
        SizedBox(width: Get.width*0.03,),
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: (){
              setState(() {
                isSelectedMonthly = true;
                isSelectedAnnual = false;
              });
            },
            child: Container(
              // padding: EdgeInsets.all(14),
              // width: Get.width*0.3,
              height: 90,
              decoration: BoxDecoration(
                  color: isSelectedMonthly ? MyColors.lightGreenColor : MyColors.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  border: Border.all(color: MyColors.lightGreenColor),
                  boxShadow: [
                    BoxShadow(color: MyColors.dialog_shadowColor,
                        // offset: Offset(0,10),
                        blurRadius: 5
                    ),
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyText(
                    text_name: "full_version".tr,
                    txtfontsize: MyFontSize.size8,
                    txtcolor: MyColors.textColor,
                  ),
                  MyText(
                    text_name: "£3,99",
                    txtfontsize: MyFontSize.size10,
                    txtcolor: isSelectedMonthly?MyColors.whiteColor:MyColors.lightGreenColor,
                    myFont: MyStrings.cagliostro,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  callTermsApi(int id) async{
    ApiManager apiManager = ApiManager();
    Get.dialog(Loading());

    await apiManager.getAuthInfo(id).then((response){
      Get.back();
      if(response != null)
        ScreenTransition.navigateToScreenLeft(screenName:AutersInformationScreen(title: response["page_title"],desc: response["details"],));
    });


  }
}

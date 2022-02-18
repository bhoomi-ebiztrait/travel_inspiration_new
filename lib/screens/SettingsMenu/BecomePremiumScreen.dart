import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class BecomePremiumScreen extends StatefulWidget {
  @override
  _BecomePremiumScreenState createState() => _BecomePremiumScreenState();
}

class _BecomePremiumScreenState extends State<BecomePremiumScreen> {
  bool isAnnualClicked = false;
  bool isMonthlyClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTopHeader(
                    headerName: "my_account".tr.toUpperCase(),
                    headerImgUrl: MyImageURL.setting_top,
                    logoImgUrl: MyImageURL.haudos_logo,
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  buildTitle(),
                  buildPremiumOption(),
                  MyText(text_name: "premium_account_allows_you".tr,myFont: MyStrings.courier_prime_bold,txtcolor: MyColors.textColor,txtfontsize: MyFontSize.size13,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:35.0,vertical: 10),
                    child: MyText(text_name: "premium_account_allows_msg".tr,txtcolor: MyColors.textColor,txtfontsize: MyFontSize.size10,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:60.0,vertical: 20),
                    child: MyButton(btn_name: "to_buy".tr.toUpperCase(),onClick:(){
                      Get.back();
                    },bgColor: MyColors.buttonBgColor,txtcolor: MyColors.whiteColor,fontWeight: FontWeight.bold,opacity: 1,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 10),
                    child: MyText(text_name: "condition_msg".tr,txtcolor: MyColors.textColor,txtfontsize: MyFontSize.size10,myFont: MyStrings.courier_prime_italic,),
                  ),
                  MyText(text_name: "see_terms_conditins_of_sale".tr,txtcolor: MyColors.textColor,txtfontsize: MyFontSize.size10,myFont: MyStrings.courier_prime_bold_italic,),
                  SizedBox(
                    height: Get.height * 0.2,
                  ),
                ],
              ),
            ),
          ),
          bottomSheet:buildBottomImage(),

    );
  }

  Padding buildPremiumOption() {
    return Padding(
                  padding: const EdgeInsets.only(top:10.0,bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            isAnnualClicked = !isAnnualClicked;
                          });
                        },
                        child: Column(
                          children: [
                            MyText(text_name: isAnnualClicked ? "£49,99":"Premium\nannuel",txtfontsize: isAnnualClicked ? MyFontSize.size20:MyFontSize.size13,txtcolor: MyColors.close_iconColor,myFont: MyStrings.courier_prime_bold,),
                            Image.asset(MyImageURL.info_blue,),
                          ],
                        ),
                      ),
                      Image.asset(MyImageURL.diamant_big),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            isMonthlyClicked = !isMonthlyClicked;
                          });
                        },
                        child: Column(
                          children: [
                            MyText(text_name: isMonthlyClicked ?"£4,99" :"Premium\nmensuel",txtfontsize: isMonthlyClicked ? MyFontSize.size20:MyFontSize.size13,txtcolor: MyColors.close_iconColor,myFont: MyStrings.courier_prime_bold,),
                            Image.asset(MyImageURL.info_blue),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
  }

   buildTitle() {
    return Padding(
                  padding: const EdgeInsets.only(left:30.0),
                  child: MyTextStart(text_name: "become_premium".tr,txtfontsize: MyFontSize.size13,txtcolor: MyColors.textColor,myFont: MyStrings.courier_prime_bold,),
                );
  }

  buildBottomImage() {
    return Container(
        width: Get.width,
       color: MyColors.whiteColor,
        child: Image.asset(MyImageURL.setting_bottom,fit:BoxFit.fitWidth,));
  }
}

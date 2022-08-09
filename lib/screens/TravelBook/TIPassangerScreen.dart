import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/MyWidget/TIMyCustomRoundedCornerButton.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class TIPassangerScreen extends StatefulWidget {


  String travelLougeListTitle;
  TIPassangerScreen({this.travelLougeListTitle});

  @override
  TIPassangerScreenState createState() => TIPassangerScreenState();
}

class TIPassangerScreenState extends State<TIPassangerScreen> {


  MyController myController = Get.put(MyController());
  List passengetList=[];
  @override

  void initState() {
    passengetList.clear();
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body:_buildBodyContent(),
          

    ));
  }

  _buildBodyContent(){
    return  Obx(() => SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: Get.height*0.30,
            width: Get.width,
            color: MyColors.buttonBgColorHome.withOpacity(0.7),
            child: Column(
              children: [
                MyTopHeader(
                  headerImgUrl: MyImageURL.travel_book_top,
                  logoImgUrl: MyImageURL.haudos_logo,

                ),
                MyTitlebar(title: widget.travelLougeListTitle,)
              ],
            ),
          ),
          Container(
           height: Get.height,
            width: Get.width,
            color: MyColors.buttonBgColorHome.withOpacity(0.30),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * .030,
                ),
                MyText(
                  text_name: "txtPassagers".tr,
                  myFont: MyFont.Courier_Prime_Bold,
                  txtfontsize: MyFontSize.size15,
                  txtcolor: MyColors.textColor,
                  txtAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * .030,
                ),
                _adultPassangerView(),
                _childrenPassangerView(),
                _babePassangerView(),
               // Spacer(),
                SizedBox(
                  height: Get.height * .1,
                ),
                TIMyCustomRoundedCornerButton(
                  onClickCallback: () {
                    String adults;
                    if (myController.noOfAdults.value != 0) {
                      adults = myController.noOfAdults.value.toString() +" "+ "txtAdults".tr;
                      passengetList.add(adults);
                    }
                    if (myController.noOfChildrens.value != 0) {
                      adults = myController.noOfChildrens.value.toString() +" "+ "txtChildren".tr;
                      // adults = ["txtAdults".tr, myController.noOfChildrens.value];
                      passengetList.add(adults);
                    }
                    if (myController.noOfBabes.value != 0) {
                      adults = myController.noOfBabes.value.toString() +" "+ "txtBabe".tr;
                      // adults = ["txtBabe".tr, myController.noOfBabes.value];
                      passengetList.add(adults);
                    }
                    Navigator.of(context).pop(passengetList);
                  },
                  buttonWidth: Get.width * .48,
                  buttonHeight: Get.height * .050,
                  btnBgColor: MyColors.buttonBgColor,
                  textColor: Colors.white,
                  btnText: "txtValider".tr,
                  fontSize: MyFontSize.size18,
                  myFont: MyFont.Courier_Prime_Bold,
                ),
                SizedBox(
                  height: Get.height * .020,
                ),
              ],
            ),
          ),

        ],
      ),
    ));
  }

  _adultPassangerView() {
    return Container(
      margin: EdgeInsets.all(Get.width * 0.05),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Get.width * .50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextStart(
                      text_name: "txtAdults".tr,
                      txtcolor: MyColors.textColor,
                      myFont: MyFont.Courier_Prime,
                      txtfontsize: MyFontSize.size13,
                    ),
                    SizedBox(
                      height: Get.height * .004,
                    ),
                    MyTextStart(
                      text_name: "txtAdultSubTitle".tr,
                      txtcolor: MyColors.textColor.withOpacity(0.3),
                      myFont: MyFont.Courier_Prime,
                      txtfontsize: MyFontSize.size10,
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width * .35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (myController.noOfAdults.value != 0) {
                            myController.noOfAdults.value--;
                          }
                        },
                        child: Image.asset(MyImageURL.minus_blue,height: 45,width: 45,)),
                    MyText(
                      text_name: myController.noOfAdults.value.toString(),
                      myFont: MyFont.Courier_Prime_Bold,
                      txtfontsize: MyFontSize.size13,
                      txtcolor: MyColors.textColor,
                      txtAlign: TextAlign.center,
                    ),
                    GestureDetector(
                        onTap: () {
                          myController.noOfAdults.value++;
                        },
                        child: Image.asset(MyImageURL.add_blue,height: 45,width: 45,)),
                  ],
                ),
              ),
            ],
          ),
          MyCommonMethods.myDivider(),      ],
      ),
    );
  }

  _childrenPassangerView() {
    return Container(
      margin: EdgeInsets.all(Get.width * 0.05),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Get.width * .50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextStart(
                      text_name: "txtChildren".tr,
                      txtcolor: MyColors.textColor,
                      myFont: MyFont.Courier_Prime,
                      txtfontsize: MyFontSize.size13,
                    ),
                    SizedBox(
                      height: Get.height * .004,
                    ),
                    MyTextStart(
                      text_name: "txtChildrenSubTitle".tr,
                      txtcolor: MyColors.textColor.withOpacity(0.3),
                      myFont: MyFont.Courier_Prime,
                      txtfontsize: MyFontSize.size10,
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width * .35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (myController.noOfChildrens.value != 0) {
                            myController.noOfChildrens.value--;
                          }
                        },
                        child: Image.asset(MyImageURL.minus_blue,height: 45,width: 45,)),
                    MyText(
                      text_name: myController.noOfChildrens.value.toString(),
                      myFont: MyFont.Courier_Prime_Bold,
                      txtfontsize: MyFontSize.size13,
                      txtcolor: MyColors.textColor,
                      txtAlign: TextAlign.center,
                    ),
                    GestureDetector(
                        onTap: () {
                          myController.noOfChildrens.value++;
                        },
                        child: Image.asset(MyImageURL.add_blue,height: 45,width: 45,)),
                  ],
                ),
              ),
            ],
          ),
          MyCommonMethods.myDivider(),
        ],
      ),
    );
  }

  _babePassangerView() {
    return Container(
      margin: EdgeInsets.all(Get.width * 0.05),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Get.width * .50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextStart(
                      text_name: "txtBabe".tr,
                      txtcolor: MyColors.textColor,
                      myFont: MyFont.Courier_Prime,
                      txtfontsize: MyFontSize.size13,
                    ),
                    SizedBox(
                      height: Get.height * .004,
                    ),
                    MyTextStart(
                      text_name: "txtBabeSubTitle".tr,
                      txtcolor: MyColors.textColor.withOpacity(0.3),
                      myFont: MyFont.Courier_Prime,
                      txtfontsize: MyFontSize.size10,
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width * .35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (myController.noOfBabes.value != 0) {
                            myController.noOfBabes.value--;
                          }
                        },
                        child:Image.asset(MyImageURL.minus_blue,height: 45,width: 45,)),
                    MyText(
                      text_name: myController.noOfBabes.value.toString(),
                      myFont: MyFont.Courier_Prime_Bold,
                      txtfontsize: MyFontSize.size13,
                      txtcolor: MyColors.textColor,
                      txtAlign: TextAlign.center,
                    ),
                    GestureDetector(
                        onTap: (){
                          myController.noOfBabes.value++;
                        },
                        child: Image.asset(MyImageURL.add_blue,height: 45,width: 45,)),
                  ],
                ),
              ),
            ],
          ),
         MyCommonMethods.myDivider(),
        ],
      ),
    );
  }
}

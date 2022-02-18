import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyCustomRoundedCornerButton.dart';
import 'package:travel_inspiration/TIModel/TiMyFlightDetailModel.dart';
import 'package:travel_inspiration/screens/TravelBook/TIFlightSearchScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class MyVehicleScreen extends StatelessWidget {
  String travelLougeListTitle;
  String subTitle;

  MyVehicleScreen({this.travelLougeListTitle,this.subTitle});

  List<TIMyFlightDetailModel> myFlightDetailList=[
    TIMyFlightDetailModel(title:"txtDepuis".tr,subTitle: "txtDepuistxtDepuis".tr),
    TIMyFlightDetailModel(title:"txtOu".tr,subTitle: "txtOutxtDepuis".tr),
    TIMyFlightDetailModel(title:"txtQuand".tr,subTitle: "txtQuandtxtDepuis".tr),
    TIMyFlightDetailModel(title:"txtPassagers".tr,subTitle: "txtPassagerstxtDepuis".tr),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body:SingleChildScrollView(
            child: Column(
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
                  text_name: subTitle,
                  myFont: MyFont.Courier_Prime_Bold,
                  txtfontsize: MyFontSize.size13,
                  txtcolor: MyColors.textColor,
                  txtAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * .020,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left:Get.width*.06,
                      right: Get.width*.06),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: Get.width * .38,
                          height: Get.height * .050,
                          decoration: BoxDecoration(
                            color: MyColors.expantionTileBgColor,
                            borderRadius:
                            BorderRadius.all(
                                Radius.circular(Get.width * .050)),
                          ),
                          child: MyText(
                            text_name: "txtALLER".tr,
                            myFont: MyFont.Courier_Prime_Bold,
                            txtfontsize: MyFontSize.size13,
                            txtcolor: Colors.white,
                            txtAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: Get.width*.04,),
                        Container(
                          width: Get.width * .38,
                          height: Get.height * .050,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:MyColors.expantionTileBgColor,
                                  blurRadius: 2.0)
                            ],
                            border: Border.all(color: Colors.white),
                            borderRadius:
                            BorderRadius.all(Radius.circular(Get.width * .050)),
                          ),
                          child: MyText(
                            text_name: "txtRETOUR".tr,
                            myFont: MyFont.Courier_Prime_Bold,
                            txtfontsize: MyFontSize.size13,
                            txtcolor: Colors.black,
                            txtAlign: TextAlign.center,
                          ),
                        )
                      ]),
                ),
                SizedBox(
                  height: Get.height * .020,
                ),
                Container(
                    height: Get.height*.40,
                    margin: EdgeInsets.only(
                        left:Get.width*.06,
                    right: Get.width*.06),
                    child:_tabBarContentView()),

                GestureDetector(
                  onTap: (){
                    Get.to(()=>TIFlightSearchScreen(travelLougeListTitle:travelLougeListTitle,));
                  },
                  child: Container(
                    width: Get.width * .48,
                    height: Get.height * .050,
                    decoration: BoxDecoration(
                      color: MyColors.expantionTileBgColor,
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(Get.width * .050)),
                    ),
                    child: MyText(
                      text_name: "txtRechercher".tr,
                      myFont: MyFont.Courier_Prime_Bold,
                      txtfontsize: MyFontSize.size18,
                      txtcolor: Colors.white,
                      txtAlign: TextAlign.center,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }

  _tabBarContentView(){
    return ListView.builder(
        itemCount:myFlightDetailList.length,
        itemBuilder:(context,index){
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width*.70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextStart(
                          text_name:myFlightDetailList[index].title,
                          txtcolor:MyColors.expantionTileBgColor.withOpacity(0.3),
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size13,
                        ),
                        MyTextStart(
                          text_name:myFlightDetailList[index].subTitle,
                          txtcolor:MyColors.expantionTileBgColor.withOpacity(0.3),
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size13,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(left:20.0),
                    child: Image.asset(MyImageURL.plus),
                  ),

                ],
              ),
              Padding(
                padding:EdgeInsets.only(
                    right:Get.width*.02,
                    bottom: Get.height*.03),
                child: Divider(
                  height: 0.2,
                  thickness: 2,
                  color: MyColors.lineColor,
                ),
              )
            ],
          );
        });
  }
}

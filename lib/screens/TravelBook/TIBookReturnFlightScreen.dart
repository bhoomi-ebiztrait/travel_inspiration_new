import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIAvailableFlightRowWIthImage.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/MyWidget/TIReturnFlightRowWIthImage.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIAvailableFlightModel.dart';
import 'package:travel_inspiration/screens/TravelBook/TIFilterSortFlightScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TIOneWayReturnFlightCompleteScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import '../../MyWidget/MyTitlebar.dart';
import '../../MyWidget/TIMyCustomRoundedCornerButton.dart';

class TIBookReturnFlightScreen extends StatefulWidget {
  String travelogueTitle;
  TIBookReturnFlightScreen(this.travelogueTitle);
  //TIAvailableFlightModel toGoFlightSelectedModel;

 // TIBookReturnFlightScreen({this.toGoFlightSelectedModel});

  /*List<TIAvailableFlightModel> availableFlightList = [
    TIAvailableFlightModel(
        imgPath: MyImageURL.logo3x,
        fromHour: "12h55",
        toHour: "16h10",
        totalHour: "2h15",
        totalPrice: "£50",
        flightType: "Direct",
        ltn: "LTN",
        mtm: "MTM",
        perPerson: "par personne",
        flightSelected: false),
    TIAvailableFlightModel(
        imgPath: MyImageURL.logo3x,
        fromHour: "12h55",
        toHour: "16h10",
        totalHour: "2h15",
        totalPrice: "£50",
        flightType: "Direct",
        ltn: "MTM",
        mtm: "LTN",
        perPerson: "par personne",
        flightSelected: false),
    TIAvailableFlightModel(
        imgPath: MyImageURL.logo3x,
        fromHour: "12h55",
        toHour: "16h10",
        totalHour: "2h15",
        totalPrice: "£50",
        flightType: "Direct",
        ltn: "LTN",
        mtm: "MTM",
        perPerson: "par personne",
        flightSelected: false),
  ];*/

  @override
  State<TIBookReturnFlightScreen> createState() => _TIBookReturnFlightScreenState();
}

class _TIBookReturnFlightScreenState extends State<TIBookReturnFlightScreen> {
  String selectedItemImage, selectedLtnMtm;

  MyController myController = Get.put(MyController());

  @override
  void initState() {
    // TODO: implement initState
    myController.returnSelectedFlight.clear();
    myController.update();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _buildBodyContent(),
          bottomNavigationBar: _bottomButton(),

    ));
  }

  _buildBodyContent() {
   // print(".............${myController.myIntReturnList1.value[0][0].intArrivalAirportName}");
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: Get.height*0.30,
            width: Get.width,
            color: MyColors.buttonBgColorHome.withOpacity(0.7),
            child: Column(
              children: [
                MyTopHeader(
                  logoImgUrl: MyImageURL.haudos_logo,
                ),
                MyTitlebar(title: widget.travelogueTitle,),
              ],
            ),
          ),
          Container(
            height: Get.height,
            width: Get.width,
            color: MyColors.buttonBgColorHome.withOpacity(0.3),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * .03,
                ),
                Stack(
                  alignment:Alignment.centerRight,
                  children: [
                    MyText(
                      text_name: "${myController.myIntReturnList1.value[0][0].intDepartureAirportName} - ${myController.myIntReturnList1.value[0][myController.myIntReturnList1.value[0].length-1].intArrivalAirportName}",
                      myFont: MyFont.Courier_Prime_Bold,
                      txtfontsize: MyFontSize.size13,
                      txtcolor: MyColors.textColor,
                      txtAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: Get.width * .06),
                      child:GestureDetector(
                        onTap: (){
                          Get.to(TIFilterSortFlightScreen(widget.travelogueTitle));
                        },
                        child: Image.asset(MyImageURL.filter3x,height: 60,width: 60,),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
                _selectedFlightRow(),
                SizedBox(
                  height: Get.height * .020,
                ),
                Expanded(child: _bookReturnFlightWidget()),
              ],
            ),
          ),

        ],
      ),
    );
  }

  _selectedFlightRow() {
    return GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.only(left: Get.width * .08),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network("https://webapi.etravos.com${myController.onwardSelectedFlight[0].imagePath}",width: 30,height: 30,),
            /*Image.asset(
              MyImageURL.logo3x,
             // toGoFlightSelectedModel.imgPath,
              height: Get.height * .04,
              width: Get.height * .04,
              fit: BoxFit.contain,
            ),*/
            SizedBox(
              width: Get.width * .020,
            ),
            MyTextStart(
              text_name:"${myController.onwardSelectedFlight[0].departureAirportCode} - ${myController.onwardSelectedFlight[0].arrivalAirportCode}",
              // text_name: toGoFlightSelectedModel.ltn +
              //     " - " +
              //     toGoFlightSelectedModel.mtm,
              myFont: MyFont.Courier_Prime_Bold,
              txtfontsize: MyFontSize.size10,
              txtcolor: MyColors.textColor,
            ),
            Icon(
              Icons.chevron_right,
              color: MyColors.textColor,
            )
          ],
        ),
      ),
    );
  }

  _bookReturnFlightWidget() {
    return GetBuilder(
        init: MyController(),
        builder: (MyController controller) {
          return ListView.builder(
              itemCount: myController.myIntReturnList1.value != null ? myController.myIntReturnList1.value.length:0,
              itemBuilder: (context, index) {
                int i;
                return GestureDetector(
                    onTap: () {
                      myController.returnSelectedFlight.clear();
                      for(int i=0;i<myController.myIntReturnList1.value[index].length;i++){
                        myController.returnSelectedFlight.add(myController.myIntReturnList1.value[index][i]);
                      }
                      setState(() {
                        myController.setOutwardSelection(index);
                      });

                     // myController.returnSelectedFlight.value = myController.myIntReturnList1.value[index];
                      /*ScreenTransition.navigateToScreenLeft(
                        screenName: TIOneWayReturnFlightCompleteScreen()
                      );*/
                      //for single item selection in list
                      /*for (i = 0; i < availableFlightList.length; i++) {
                        if (i == index) {
                          //select item or deselect item
                          availableFlightList[i].flightSelected =
                              !availableFlightList[i].flightSelected;
                          controller.update();
                          if (availableFlightList[i].flightSelected) {
                            *//*ScreenTransition.navigateToScreenLeft(
                                screenName: TIOneWayReturnFlightCompleteScreen(
                              // toGoFlightDate: toGoFlightSelectedModel,
                              // returnFlightData: availableFlightList[index],
                            ));*//*
                          }
                          print("flight Selected: $i "
                              "${availableFlightList[i].flightSelected}");
                        } else {
                          availableFlightList[i].flightSelected = false;
                          controller.update();
                          print("flight Selected: $i "
                              "${availableFlightList[i].flightSelected}");
                        }
                      }*/
                    },
                    child: TIReturnFlightRowWIthImage(index),
                    /*TIAvailableFlightRowWithImage(i
                        *//*customFlightModel: availableFlightList[index],
                        tileColor: availableFlightList[index].flightSelected
                            ? MyColors.lightGreenColor.withOpacity(0.32)
                            : MyColors.expantionTileBgColor.withOpacity(0.32)*//*
                    )*/
                );
              });
        });
  }
  _bottomButton() {
    return Container(
      width: Get.width,
      color: MyColors.buttonBgColorHome.withOpacity(0.3),
      padding: EdgeInsets.only(bottom: 20,top:20,left: 80,right: 80),
      child: TIMyCustomRoundedCornerButton(
        onClickCallback:(){
          if(myController.returnSelectedFlight.length!= 0) {
            ScreenTransition.navigateToScreenLeft(
                screenName: TIOneWayReturnFlightCompleteScreen(
                    widget.travelogueTitle)
            );
          }
        },
        buttonWidth: Get.width*.48,
        buttonHeight: Get.height*.052,
        btnBgColor: MyColors.buttonBgColor,
        textColor:Colors.white,
        btnText:"txtValider".tr,
        fontSize: MyFontSize.size18,
        myFont: MyFont.Courier_Prime_Bold,
      ),
    );
  }
}

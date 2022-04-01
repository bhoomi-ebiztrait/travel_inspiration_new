import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/MyWidget/TIAvailableFlightRowWIthImage.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIAvailableFlightModel.dart';
import 'package:travel_inspiration/screens/TravelBook/TIBookReturnFlightScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TIFilterSortFlightScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TIOneWayReturnFlightCompleteScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import '../../MyWidget/MyCommonMethods.dart';
import '../../MyWidget/TIMyCustomRoundedCornerButton.dart';

class TIAvailableFlightScreen extends StatefulWidget {
String travelogueTitle;
  TIAvailableFlightScreen(this.travelogueTitle);

  @override
  State<TIAvailableFlightScreen> createState() => _TIAvailableFlightScreenState();
}

class _TIAvailableFlightScreenState extends State<TIAvailableFlightScreen> {
  MyController myController = Get.put(MyController());

  List chooseFlightList=[];

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _buildBodyContent(),
          bottomNavigationBar: _bottomButton(),

    ));
  }

  _buildBodyContent() {
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
                _headerTitle(),
                SizedBox(
                  height: Get.height * .04,
                ),
                MyCommonMethods.myDivider(),
               Expanded(child: _availableFlightWidget()),

              ],
            ),
          ),

        ],
      ),
    );
  }

  _headerTitle() {
    print("fsffff..........${myController.myIntOnwordsList1.value[0][myController.myIntOnwordsList1.value[0].length-1].intArrivalAirportName}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            MyText(
              //text_name: "",
             text_name: myController.myIntOnwordsList1.value.length>0 ? "${myController.myIntOnwordsList1.value[0][0].intDepartureAirportName} - ${myController.myIntOnwordsList1.value[0][myController.myIntOnwordsList1.value[0].length-1].intArrivalAirportName}":"",
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
        )

            ),
          ],
        ),
      ],
    );
  }

  _availableFlightWidget() {
    //print(myController.myIntOnwordsList.value.length);
    print("aaaaaa ${myController.myIntReturnList1.value.length }");
    return Obx((){
     // print("https://webapi.etravos.com/${myController.flightList.value[0].intOnward.flightSegments[0].imagePath}");
      return ListView.builder(
          itemCount: myController.myIntOnwordsList1.value != null ? myController.myIntOnwordsList1.value.length:0,
          itemBuilder: (context, index) {
            int i;
            return GestureDetector(
              onTap: () {
                myController.onwardSelectedFlight.clear();

                for(int i=0;i<myController.myIntOnwordsList1.value[index].length;i++){
                  myController.onwardSelectedFlight.add(myController.myIntOnwordsList1.value[index][i]);
                }

                setState(() {
                  myController.setIntOnwardSelection(index);
                });

myController.totalFare = ((myController.fareList.value[index])/(ApiParameter.ONE_POUND_VAL)).toStringAsFixed(2);


               /* ScreenTransition.navigateToScreenLeft(
                   // screenName: TIOneWayReturnFlightCompleteScreen(index
                    screenName: (myController.toGoReturnSwitch.value) ? TIOneWayReturnFlightCompleteScreen() :TIBookReturnFlightScreen()
                );*/

              },
              child: TIAvailableFlightRowWithImage(index,isSelected),
              /*TIAvailableFlightRowWithImage(
                        customFlightModel: availableFlightList[index],
                    *//*    tileColor: availableFlightList[index].flightSelected
                            ? MyColors.lightGreenColor.withOpacity(0.32)
                            : MyColors.expantionTileBgColor.withOpacity(0.32)*//*
                    )
*/                );
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
          ScreenTransition.navigateToScreenLeft(
            // screenName: TIOneWayReturnFlightCompleteScreen(index
              screenName: (myController.toGoReturnSwitch.value) ? TIOneWayReturnFlightCompleteScreen(widget.travelogueTitle) :TIBookReturnFlightScreen(widget.travelogueTitle)
          );
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

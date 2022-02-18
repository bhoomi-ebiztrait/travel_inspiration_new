import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
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

class TIAvailableFlightScreen extends StatefulWidget {


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
      bottomSheet: MyBottomLayout(
        imgUrl: MyImageURL.travel_book_bottom,
      ),
    ));
  }

  _buildBodyContent() {
    return Column(
      children: [
        MyTopHeader(
          headerName: "",
          headerImgUrl: MyImageURL.travel_book_top,
          logoImgUrl: MyImageURL.haudos_logo,
          imgHeight: Get.height * .12,
        ),
        SizedBox(
          height: Get.height * .03,
        ),
        _headerTitle(),
        SizedBox(
          height: Get.height * .02,
        ),
        Expanded(child: _availableFlightWidget())
      ],
    );
  }

  _headerTitle() {
    print("fsffff..........${myController.myIntOnwordsList1.value[0][myController.myIntOnwordsList1.value[0].length-1].intArrivalAirportName}");
    return Stack(
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
      Get.to(TIFilterSortFlightScreen());
    },
            child: Image.asset(MyImageURL.filter3x),
    )

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


                ScreenTransition.navigateToScreenLeft(
                   // screenName: TIOneWayReturnFlightCompleteScreen(index
                    screenName: (myController.toGoReturnSwitch.value) ? TIOneWayReturnFlightCompleteScreen() :TIBookReturnFlightScreen()
                );

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
}

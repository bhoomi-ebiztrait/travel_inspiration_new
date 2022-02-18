import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyCustomRoundedCornerButton.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';


class TIFilterSortFlightScreen extends StatefulWidget {


  @override
  _TIFilterSortFlightScreenState createState() => _TIFilterSortFlightScreenState();
}

class _TIFilterSortFlightScreenState extends State<TIFilterSortFlightScreen> {
  MyController _myController = Get.put(MyController());
  var scaffoldState=GlobalKey<ScaffoldState>();
  SfRangeValues srangeValues = SfRangeValues(40, 10000);

  @override
  void initState() {
 /*   _myController.myIntOnwordsList.value.clear();
    _myController.myIntReturnList.value.clear();*/
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldState,
          body:Obx(()=> _buildBodyContent())
      ),
    );


  }

 Widget _buildBodyContent(){
    return  SingleChildScrollView(
      child:Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTopHeader(
          headerName: "",
          headerImgUrl: MyImageURL.travel_book_top,
          logoImgUrl: MyImageURL.haudos_logo,
          imgHeight: Get.height*.12,
        ),
        SizedBox(
          height: Get.height * .020,
        ),

        _bodyFilterScreen(),
        SizedBox(
          height: 20,
        ),
        TIMyCustomRoundedCornerButton(
          onClickCallback:(){
          //  Get.back();
           TIPrint(tag: "Start Price", value: _myController.isStartPrice_FS.value);
           TIPrint(tag: "End Price", value: _myController.isEndPrice_FS.value);
           TIPrint(tag: "Stop", value: _myController.isStopover_FS.value.toString());
           TIPrint(tag: "Short Price", value: _myController.isShort_price_FS.value.toString());
           TIPrint(tag: "Short Duration", value: _myController.isShortDuration_FS.value.toString());
           Map<String,String> param =
           {
              "source":_myController.mSource.value,
              "destination":_myController.mDestination.value,
             "journeyDate":_myController.selectedStartDate.value,
             "returnDate":_myController.selectedEndDate.value,
             "tripType":_myController.toGoReturnSwitch.value ? "1" : "2",
             "flightType":_myController.selectedFlightType.value.value.toString(),
             "adults":_myController.noOfAdults.value.toString(),
             "children":_myController.noOfChildrens.value.toString(),
             "infants":_myController.noOfBabes.value.toString(),
             "travelClass":_myController.selectedTravelClass.value.classCode,
             "userType":"5",
             "returnDate":_myController.selectedEndDate.value,
             "startPrice":_myController.isStartPrice_FS.value,
             "endPrice":_myController.isEndPrice_FS.value,
             "shortPrice":_myController.isShort_price_FS.value.toString(),
             "shortDuration":_myController.isShortDuration_FS.value.toString(),
             "stop":_myController.isStopover_FS.value.toString()


             /*"source":"HYD",
            "destination":"DXB",
            "journeyDate":"18-01-2022",
            "tripType":"1",
            "flightType":"2",
            "adults":"1",
            "children":"1",
            "infants":"0",
            "travelClass":"E",
            "userType":"5",
            "returnDate":"22-01-2022",
           "startPrice":_myController.isStartPrice_FS.value.toString(),
           "endPrice":_myController.isEndPrice_FS.value.toString(),
           "shortPrice":_myController.isShort_price_FS.value.toString(),
             "shortDuration":_myController.isShortDuration_FS.value.toString(),
             "stop":_myController.isStopover_FS.value.toString()*/
           };

           _myController.getFlightSearch(param,true);
          },
          buttonWidth: Get.width*.6,
          buttonHeight: Get.height*.055,
          btnBgColor: MyColors.expantionTileBgColor,
          textColor:Colors.white,
          btnText:"Appliquer".tr,
          fontSize: MyFontSize.size18,
          myFont: MyFont.Courier_Prime_Bold,
        )

      ],
      ),
    );
  }

  Widget _bodyFilterScreen(){
    return Container(
      
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( "Filtrer".tr,style: _tiStyle(),),
             Image.asset(MyImageURL.sign,scale: 1,)
            ],
          ),
          Row(
            children: [
              Image.asset(MyImageURL.price_tag,scale: 1.5,),
              SizedBox(
                width: Get.width * .05,
              ),
              Text( "Prix".tr,style: TextStyle(
                fontSize: MyFontSize.size15,
                color: MyColors.textColor,
                fontFamily: MyFont.Courier_Prime_Bold,

              ),),

            ],
          ),
          Stack(
            children: [
              Positioned(
                left: 15,
                bottom: 0,
                top: 0,
                 child:Align(
                    alignment: Alignment.centerLeft,
                      child: TIthumbIcon_1()
          )
    ),
             SfRangeSlider(min: 0,
                  max: 5000000,
                  values: srangeValues,

                  activeColor: MyColors.buttonBgColor,
            /*      endThumbIcon: TIthumbIcon(),
                  startThumbIcon:TIthumbIcon(),*/
                  // enableTooltip: true,
                  // shouldAlwaysShowTooltip: true,
               //   minorTicksPerInterval: 1,
               //    tooltipShape: SfRectangularTooltipShape(),
                  onChangeStart: (SfRangeValues values){
                    _myController.isStartPrice_FS.value = values.start.toInt().toString();
                  },
                  onChangeEnd: (SfRangeValues values){
                    _myController.isEndPrice_FS.value = values.end.toInt().toString();
                  },
                  onChanged: (SfRangeValues values){
                    setState(() {
                      srangeValues = values;
                    });
                  },),

              Positioned(
                  right: 15,
                  bottom: 0,
                  top: 0,
                child:Align(
                      alignment: Alignment.centerRight,
                      child: TIthumbIcon_1())
    ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_myController.isStartPrice_FS.value,style: TextStyle(color: MyColors.lineColor,fontFamily: MyFont.Courier_Prime_Bold_Italic),),
                Text(_myController.isEndPrice_FS.value,style: TextStyle(color: MyColors.lineColor,fontFamily: MyFont.Courier_Prime_Bold_Italic)),
              ],
            ),
          ),
          SizedBox(height: 15,),
          _stopRadio(),
          SizedBox(height: 25,),
          Divider(
            color:  MyColors.lineColor,
            thickness: 2,
          ),
          SizedBox(height: 30,),
          Container(
            alignment: Alignment.centerLeft,
            child: Text( "Trier_par".tr,style: TextStyle(
              fontSize: MyFontSize.size15,
              color: MyColors.textColor,
              fontFamily: MyFont.Courier_Prime_Bold,

            ),),
          ),
          SizedBox(height: 25,),
          _sortByPrice(),
          SizedBox(height: 35,),
          _sortByDuration(),
        ],
      ),
    );
  }

  Widget TIthumbIcon(){
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2,color: MyColors.buttonBgColor),
          shape: BoxShape.circle
      ),

    );
  }

  Widget TIthumbIcon_1(){
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: MyColors.lineColor,
          shape: BoxShape.circle
      ),

    );
  }

  Widget _stopRadio(){
    return InkWell(
      onTap: (){
        _myController.isStopover_FS.value = !_myController.isStopover_FS.value;
      },
      child: Container(
        padding: EdgeInsets.only(top: 5,bottom: 5),
        child: Row(
          children: [
            _tiRadioUI(label: "avec_escale".tr,isbool: !_myController.isStopover_FS.value),
            SizedBox(width: Get.width*0.2,),
            _tiRadioUI(label: "sans_escale".tr,isbool: _myController.isStopover_FS.value),
          ],
        ),
      ),
    );
  }

  Widget _sortByPrice(){
    return GestureDetector(
      onTap: (){
        _myController.isShort_price_FS.value = !_myController.isShort_price_FS.value;
      },
      child: Container(
        padding: EdgeInsets.only(top: 5,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex:4,
             child: _tiRadioUI(label: "Prix_croissant".tr,isbool: !_myController.isShort_price_FS.value),
            ),
            Expanded(
              flex:4,
            child: _tiRadioUI(label: "Prix_décroissant".tr,isbool: _myController.isShort_price_FS.value),)

          ],
        ),
      ),
    );
  }

  Widget _sortByDuration(){
    return InkWell(
      onTap: (){
        _myController.isShortDuration_FS.value = !_myController.isShortDuration_FS.value;
      },
      child: Container(
        padding: EdgeInsets.only(top: 5,bottom: 5),
        child: Row(
          children: [
            _tiRadioUI(label: "Courte_durée".tr,isbool: !_myController.isShortDuration_FS.value),
            SizedBox(width: Get.width*0.05,),
            _tiRadioUI(label: "Longue_durée".tr,isbool: _myController.isShortDuration_FS.value),
          ],
        ),
      ),
    );
  }

  Widget _tiRadioUI({@required var label, @required var isbool}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: isbool?MyColors.lineColor:Colors.white,
              border: Border.all(width: 2,color: isbool?MyColors.lineColor:MyColors.buttonBgColor),
              shape: BoxShape.circle
          ),

        ),
        SizedBox(width: 5,),

        Text( label,style: _tiStyle(),),

      ],
    );
  }

  TextStyle _tiStyle(){
    return TextStyle(
      fontSize: MyFontSize.size15,
      color: MyColors.textColor,
      fontFamily: MyFont.Courier_Prime_Bold,

    );
  }

}

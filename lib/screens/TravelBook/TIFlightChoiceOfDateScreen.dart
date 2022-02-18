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
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';



class TIFlightChoiceOfDateScreen extends StatefulWidget {

  @override
  _TIFlightChoiceOfDateScreenState createState() => _TIFlightChoiceOfDateScreenState();
}

class _TIFlightChoiceOfDateScreenState extends State<TIFlightChoiceOfDateScreen> {
  var scaffoldState=GlobalKey<ScaffoldState>();
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  MyController myController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
             key: scaffoldState,
             body:_buildBodyContent()
      ),
    );


  }

  _buildBodyContent(){
    return  Column(
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
        MyText(
          text_name: "txtChoixdesdates".tr + "  :",
          myFont: MyFont.Courier_Prime_Bold,
          txtfontsize: MyFontSize.size13,
          txtcolor: MyColors.textColor,
          txtAlign: TextAlign.center,
        ),
        SizedBox(height: Get.height * .020,),
        _buildGotoReturnWidget(),
        SizedBox(
          height: Get.height * .020,
        ),
        _calenderWidget(),

        SizedBox(
          height: Get.height * .10,
        ),
        TIMyCustomRoundedCornerButton(
          onClickCallback:(){

            Get.back(result: _range != "" ? _range : _selectedDate );
          },
          buttonWidth: Get.width*.48,
          buttonHeight: Get.height*.050,
          btnBgColor: MyColors.expantionTileBgColor,
          textColor:Colors.white,
          btnText:"txtValider".tr,
          fontSize: MyFontSize.size18,
          myFont: MyFont.Courier_Prime_Bold,
        )

      ],
    );
  }

  _buildGotoReturnWidget(){
    return Container(
      height: Get.height*.06,
      color: MyColors.expantionTileBgColor.withOpacity(0.32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:[
          MyText(
            text_name: "txtALLER".tr,
            myFont: MyFont.Courier_Prime_Bold,
            txtfontsize: MyFontSize.size13,
            txtcolor: MyColors.textColor,
            txtAlign: TextAlign.center,
          ),
          MyText(
            text_name: "txtRETOUR".tr,
            myFont: MyFont.Courier_Prime_Bold,
            txtfontsize: MyFontSize.size13,
            txtcolor: MyColors.textColor,
            txtAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  _calenderWidget(){
    return Container(
      margin:EdgeInsets.only(left: Get.width*.030,
          right: Get.width*.030),
      child:buildRangePicker(),
    );
  }

   buildRangePicker() {
    return SfDateRangePicker(
        onSelectionChanged:_onSelectionChanged,
        selectionMode:myController.toGoReturnSwitch.value ? DateRangePickerSelectionMode.single : DateRangePickerSelectionMode.range,
        monthViewSettings:DateRangePickerMonthViewSettings(
          firstDayOfWeek: 1,
        ),
        //selectionRadius: 20,
       endRangeSelectionColor: MyColors.lineColor,
        startRangeSelectionColor:MyColors.lineColor,
        rangeSelectionColor: MyColors.lineColor.withOpacity(0.3),
        selectionTextStyle: TextStyle(
            color: MyColors.textColor
        ),
        //view: DateRangePickerView.year,
        selectionShape:DateRangePickerSelectionShape.rectangle
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {

    setState(() {
      if (args.value is PickerDateRange) {
        _range = DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
        myController.selectedStartDate.value = DateFormat('dd-MM-yyyy').format(args.value.startDate).toString();
        myController.selectedEndDate.value = DateFormat('dd-MM-yyyy')
            .format(args.value.endDate ?? args.value.startDate)
            .toString();
        print("Range date:$_range");
      } else if (args.value is DateTime) {
        _selectedDate = DateFormat('dd/MM/yyyy').format(args.value).toString();
        myController.selectedStartDate.value = DateFormat('dd-MM-yyyy').format(args.value).toString();
        print("Selected date:$_selectedDate");
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
        print("DateCount:$_dateCount");
      } else {
        _rangeCount = args.value.length.toString();
        print("RangeCount:$_rangeCount");
      }
    });
  }
}

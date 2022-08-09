import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
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
  String travelLougeListTitle;

  TIFlightChoiceOfDateScreen(this.travelLougeListTitle);

  @override
  _TIFlightChoiceOfDateScreenState createState() =>
      _TIFlightChoiceOfDateScreenState();
}

class _TIFlightChoiceOfDateScreenState
    extends State<TIFlightChoiceOfDateScreen> {
  var scaffoldState = GlobalKey<ScaffoldState>();
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(key: scaffoldState, body: _buildBodyContent()),
    );
  }

  _buildBodyContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: Get.height * 0.30,
            width: Get.width,
            color: MyColors.buttonBgColorHome.withOpacity(0.7),
            child: Column(
              children: [
                MyTopHeader(
                  logoImgUrl: MyImageURL.haudos_logo,
                ),
                MyTitlebar(
                  title: widget.travelLougeListTitle,
                ),
                Spacer(),
                MyText(
                  text_name: "txtChoixdesdates".tr + ":",
                  myFont: MyFont.Courier_Prime_Bold,
                  txtfontsize: MyFontSize.size15,
                  txtcolor: MyColors.textColor,
                  txtAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * .020,
                ),
              ],
            ),
          ),
          Container(
            height: Get.height,
            width: Get.width,
            color: MyColors.buttonBgColorHome.withOpacity(0.30),
            child: Column(
              children: [
                // _buildGotoReturnWidget(),
                SizedBox(
                  height: Get.height * .020,
                ),
                _calenderWidget(),

                SizedBox(
                  height: Get.height * .10,
                ),
                TIMyCustomRoundedCornerButton(
                  onClickCallback: () {
                    Get.back(result: _range != "" ? _range : _selectedDate);
                  },
                  buttonWidth: Get.width * .48,
                  buttonHeight: Get.height * .050,
                  btnBgColor: MyColors.buttonBgColor,
                  textColor: Colors.white,
                  btnText: "txtValider".tr,
                  fontSize: MyFontSize.size18,
                  myFont: MyFont.Courier_Prime_Bold,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildGotoReturnWidget() {
    return Container(
      height: Get.height * .07,
      color: MyColors.buttonBgColorHome.withOpacity(0.32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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

  _calenderWidget() {
    return Container(
      margin: EdgeInsets.only(left: Get.width * .030, right: Get.width * .030),
      child: buildRangePicker(),
    );
  }

  buildRangePicker() {
    return SfDateRangePicker(
        onSelectionChanged: _onSelectionChanged,
        selectionMode: myController.toGoReturnSwitch.value
            ? DateRangePickerSelectionMode.single
            : DateRangePickerSelectionMode.range,
        monthViewSettings: DateRangePickerMonthViewSettings(
          firstDayOfWeek: 1,
        ),
        //selectionRadius: 20,
        endRangeSelectionColor: MyColors.buttonBgColor,
        startRangeSelectionColor: MyColors.buttonBgColor,
        rangeSelectionColor: MyColors.buttonBgColor.withOpacity(0.3),
        selectionTextStyle:
            TextStyle(color: MyColors.textColor, fontWeight: FontWeight.bold),
        selectionColor: MyColors.buttonBgColor,
        //view: DateRangePickerView.year,
        selectionShape: DateRangePickerSelectionShape.circle);
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
        myController.selectedStartDate.value =
            DateFormat('dd-MM-yyyy').format(args.value.startDate).toString();
        myController.selectedEndDate.value = DateFormat('dd-MM-yyyy')
            .format(args.value.endDate ?? args.value.startDate)
            .toString();
        print("Range date:$_range");
      } else if (args.value is DateTime) {
        _selectedDate = DateFormat('dd/MM/yyyy').format(args.value).toString();
        myController.selectedStartDate.value =
            DateFormat('dd-MM-yyyy').format(args.value).toString();
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

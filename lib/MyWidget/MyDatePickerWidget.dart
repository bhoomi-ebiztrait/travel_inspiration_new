import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

import '../utils/MyStrings.dart';
import 'MyButton.dart';

class MyDatePickerWidget extends StatefulWidget {
  String title;

  MyDatePickerWidget({this.title});

  @override
  _MyDatePickerWidgetState createState() => _MyDatePickerWidgetState();
}

class _MyDatePickerWidgetState extends State<MyDatePickerWidget> {
  String selectedDate;
  String selectedMonth;
  String selectedYear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: Column(
        children: [
          MyText(
            text_name: widget.title,
            txtfontsize: MyFontSize.size13,
            myFont: MyStrings.courier_prime_bold,
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyButtonSmall(
                btn_name: selectedDate != null ? selectedDate : "date".tr,
                txtcolor: MyColors.textColor,
                onClick: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          title: Text(""),
                          content: Container(
                            color: Colors.white,
                            height: 350,
                            width: Get.width,
                            child: SfDateRangePicker(),
                          ),
                        );
                      });
                  print("clickeddd");
                },
                /*onClick: ()async{

                 var result = await MyCommonMethods.showDateDialog(selectedDate);
                print("resultt: $result");
                setState(() {
                  if(result != null){
                    selectedDate = result.toString();
                  }
                });}*/
              ),
              MyButtonSmall(
                btn_name:
                    selectedMonth != null ? selectedMonth : "month".tr,
                txtcolor: MyColors.textColor,
                onClick: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          title: Text(""),
                          content: Container(
                            color: Colors.white,
                            height: 350,
                            width: Get.width,
                            child: SfDateRangePicker(
                              view: DateRangePickerView.year,
                            ),
                          ),
                        );
                      });
                  print("clickeddd");
                },
              /*  onClick: () async {
                  var result =
                      await MyCommonMethods.showMonthDialog(selectedMonth);
                  print("resultt: $result");
                  setState(() {
                    if (result != null) {
                      selectedMonth = result.toString();
                    }
                  });
                },*/
              ),
              MyButtonSmall(
                btn_name: selectedYear != null ? selectedYear : "year".tr,
                txtcolor: MyColors.textColor,
                onClick: () async {
                  var result =
                      await MyCommonMethods.showYearDialog(selectedYear);
                  print("resultt: $result");
                  setState(() {
                    if (result != null) {
                      selectedYear = result.toString();
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

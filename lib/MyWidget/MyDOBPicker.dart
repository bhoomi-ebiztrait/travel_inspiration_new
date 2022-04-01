import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';

import '../utils/MyColors.dart';
import '../utils/MyStrings.dart';
import 'MyText.dart';
import 'MyTextFieldWithImage.dart';

class MyDOBPicker extends StatefulWidget {
  DateTime minDate;
  DateTime maxDate;

  MyDOBPicker({this.minDate,this.maxDate});

  @override
  _MyDOBPickerState createState() => _MyDOBPickerState();
}

class _MyDOBPickerState extends State<MyDOBPicker> {

  final DateRangePickerController _controller = DateRangePickerController();
  MyController dateController = Get.put(MyController());

  DateTime myselectedDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(dateController.selectedDate.value!= "" && dateController.selectedDate.value!= "null") {
      myselectedDate =
          CommonMethod.convertStringToDate((dateController.selectedDate.value));
      _controller.displayDate =
          CommonMethod.convertStringToDate((dateController.selectedDate.value));

    }

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getDateDialog(context,widget.minDate,widget.maxDate);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: Container(
          width: Get.width,
          height: 55,
          // width: Get.width*0.2,

          decoration: BoxDecoration(
              color: MyColors.whiteColor.withOpacity(1),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: MyColors.dialog_shadowColor,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                )
              ]),
          child: MyText(
            text_name: dateController.selectedDate.value != ""
                ? dateController.selectedDate.value
                : "Date".tr,
            txtcolor: MyColors.textColor.withOpacity(1.0),
            txtfontsize: MyFontSize.size13,
          ),
        ),
      ),
    );
  }

  getDateDialog(context,myMinDate,myMaxDate){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),side: BorderSide.none),
            elevation: 0,
            child: Container(
              height: 255,
              width: 255,
              // width: Get.width*0.7,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: MyColors.whiteColor.withOpacity(1),
                  border: Border.all(color: MyColors.dateColor,width: 2),
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(color: MyColors.dialog_shadowColor,
                        blurRadius: 2
                    ),
                  ]
              ),
              child: SfDateRangePicker(
                controller: _controller,
                view: DateRangePickerView.decade,
                minDate: myMinDate,
                maxDate: myMaxDate,
                // initialDisplayDate: DateTime.now(),
                initialSelectedDate: DateTime.now(),
                // initialSelectedDate: myselectedDate,
                selectionColor: MyColors.lightGreenColor,
                selectionTextStyle: TextStyle(color: MyColors.textColor,fontWeight: FontWeight.bold),
                selectionRadius: 22,
                onSelectionChanged: (args){
                  // selectedDate = args.value;
                  print("valueSele::: ${args.value.toString()}");
                  print("value::: ${args.value}");


                  if(SchedulerBinding.instance != null){
                    SchedulerBinding.instance.addPostFrameCallback((duration) {
                       setState(() {
                      dateController.selectedDate.value=CommonMethod.convertDateToString(args.value);
                      // mController.text = DateFormat('dd-MM-yyyy').format(args.value);
                      Get.back();
                    });
                    });
                  }
                  // mController.text = args.value;

                },
              ),
            ),
          );
        });
  }




}

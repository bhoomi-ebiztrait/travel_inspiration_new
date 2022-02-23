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
import 'MyCommonMethods.dart';
import 'MyText.dart';
import 'MyTextFieldWithImage.dart';

class MyPickPicker extends StatefulWidget {
  DateTime minDate;
  DateTime maxDate;

  MyPickPicker({this.minDate,this.maxDate});

  @override
  _MyPickPickerState createState() => _MyPickPickerState();
}

class _MyPickPickerState extends State<MyPickPicker> {

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
        padding: const EdgeInsets.symmetric(horizontal: 65.0),
        child: Container(
          width: Get.width,
          height: 45,
          // width: Get.width*0.2,

          decoration: BoxDecoration(
              color: MyColors.whiteColor.withOpacity(1),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(15)),
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
            txtfontsize: MyFontSize.size15,
            myFont: MyStrings.courier_prime,
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

class MyDestinationPicker extends StatefulWidget {

  DateTime maxDate;
  String msg;

  MyDestinationPicker({this.maxDate,this.msg});

  @override
  _MyDestinationPickerState createState() => _MyDestinationPickerState();
}

class _MyDestinationPickerState extends State<MyDestinationPicker> {

  final DateRangePickerController _controller = DateRangePickerController();
  MyController dateController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(dateController.selectedDate.value != ""){
print("${dateController.selectedDate.value}");
          DateTime minDate = CommonMethod.convertStringToDate(dateController.selectedDate.value);
          getDateDialog(context,minDate,widget.maxDate);
        }else{
          return MyCommonMethods.showInfoCenterDialog(
              msgContent: widget.msg,
              myFont: MyStrings.courier_prime_bold);
        }

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 65.0),
        child: Container(
          width: Get.width,
          height: 45,
          // width: Get.width*0.2,

          decoration: BoxDecoration(
              color: MyColors.whiteColor.withOpacity(1),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: MyColors.dialog_shadowColor,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                )
              ]),
          child: MyText(
            text_name: dateController.selectedDestinationDate.value != ""
                ? dateController.selectedDestinationDate.value
                : "Date".tr,
            txtcolor: MyColors.textColor.withOpacity(1.0),
            txtfontsize: MyFontSize.size15,
            myFont: MyStrings.courier_prime,
          ),
        ),
      ),
    );
    /*return MyTextFieldWithImage(
      // imageUrl: MyImageURL.user_img,
      onTap: (){
        getDateDialog(context);
      },
      addlabel: MyStrings.date_of_birth,
      readonly: true,
      labelColor: MyColors.textColor,
      edinputType: TextInputType.name,
      obscureText: false,
      mycontroller: mController,

    );*/
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
                initialSelectedDate: DateTime.now(),
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
                      dateController.selectedDestinationDate.value=CommonMethod.convertDateToString(args.value);
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

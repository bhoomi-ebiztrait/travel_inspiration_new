import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/Models/FlightType.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class MyFlightTypeDropdown extends StatefulWidget {
  @override
  final VoidCallback onTap;

  final FormFieldValidator<String> validator;

  MyFlightTypeDropdown({this.onTap, this.validator});

  MyFlightTypeDropdownState createState() => MyFlightTypeDropdownState();
}

class MyFlightTypeDropdownState extends State<MyFlightTypeDropdown> {
 MyController myController = Get.put(MyController());
 FlightType selectedFlight;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.selectedFlightType.value = selectedFlight;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        child: DropdownButtonFormField<FlightType>(
          decoration: dropdowndecoration(),
          items: MyStrings.flightType.map((mFlight) {
            return DropdownMenuItem(
              child: new MyText(
                text_name: mFlight.type,
                txtcolor:  MyColors.expantionTileBgColor.withOpacity(1.0),
                txtfontsize: MyFontSize.size12,
                myFont: MyFont.Courier_Prime,
              ),
              value: mFlight,
            );
          }).toList(),

          //  validator: (value)=> value == null ? "please select value" : null,
          value: myController.selectedFlightType.value,
          isExpanded: false,

          /*hint: Container(
            child: MyText(
                text_name : MyStrings.country,
              txtcolor: MyColors.textColor,
               txtfontsize: MyFontSize.size13,)
            ),*/
          onChanged: (value) {
            setState(() {
              myController.selectedFlightType.value = value;
            });
          },
        ),
      ),
    );
  }

  dropdowndecoration()
  {
    return InputDecoration(
      fillColor: MyColors.whiteColor,
      filled: true,
      labelText: "Flight type",
      labelStyle: TextStyle(color:MyColors.expantionTileBgColor.withOpacity(1.0),fontFamily: MyFont.Courier_Prime,fontSize: MyFontSize.size15),
      contentPadding: const EdgeInsets.only(left: 5,right: 10),
      // enabledBorder: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.lineColor,width: 2)),

    );
  }


}

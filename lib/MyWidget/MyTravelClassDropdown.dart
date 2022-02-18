import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/Models/TravelClass.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class MyTravelClassDropdown extends StatefulWidget {
  @override
  final VoidCallback onTap;

  final FormFieldValidator<String> validator;

  MyTravelClassDropdown({this.onTap, this.validator});

  MyTravelClassDropdownState createState() => MyTravelClassDropdownState();
}

class MyTravelClassDropdownState extends State<MyTravelClassDropdown> {
  MyController myController = Get.put(MyController());
  TravelClass selectedTravelClass;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.selectedTravelClass.value = selectedTravelClass;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        child: DropdownButtonFormField<TravelClass>(
          decoration: dropdowndecoration(),
          items: MyStrings.classType.map((mClass) {
            return DropdownMenuItem(
              child: new MyText(
                text_name: mClass.className,
                txtcolor:  MyColors.expantionTileBgColor.withOpacity(1.0),
                txtfontsize: MyFontSize.size12,
                myFont: MyFont.Courier_Prime,
              ),
              value: mClass,
            );
          }).toList(),

          //  validator: (value)=> value == null ? "please select value" : null,
          value: myController.selectedTravelClass.value,
          isExpanded: false,

          /*hint: Container(
            child: MyText(
                text_name : MyStrings.country,
              txtcolor: MyColors.textColor,
               txtfontsize: MyFontSize.size13,)
            ),*/
          onChanged: (value) {
            setState(() {
              myController.selectedTravelClass.value = value;
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
      labelText: "Class",
      labelStyle: TextStyle(color:MyColors.expantionTileBgColor.withOpacity(1.0),fontFamily: MyFont.Courier_Prime,fontSize: MyFontSize.size15),
      contentPadding: const EdgeInsets.only(left: 5,right: 10),
      // enabledBorder: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.lineColor,width: 2)),

    );
  }


}

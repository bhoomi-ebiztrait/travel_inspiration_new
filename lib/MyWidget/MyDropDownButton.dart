import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';

class MyDropDownButton extends StatelessWidget {

  String selectedDestination;
  List<DropdownMenuItem> destinationList;
  Function onChanged;

  MyDropDownButton({this.selectedDestination,
  this.destinationList,this.onChanged});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: Get.width,
      color:MyColors.expantionTileBgColor.withOpacity(0.32),
      padding: EdgeInsets.only(
        right: Get.height * .040,
        left: Get.height * .040,
      ),
      child:DropdownButton(
        items:destinationList,
        onChanged:(destination){
          onChanged(destination);
        },
       selectedItemBuilder: (context){
          return destinationList;
       },
        isExpanded:true,
        icon:Image.asset(MyImageURL.arrow_dropdown_down,
          height: Get.height * .040,
          width: Get.height * .040,
          fit: BoxFit.fill,
        ),
        value: selectedDestination,

      )
    );
  }
}

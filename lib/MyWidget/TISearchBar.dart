import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';

class TISearchBar extends StatelessWidget {
  TextFormField textFormField;

  TISearchBar({this.textFormField});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Get.height*.050,
        width: Get.width*.85,
        decoration: BoxDecoration(
            border: Border.all(
              color: MyColors.searchBorderColor,
            ),
            borderRadius:BorderRadius.all(Radius.circular(Get.width*.060))
        ),
        child:Align(
          alignment: Alignment.centerLeft,
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(bottom:Get.height*.012),
                  width:Get.width*.70,
                  child:textFormField

              ),
              Image.asset(MyImageURL.search_icon,
                height: Get.height*.025,
                width: Get.height*.025,
                fit: BoxFit.fill
                ,
              ),
            ],
          ),
        )

      ),
    );
  }
}

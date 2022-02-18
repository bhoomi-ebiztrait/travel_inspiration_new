import 'package:flutter/material.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:get/get.dart';

class TINoRecordFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MyText(
      text_name: "txtNoRecordFound".tr,
      myFont: MyFont.Courier_Prime,
      txtcolor: MyColors.textColor,
      txtfontsize: MyFontSize.size15,
    );
  }
}

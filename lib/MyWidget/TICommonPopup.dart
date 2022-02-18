import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';

class TICommonPopup extends StatelessWidget {

  Widget childWidget;
  TICommonPopup({this.childWidget});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Get.height * .74,
        width: Get.width * .80,
        margin:EdgeInsets.only(top: Get.height * .15),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(Get.width * .08))
          ),
          child:childWidget,
        ),
      ),
    );
  }
}

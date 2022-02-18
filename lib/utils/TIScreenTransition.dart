import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ScreenTransition {

  static navigateToScreenLeft({Widget screenName}) {
    Get.to(screenName, transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 500));
  }

  static void navigateOff({Widget screenName}) {
    Get.off(screenName,
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 500));
  }

  static void navigateOffAll({Widget screenName}) {
    Get.offAll(screenName,
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 500));
  }
}
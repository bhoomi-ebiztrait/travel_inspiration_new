import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'MyColors.dart';

class MyUtility{

  static Widget showErrorMsg(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:MyColors.redColor,
      textColor:MyColors.whiteColor,
      fontSize: 16.0,
    );
  }

  static Widget showSuccessMsg(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:MyColors.lightGreenColor,
      textColor:MyColors.textColor,
      fontSize: 16.0,
    );
    // Get.snackbar("Success", msg, backgroundColor: MyColors.btngradianttop,
    //     colorText: MyColors.textBoxColor,
    //     snackPosition: SnackPosition.BOTTOM,
    //     duration: Duration(seconds: 3));
  }

  focusOut(context) {
    return FocusScope.of(context).requestFocus(new FocusNode());
  }
}
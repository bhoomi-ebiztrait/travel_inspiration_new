import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class MyValidatorController extends GetxController{


  ///////////////////// validation functions ////////////////////////////////


  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "emailreq".tr;
    } else {
      if (!regex.hasMatch(value))
        return "emailvalid".tr;
      else
        return null;
    }
  }
  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  String validateLoginPassword(String value) {
    if (value == null || value.isEmpty) {
      return "passwordreq".tr;
    }
    return null;
  }

  String validatePassword(String value) {
    if (value == null || value.isEmpty) {
      return "passwordreq".tr;
    } else if (!validateStructure(value)) {
      return "passwordreqvalid".tr;
    }
    return null;
  }
  String validateOldPassword(String value) {
    if (value == null || value.isEmpty) {
      return "passwordreqOld".tr;
    }
    /*else if (value.length < 8) {
      return "passwordreqvalid".tr;
    }*/
    return null;
  }
  String validateNewPassword(String value) {
    if (value == null || value.isEmpty) {
      return "passwordreqNew".tr;
    } else if (value.length < 8) {
      return "passwordreqvalid".tr;
    }
    return null;
  }
  String validateDateofBirth(String value) {
    String d= DateFormat('MM-dd-yyyy').format(DateTime.now());
    if (value == null || value.isEmpty) {
      return "dateofBirthreq".tr;
    }
    else {
      return null;
    }
  }
  String validateName(String value) {
    if (value == null || value.isEmpty) {
      return "validName".tr;
    }
    else {
      return null;
    }
  }
  String validateAddress(String value) {
    if (value == null || value.isEmpty) {
      return "validAddress".tr;
    }
    else {
      return null;
    }
  }
  String validatePostalCode(String value) {
    if (value == null || value.isEmpty) {
      return "validCodePostal".tr;
    }
    else {
      return null;
    }
  }
  String validateCity(String value) {
    if (value == null || value.isEmpty) {
      return "validCity".tr;
    }
    else {
      return null;
    }
  }
  String validatePhoneNo(String value) {
    // if (value == null || value.isEmpty) {
    //   return "validPhoneNo".tr;
    // }
    // else {
      return null;
    // }
  }
  String validateProjName(String value) {
    if (value == null || value.isEmpty) {
      return "validProjName".tr;
    }
    else {
      return null;
    }
  }

}
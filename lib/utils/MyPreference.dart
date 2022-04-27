import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';

class MyPreference{
  static String APPMODE="APPMODE";
  static String pageVal="pageValue";
  static  String accessToken = "accessToken";
  static  String deviceToken = "deviceToken";
  static String userId = "userId";
  static String emailId = "emailId";
  static String dob = "dob";
  static String country = "country";
  static String address = "address";
  static String phoneNumber = "phoneNumber";
  static String city = "city";
  static String pinCode = "pinCode";
  static String startLat = "startLat";
  static String startLng = "startLng";
  static String isProfile = "isProfile";
  static String language_code = "lan_code";
  static String country_code = "country_code";



  static SharedPreferences sharedPreferences;

  static void setPrefStringValue({@required String key,@required String value}){
    TIPrint(tag:key,value:value);
    sharedPreferences.setString(key, value);
  }

  static String getPrefStringValue({@required String key}){
    return sharedPreferences.getString(key);
  }

  static void setPrefIntValue({@required String key,@required int value}){
    TIPrint(tag:key,value:value.toString());
    sharedPreferences.setInt(key,value);
  }
  static int getPrefIntValue({@required String key}){
    TIPrint(tag:"KEY",value:key);
    return sharedPreferences.getInt(key);
  }

  static void setPrefDoubleValue({@required String key,@required double value}){
    TIPrint(tag:key,value:value.toString());
    sharedPreferences.setDouble(key,value);
  }
  static double getPrefDoubleValue({@required String key}){
    TIPrint(tag:"KEY",value:key);
    return sharedPreferences.getDouble(key);
  }


  static  Future clearPref() async {
    TIPrint(tag:"Pref",value: "Clear()");
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    //await sharedPreferences.remove(APPMODE);
    // await sharedPreferences.remove(accessToken);


  }
}
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/Models/PlaceDetails.dart';
import 'package:travel_inspiration/screens/InspiredMode/InspredModeScreen.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeScreen.dart';
import 'package:travel_inspiration/services/GeoLocationService/AskForPermission.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'MyColors.dart';
class CommonMethod{

  static const String reflective_mode = "reflective_mode";
  static const String inspired_mode = "inspired_mode";
  static const String vacation = "vacation";

 static void getAppMode(){
    TIPrint(tag:"App Mode:",
        value:
        MyPreference.getPrefIntValue(key:MyPreference.APPMODE).toString());
    if(MyPreference.getPrefIntValue(key:MyPreference.APPMODE)==0){
      ScreenTransition.navigateOffAll(screenName:InspredModeScreen());
    }else{
      ScreenTransition.navigateOffAll(screenName:ReflectModeScreen());
    }
  }

  static DateTime convertStringToDate(String mDateStr){
   // return DateFormat('dd-MM-yyyy').parse((mDateStr));
   return DateFormat('yyyy-MM-dd').parse((mDateStr));
  }

  static String convertDateToString(DateTime mdate){
   return DateFormat('yyyy-MM-dd').format(mdate);
   // return DateFormat('dd-MM-yyyy').format(mdate);
  }
}


Future<bool> isConnected() async {
  try {
    String url = "https://www.google.com/";
    //Response response = await get(url);

    final response = await get(Uri.parse(url));

    int statusCode = response.statusCode;
    if (statusCode == 200) {
      return true;
    } else {
      //navigateToNoInternet(context);
      return true;
    }
  } on SocketException catch (_) {

    // dialog(txtInternetConnection);
    //Get.back();

    return false;
  } catch (val) {
    /*   Fluttertoast.showToast(
        msg: "Please Check Your Internet Connection",
        toastLength: Toast.LENGTH_LONG);*/
    return false;
  }
}

Future<Position> determineCurrentPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    AskForPermission askPermisssion = AskForPermission();
    askPermisssion.requestLocationPermission();
    // return Future.error('Location services are disabled.');

  }


  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

double calculateDistance(double lat2, double lon2) {

  double lat1 =
  MyPreference.getPrefDoubleValue(key: MyPreference.startLat);
  double lon1 =
  MyPreference.getPrefDoubleValue(key: MyPreference.startLng);

  print("lat1..$lat1");
  print("lon1..$lon1");
  print("lat2..$lat2");
  print("lon2..$lon2");
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) *  (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

searchNearByPlaces(latitude,longitude,types,radious,next_page_token) async{
  // var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
  //     "location=22.9999068,72.5947069&radius=50000&types=city&sensor=true&key=AIzaSyBRNil_iYmWUTUysdN_CU7KgDmv-ramMcM";
 // radious in meters
  String url =
      '${ApiParameter.GooglePlaceURL}?key=${ApiParameter.GOOGLE_API_KEY}&location=$latitude,$longitude&radius=$radious&types=$types&sensor=true&pagetoken=$next_page_token';
  print(url);
  var url1 = Uri.parse(url);
  final response = await http.get(url1);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print(data);
    return data;
  } else {
    throw Exception('An error occurred getting places nearby');
  }
}


searchNearByHotels(latitude,longitude,types,keyword,radious, next_page_token) async{
  // var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
  //     "location=22.9999068,72.5947069&radius=50000&types=city&sensor=true&key=AIzaSyBRNil_iYmWUTUysdN_CU7KgDmv-ramMcM";
  // radious in meters
  String url =
      '${ApiParameter.GooglePlaceURL}?key=${ApiParameter.GOOGLE_API_KEY}&location=$latitude,$longitude&radius=$radious&types=$types&keyword=$keyword&sensor=true&pagetoken=$next_page_token';
  print(url);
  var url1 = Uri.parse(url);
  final response = await http.get(url1);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print("tokeee : ${data['next_page_token']}");

    return data;
  } else {
    throw Exception('An error occurred getting places nearby');
  }
}

googlegGetDistance(originLat,originLng,desLat,destLng) async{
  //https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=40.6655101,-73.89188969999998&destinations=40.6905615%2C,-73.9976592&key=YOUR_API_KEY
  String url =
      '${ApiParameter.GoogleDistanceURL}?key=${ApiParameter.GOOGLE_API_KEY}&origins=$originLat,$originLng&destinations=$desLat,$destLng';
  print(url);
  var url1 = Uri.parse(url);
  final response = await http.get(url1);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    // String wayPoints = data["routes"][0]["overview_polyline"]["points"];
    print("res ${data.toString()}");

    return data;
  } else {
    throw Exception('An error occurred getting places nearby');
  }
}

getPlaceDetailsByPlaceId(place_id) async{
  //https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJI18JomGEXjkR6spwQiQrJ8o&key=AIzaSyBRNil_iYmWUTUysdN_CU7KgDmv-ramM

  String url =
      '${ApiParameter.GooglePlaceDetailsURL}?key=${ApiParameter.GOOGLE_API_KEY}&place_id=$place_id';
  print(url);
  var url1 = Uri.parse(url);
  final response = await http.get(url1);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    PlaceDetails mPlace = PlaceDetails();
    if(data != null){
      mPlace = PlaceDetails.fromJson(data);
    }
    print(data);

    return mPlace;
  } else {
    throw Exception('An error occurred getting places nearby');
  }
}

getPhotoImage(photo_ref){

  return "${ApiParameter.GooglePlacePhotosURL}?key=${ApiParameter.GOOGLE_API_KEY}&maxwidth=200&photo_reference=$photo_ref";
}





getDeviceToken ()async{
  FirebaseMessaging.instance.getToken().then((token){
      print("device token $token");
     MyPreference.setPrefStringValue(key: MyPreference.deviceToken,
         value: token);
  });

  // final user = await FirebaseAuth.instance.currentUser;
  // final token = await user.getIdToken();
  // print("device token $token");
  // MyPreference.setPrefStringValue(key: MyPreference.deviceToken, value: token);
  // // final token = idToken.g;
}
/*getDeviceToken () async{
  final user = await FirebaseAuth.instance.currentUser;
  if(user != null) {
    final token = await user.getIdToken();
    print("device token $token");
    MyPreference.setPrefStringValue(
        key: MyPreference.deviceToken, value: token);
    return token;
  }
  // final token = idToken.g;
}*/

Future<String> tiCalendarDialog({context,myMinDate,myMaxDate})async{

  final result =  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),side: BorderSide.none),
          elevation: 0,
          child: Container(
            height: 255,
            width: 255,
            // width: Get.width*0.7,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: MyColors.whiteColor.withOpacity(1),
                border: Border.all(color: MyColors.dateColor,width: 2),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(color: MyColors.dialog_shadowColor,
                      blurRadius: 2
                  ),
                ]
            ),
            child: SfDateRangePicker(
             // controller: _controller,
              view: DateRangePickerView.decade,
              minDate: myMinDate,
              maxDate: myMaxDate,
              // initialDisplayDate: DateTime.now(),
              initialSelectedDate: DateTime.now(),
              // initialSelectedDate: myselectedDate,
              selectionColor: MyColors.lightGreenColor,
              selectionTextStyle: TextStyle(color: MyColors.textColor,fontWeight: FontWeight.bold),
              selectionRadius: 22,
              onSelectionChanged: (args){
                print("valueSele::: ${args.value.toString()}");
                print("value::: ${args.value}");
                Get.back(result: args.value.toString());

              },
            ),
          ),
        );
      });

    return result;
}

String convertStringToDate({String sDate,String dateFormate}){
  DateTime parseDate = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(sDate);
  var inputDate = DateTime.parse(parseDate.toString());
  //var outputFormat = DateFormat('MM/dd/yyyy');
  var outputFormat = DateFormat(dateFormate);
  var outputDate = outputFormat.format(inputDate);
  print(outputDate);
  return outputDate;
}

String CheckEmptyvalue({String value,String errormsg}) {
  //
  if (value.isEmpty) {
    return errormsg;
  }
  return null;
}
focusOut(context) {
  return FocusScope.of(context).requestFocus(new FocusNode());
}

getIATACode(lat,long) async
{
    String url =
        '${ApiParameter.getIATAcode}$lat/$long';
    print(url);
    var url1 = Uri.parse(url);
    final response = await http.get(url1);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // String wayPoints = data["routes"][0]["overview_polyline"]["points"];
      print("res ${data.toString()}");

      return data;
    } else {
      throw Exception('An error occurred getting places nearby');
    }
}



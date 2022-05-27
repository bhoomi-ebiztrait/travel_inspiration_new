import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiCall.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/APICallServices/MyResponse.dart';
import 'package:travel_inspiration/Models/AllProjectModel.dart';
import 'package:travel_inspiration/Models/CountryModel.dart';
import 'package:travel_inspiration/Models/FlightDomesticModel.dart';
import 'package:travel_inspiration/Models/FlightModel.dart';
import 'package:travel_inspiration/Models/FlightType.dart';
import 'package:travel_inspiration/Models/GetAirportModel.dart';
import 'package:travel_inspiration/Models/HaudosUserModel.dart';
import 'package:travel_inspiration/Models/PlaceDetails.dart';
import 'package:travel_inspiration/Models/RouteModel.dart';
import 'package:travel_inspiration/Models/TransportModel.dart';
import 'package:travel_inspiration/Models/TravelClass.dart';
import 'package:travel_inspiration/Models/UserInfo.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/TIModel/TIAirlineCompanyModel.dart';
import 'package:travel_inspiration/TIModel/TIDestinationInProgressModel.dart';
import 'package:travel_inspiration/TIModel/TIMyAccountLanguageModel.dart';
import 'package:travel_inspiration/TIModel/TIMyAccountNotificationModel.dart';
import 'package:travel_inspiration/screens/TravelBook/TIAvailableFlightScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';
import 'package:travel_inspiration/utils/TITag.dart';
import 'package:http/http.dart' as http;


class MyController extends GetxController with SingleGetTickerProviderMixin {
  ApiManager apiManager = ApiManager();
  List<TIDestinationInProgressModel> mList =
      List<TIDestinationInProgressModel>.empty(growable: true).obs;
  List<TIDestinationInProgressModel> mHotelList =
      List<TIDestinationInProgressModel>.empty(growable: true).obs;
  List<TIDestinationInProgressModel> mRestaurantList =
      List<TIDestinationInProgressModel>.empty(growable: true).obs;
  List<TIDestinationInProgressModel> mActivityList =
      List<TIDestinationInProgressModel>.empty(growable: true).obs;
  var mPinList = List<TIDestinationInProgressModel>.empty(growable: true).obs;
  var selectedPlace = TIDestinationInProgressModel().obs;
  var selectedFavPlace = TIDestinationInProgressModel().obs;
  var countryList = List<CountryModel>.empty(growable: true).obs;
  var favList = List<TIDestinationInProgressModel>.empty(growable: true).obs;
  //var flightList = List<FlightModel.InternationalFlights>().obs;
  var myIntOnwordsList = List<FlightSegments>.empty(growable: true).obs;
  var myIntOnwordsList1 = List<List<FlightSegments>>.empty(growable: true).obs;
  // var onwardSelectedFlight = List<FlightSegments>.empty(growable: true).obs;
  var onwardSelectedFlight = List<FlightSegments>.empty(growable: true);
  var totalFare;
  var onwardSelectedFare = FlightSegments().obs;
  var returnSelectedFlight = List<FlightSegments>.empty(growable: true);
  var myIntReturnList = List<FlightSegments>.empty(growable: true).obs;
  var myIntReturnList1 = List<List<FlightSegments>>.empty(growable: true).obs;
  var fareList = List<dynamic>().obs;
  var flightList = List<FlightSegments>.empty(growable: true).obs;
 // var flightList1 = List<FlightDomesticModel>.empty(growable: true).obs;
  var routeList = List<RouteModel>.empty(growable: true).obs;
  var allProjectList = List<AllProjectModel>.empty(growable: true).obs;
  var haudosUserList = List<HaudosUserModel>.empty(growable: true).obs;
  var transportList = List<TransportModel>.empty(growable: true).obs;
  var selectedRoute = RouteModel().obs;
  var selectedProject = AllProjectModel().obs;
  var secondProject = AllProjectModel().obs;
  var thirddProject = AllProjectModel().obs;
  var userInfo = UserInfo().obs;
  var mPlaceDetails = PlaceDetails().obs;
  var selectedValue = CountryModel().obs;
  var selectedTravelClass = TravelClass().obs;
  var selectedFlightType = FlightType().obs;
  var selectedDate = "".obs;
  var selectedStartDate = "".obs;
  var selectedEndDate = "".obs;
  var selectedDestinationDate = "".obs;
  var selectedNotifyDate = "".obs;
  var nextPage_token = "".obs;
  String passenger = "";
  Future<String> wayPoints ;
  Timer timer;
  bool isDialog = false;

  //===========Gaia list=============//
  var showPopup = false.obs;
  var isFav = false.obs;
  var isFloatingMenuVisible, isSwitchClicked, isEditClicked;
  VoidCallback rotationCallback;

  var isList = false.obs;

  var duration = "".obs;
  var distance = "".obs;

  File mCroppedImg;
  var mSource = "".obs;
  var mDestination="".obs;


  stopTracking(){
    if(timer != null){
      timer.cancel();
    }
  }

  getCities(radious) async {
    try {
      Get.dialog(Loading());
      if (radious == 0.0) {
        radious = 30000;
      }
      if (nextPage_token.value == null) {
        nextPage_token.value = "";
      }
      Position _getCurrentPosition = await determineCurrentPosition();
      searchNearByPlaces(_getCurrentPosition.latitude,
              _getCurrentPosition.longitude, "city", radious, nextPage_token.value)
          .then((data) {
        // searchNearByPlaces(53.958332, -1.080278,"city").then((data){
        print(data);

        if(data['next_page_token'] != null) {
          nextPage_token.value = data['next_page_token'];
        }
        for (int i = 0; i < data['results'].length; i++) {
          TIDestinationInProgressModel model = TIDestinationInProgressModel();
          model.name = data['results'][i]['name'];
          model.place_id = data['results'][i]['place_id'];
          model.imgUrl = data['results'][i]['icon'];
          model.description = data['results'][i]['vicinity'];
          model.content = "see_map".tr;
          model.lat = data['results'][i]['geometry']['location']['lat'];
          model.lng = data['results'][i]['geometry']['location']['lng'];
          if (data['results'][i]['photos'] != null) {
            model.photo_ref = data['results'][i]['photos'][0]['photo_reference'];
          } else {
            model.photo_ref = null;
          }

          //data['results'][0]['geometry']['location']['lat'] - 23.022505
          //data['results'][0]['geometry']['location']['lng']. - 72.5713621
          mList.add(model);
        }
        Get.back();
      });
    } catch (err) {
      Get.back();
    } finally {
      // Get.back();
    }
  }

  /*============== get hotels============= */
  //https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=22.9999068,72.5947069&types=hotel&keyword=hotel&radius=40000&key=AIzaSyBRNil_iYmWUTUysdN_CU7KgDmv-ramMcM

  getHotels(radious, type, keyword) async {
    try {
      Get.dialog(Loading());
      if (radious == 0.0) {
        radious = 3000;
      }
      if (nextPage_token.value == null) {
        nextPage_token.value = "";
      }
      Position _getCurrentPosition = await determineCurrentPosition();
      searchNearByHotels(selectedPlace.value.lat, selectedPlace.value.lng, type,
              keyword, radious, nextPage_token.value)
          .then((data) {
        // searchNearByPlaces(53.958332, -1.080278,"city").then((data){
        print("res name: ${data['results'][0]['name']}");

        nextPage_token.value = data['next_page_token'];
        for (int i = 0; i < data['results'].length; i++) {
          TIDestinationInProgressModel model = TIDestinationInProgressModel();
          model.name = data['results'][i]['name'];
          model.place_id = data['results'][i]['place_id'];
          model.imgUrl = data['results'][i]['icon'];
          model.description = data['results'][i]['vicinity'];
          model.rating = data['results'][i]['rating'].toDouble();
          model.content = "see_map".tr;
          model.lat = data['results'][i]['geometry']['location']['lat'];
          model.lng = data['results'][i]['geometry']['location']['lng'];
          if (data['results'][i]['photos'] != null) {
            model.photo_ref =
                data['results'][i]['photos'][0]['photo_reference'];
          } else {
            model.photo_ref = null;
          }

          //data['results'][0]['geometry']['location']['lat'] - 23.022505
          //data['results'][0]['geometry']['location']['lng']. - 72.5713621
          mHotelList.add(model);
        }
        Get.back();
        print("res count : ${mHotelList.length}");
      });
    } catch (err) {
      Get.back();
    } finally {
      // Get.back();
    }
  }

  getRestaurantList(radious, type, keyword) async {
    try {
      Get.dialog(Loading());
      if (radious == 0.0) {
        radious = 3000;
      }
      if (nextPage_token.value == null) {
        nextPage_token.value = "";
      }
      searchNearByHotels(selectedPlace.value.lat, selectedPlace.value.lng, type,
              keyword, radious, nextPage_token.value)
          .then((data) {
        // searchNearByPlaces(53.958332, -1.080278,"city").then((data){
        print("res name: ${data['results'][0]['name']}");

        nextPage_token.value = data['next_page_token'];
        for (int i = 0; i < data['results'].length; i++) {
          TIDestinationInProgressModel model = TIDestinationInProgressModel();
          model.name = data['results'][i]['name'];
          model.place_id = data['results'][i]['place_id'];
          model.imgUrl = data['results'][i]['icon'];
          model.description = data['results'][i]['vicinity'];
          model.rating = data['results'][i]['rating'].toDouble();
          model.content = "see_map".tr;
          model.lat = data['results'][i]['geometry']['location']['lat'];
          model.lng = data['results'][i]['geometry']['location']['lng'];
          if (data['results'][i]['photos'] != null) {
            model.photo_ref =
                data['results'][i]['photos'][0]['photo_reference'];
          } else {
            model.photo_ref = null;
          }

          //data['results'][0]['geometry']['location']['lat'] - 23.022505
          //data['results'][0]['geometry']['location']['lng']. - 72.5713621
          mRestaurantList.add(model);
        }
        print("res count : ${mRestaurantList.length}");
        Get.back();
      });
    } catch (err) {
      Get.back();
    } finally {
      // Get.back();
    }
  }

  getActivityList(radious, type, keyword) async {
    try {
      Get.dialog(Loading());
      if (radious == 0.0) {
        radious = 3000;
      }
      if (nextPage_token.value == null) {
        nextPage_token.value = "";
      }

      searchNearByHotels(selectedPlace.value.lat, selectedPlace.value.lng, type,
              keyword, radious, nextPage_token.value)
          .then((data) {
        // searchNearByPlaces(53.958332, -1.080278,"city").then((data){
        print("res name: ${data['results'][0]['name']}");

        nextPage_token.value = data['next_page_token'];
        for (int i = 0; i < data['results'].length; i++) {
          TIDestinationInProgressModel model = TIDestinationInProgressModel();
          model.name = data['results'][i]['name'];
          model.place_id = data['results'][i]['place_id'];
          model.imgUrl = data['results'][i]['icon'];
          model.description = data['results'][i]['vicinity'];
          model.rating = data['results'][i]['rating'].toDouble();
          model.content = "see_map".tr;
          model.lat = data['results'][i]['geometry']['location']['lat'];
          model.lng = data['results'][i]['geometry']['location']['lng'];
          if (data['results'][i]['photos'] != null) {
            model.photo_ref =
                data['results'][i]['photos'][0]['photo_reference'];
          } else {
            model.photo_ref = null;
          }

          //data['results'][0]['geometry']['location']['lat'] - 23.022505
          //data['results'][0]['geometry']['location']['lng']. - 72.5713621
          mActivityList.add(model);
        }
        print("res count : ${mActivityList.length}");
        Get.back();
      });
    } catch (err) {
      Get.back();
    } finally {
      // Get.back();
    }
  }

  /*============== get place details============= */
  //https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJI18JomGEXjkR6spwQiQrJ8o&key=AIzaSyBRNil_iYmWUTUysdN_CU7KgDmv-ramM

  getPlaceDetails(place_id) async {
    try {
      Get.dialog(Loading());

      getPlaceDetailsByPlaceId(place_id).then((data) {
        if (data != null) {
          mPlaceDetails.value = data;
        }
        Get.back();
      });
    } catch (err) {
      Get.back();
    } finally {
      // Get.back();
    }
  }


  /*============= get direction api ========================*/

  //https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=40.6655101,-73.89188969999998&destinations=40.6905615%2C,-73.9976592&key=YOUR_API_KEY
  getDistanceAPI(originLat,originLng) {
    try {
      Get.dialog(Loading());

      //Position _getCurrentPosition = await determineCurrentPosition();
      googlegGetDistance(originLat,originLng,selectedPlace.value.lat, selectedPlace.value.lng)
          .then((data) {

        duration.value = data['rows'][0]['elements'][0]['duration']['text'];
        distance.value = data['rows'][0]['elements'][0]['distance']['text'];
        print("durr${duration.value}");

        Get.back();
      });
    } catch (err) {
      Get.back();
    }
  }

  setIntOnwardSelection(index){
    for (int i = 0; i < myIntOnwordsList1.value.length; i++) {
      myIntOnwordsList1.value[i][0].intOnwardSelect = false;
    }
    myIntOnwordsList1.value[index][0].intOnwardSelect = true;
  }

  setOutwardSelection(index){
    for (int i = 0; i < myIntReturnList1.value.length; i++) {
      myIntReturnList1.value[i][0].outwardSelect = false;
    }
    myIntReturnList1.value[index][0].outwardSelect = true;
  }
  /*============ getAvailable flight*/

  void getFlightSearch(param,tofilter,  travelLougeListTitle) async {
    try {
      Get.dialog(Loading());
      myIntOnwordsList1.value.clear();
      myIntReturnList1.value.clear();
      fareList.clear();

      var _flightList = await apiManager.getAvailableFlightList(param,tofilter);
      if (_flightList != null && _flightList.flightOnword.length >0) {
 print("length.....${_flightList.flightOnword.length}");
        if(_flightList.flightOnword.length != 0) {
          for (int i = 0; i < _flightList.flightOnword.length; i++) {
            fareList.value.add(_flightList.flightOnword[i].fare);
            // fareList.value.add(((_flightList.flightOnword[i].fare)/(ApiParameter.ONE_POUND_VAL)).toStringAsFixed(2));
            myIntOnwordsList1.value.add(
                _flightList.flightOnword[i].intOnward.flightSegments);

          }

        }
          if(_flightList.flightReturn.length != 0){
            for(int i=0;i<_flightList.flightReturn.length;i++) {
              myIntReturnList1.value.add(_flightList.flightReturn[i].intReturn.flightSegments);
            }
        }
        Get.back();
        ScreenTransition.navigateToScreenLeft(
            screenName: TIAvailableFlightScreen(travelLougeListTitle));

      }else{
        Get.back();
        MyCommonMethods.showInfoCenterDialog(msgContent: "txtNoRecordFound".tr,myFont: MyStrings.courier_prime);
      }
    } finally {
     /* Get.back();
      ScreenTransition.navigateToScreenLeft(
          screenName: TIAvailableFlightScreen());*/
     // Get.back();
    }
  }




  void getFav() async {
    try {
      Get.dialog(Loading());
      var _favList = await apiManager.getFavList();
      if (_favList != null) {
        favList.value = _favList;
      }
    } finally {
      Get.back();
    }
  }

  void getRouteList(param) async {
    try {
      Get.dialog(Loading());
      var _routeList = await apiManager.getRouteListAPI(param);
      if (_routeList != null) {
        routeList.value = _routeList;
      }
    } finally {
      Get.back();
    }
  }

  void getCountries() async {
    try {
      Get.dialog(Loading());
      var _countryList = await apiManager.getCountryList();
      if (_countryList != null) {
        countryList.value = _countryList;
      }
    } finally {
      Get.back();
    }
  }

  setSelectedProj(AllProjectModel mSelProj) {
    resetProj();
    for (int i = 0; i < allProjectList.value.length; i++) {
      if (mSelProj.id == allProjectList.value[i].id) {
        allProjectList.value[i].isSelected = true;
        selectedProject = AllProjectModel().obs;
        selectedProject.value = allProjectList.value[i];
        getSelectedProj();
      } else {
        allProjectList.value[i].isSelected = false;
      }
    }
  }

  resetProj() {
    if (allProjectList.value != "" &&
        allProjectList.value != null &&
        allProjectList.value.length > 0) {
      for (int i = 0; i < allProjectList.value.length; i++) {
        allProjectList.value[i].isSelected = false;
      }
    }
    selectedProject = null;
  }

  getSelectedProj() {
    List<AllProjectModel> tempProjList = List();
    if (allProjectList.value != "" &&
        allProjectList.value != null &&
        allProjectList.value.length > 0) {
      tempProjList.addAll(allProjectList.value);
      for (int i = 0; i < allProjectList.value.length; i++) {
        if (allProjectList.value[i].isSelected) {
         selectedProject = AllProjectModel().obs;
          selectedProject.value = allProjectList.value[i];
          if(tempProjList != null && tempProjList.length > 0 ) {
            for(int j=0;j<tempProjList.length;j++) {
              if(allProjectList.value[i].id == tempProjList[j].id) {
                tempProjList.removeAt(j);
              }
            }
          }
        }
      }
      if (tempProjList.length > 0)
      {secondProject.value = tempProjList[0];}
      if (tempProjList.length > 1) {
        thirddProject.value = tempProjList[1];
      }
      }
    }


  getPinList(param) async {
    try {
      Get.dialog(Loading());
      var _pinList = await apiManager.getPinAPI(param);
      if (_pinList != null) {
        mPinList.value = List<TIDestinationInProgressModel>().obs;
        mPinList.value = _pinList;
      }
    } finally {
      Get.back();
    }
  }

  void getAllProject() async {
    try {
      Get.dialog(Loading());
      var _allProjList = await apiManager.getAllProject();

      if (_allProjList != null) {
        allProjectList.value = List<AllProjectModel>().obs;
        allProjectList.value = _allProjList;
      }
    } finally {
      Get.back();
    }
  }

   getHaudosUser(param) async {
    try {
      Get.dialog(Loading());
      var _haudosUserList = await apiManager.getHaudosUser(param);

      if (_haudosUserList != null) {
        haudosUserList.value = List<HaudosUserModel>().obs;
        haudosUserList.value = _haudosUserList;
      }
    } finally {
      Get.back();
    }
  }

  getSettingUser(param) async {
    try {
      Get.dialog(Loading());
      //var _haudosUserList =
      await apiManager.getSettingList(param);

      /*if (_haudosUserList != null) {
        haudosUserList.value = List<HaudosUserModel>().obs;
        haudosUserList.value = _haudosUserList;
      }*/
    } finally {
      Get.back();
    }
  }

  void getTransportList(tag) async {
    try {
      //Get.dialog(Loading());
      var _transportList = await apiManager.getTransportList(tag);

      if (_transportList != null) {
        transportList.value = List<TransportModel>().obs;
        transportList.value = _transportList;
        if(transportList.value.length>0) {
          isList.value = true;
        }
      }
    } finally {
      //Get.back();
    }
  }

  void getProfile() async {
    try {
      Get.dialog(Loading());
      var _userInfo = await apiManager.getProfileAPI();
      if (_userInfo != null) {
        userInfo.value = _userInfo;
      }
    } finally {
      Get.back();
    }
  }

  @override
  void onInit() {
    super.onInit();
    print("onInit() Controller Called");
    //==========fly menu sreen=========//
    isFloatingMenuVisible = false.obs;
    isSwitchClicked = false.obs;
    isEditClicked = false.obs;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //=======account mode of transport screen==========
  var isCarSwitchOn = false.obs,
      isBikeSwitchOn = false.obs,
      isTrainSwitchOn = false.obs,
      isCycleSwitchOn = false.obs,
      isScooterSwitchOn = false.obs,
      isManSwitchOn = false.obs;

  //======account mode-language screen=====

  var selectedLanguage = "".obs;
  var updatedLanguage = "".obs;

  var isExapanded = false.obs;
  var isFrenchOrEnglish = true.obs;
  var langTileColor = false.obs;

  //======faq screen====
  var showQuestionPopup = false.obs;

  //my account destination screen=======
  var showPrepareProjectPopup = false.obs;
  var showPrepareProjectMenu = false.obs;
  var isFavMenu = false.obs;

  //pin destination to project screen===
  var pinDestination = "".obs;
  var rotateArrow = false.obs;

  //destination in progress screen=====
  var showDestinationInProgressPopup = false.obs;

  //===========passanger screen========
  var noOfAdults = 0.obs;
  var noOfChildrens = 0.obs;
  var noOfBabes = 0.obs;

  //=============my flight screen==========
  var toGoReturnSwitch = true.obs;

  //===============flight summary screen======
  var toGoExpanded = false.obs;
  var returnExpanded = false.obs;

  //==============flight and train add manually screen ========
  var showFlightAndTrainPopup = false.obs;
  var isAddFlightMenual_FT_ManualAddS = false.obs;

  /*//AD = Arrival date
  var year_AD_FT_ManualAddS = "".obs;
  var month_AD_FT_ManualAddS = "".obs;
  var month_Number_AD_FT_ManualAddS = "".obs;
  var date_AD_FT_ManualAddS = "".obs;

  //DD = departure date
  var year_DD_FT_ManualAddS = "".obs;
  var month_DD_FT_ManualAddS = "".obs;
  var month_Number_DD_FT_ManualAddS = "".obs;
  var date_DD_FT_ManualAddS = "".obs;*/

  var futureAireline_FT_ManualAddS =
      Future.value(<TITransportModel>[]).obs;

  callgetAirlinesAPI(String tag) async {
    futureAireline_FT_ManualAddS.value = fetchAirlineList(tag);
  }

  Future<List<TITransportModel>> fetchAirlineList(String tag) async {
    List<TITransportModel> airlinelist = [];
    if (await isConnected()) {
      MyResponse response =
          await ApiCall().CallGetAPI(url: tag == TITag.TAGPLAIN?ApiParameter.getAirlines:ApiParameter.getTrains);

      if (response.isSuccess()) {
        List listaireline = response.getDATAJSONArray1()[ApiParameter.data];
        //TIPrint(tag:"URL",value:result.length.toString());
        listaireline.forEach((element) {
          TIPrint(tag: "name", value: element.toString());
          airlinelist.add(TITransportModel(name: element));
        });
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }

    return airlinelist;
  }

  void calladdFlightAPI(
      {@required var departure,
      @required var arrival,
      @required var arrivalDate,
      @required var departureDate,
      @required var airline,
      @required var ticketNo,
      @required var tag,
      @required var projectId}) async {
    if (await isConnected()) {
      Get.dialog(Loading());
      Map<String, String> mapRequestParam = new Map();
      mapRequestParam[ApiParameter.userId] =
          MyPreference.getPrefStringValue(key: MyPreference.userId).toString();
      mapRequestParam[ApiParameter.projectId] = projectId.toString();
      mapRequestParam[ApiParameter.departure] = departure.toString();
      mapRequestParam[ApiParameter.arrival] = arrival.toString();
      mapRequestParam[ApiParameter.depart_date] = departureDate.toString();
      mapRequestParam[ApiParameter.arrive_date] = arrivalDate.toString();
      mapRequestParam[ApiParameter.airline] = airline.toString();
      mapRequestParam[ApiParameter.ticketNo] = ticketNo.toString();

      MyResponse response = await ApiCall().CallPostWithParamTokenAPI(
          url: tag == TITag.TAGPLAIN ? ApiParameter.addFlight :ApiParameter.addTrain, param: mapRequestParam);
      Get.back();
      if (response.isSuccess()) {
        List listaireline = response.getDATAJSONArray1()[ApiParameter.data];
        //TIPrint(tag:"URL",value:result.length.toString());
      //  MyCommonMethods.showInfoCenterDialog(msgContent: response.getMessage());
        TransportModel addedItem = TransportModel();
        addedItem.projectId = projectId.toString();
        addedItem.departure = departure.toString();
        addedItem.arrival = arrival.toString();
        addedItem.departDate = departureDate.toString();
        addedItem.arriveDate = arrivalDate.toString();
        addedItem.airline = airline.toString();
        addedItem.ticketNumber = ticketNo.toString();
        transportList.add(addedItem);

        isAddFlightMenual_FT_ManualAddS.value = false;
        selectedDate.value = "";
        selectedDestinationDate.value = "";
        Get.back();
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  //=============home screen inspredmode=========
  var showHomeIcon = true.obs;

  List<GetAirportlModel> airportlist =
      <GetAirportlModel>[].obs;
  getAirportList(value,context) async{
    airportlist.clear();
    focusOut(context);
    String url =
        '${ApiParameter.googleairportlistURL}query=${value}&type=airport&key=${ApiParameter.GOOGLE_API_KEY}';
    print(url);
    var url1 = Uri.parse(url);
    final response = await http.get(url1);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List _data = data["results"];
      _data.forEach((element) {
        airportlist.add(GetAirportlModel.fromJson(element));
      });
      return airportlist;
    } else {
      throw Exception('An error occurred getting places nearby');
    }
  }

  //***************** TIFilterSortFlightScreen *************** TIFilterSortFlightScreen ********

var isStopover_FS = false.obs;
var isShort_price_FS = false.obs;
var isShortDuration_FS = false.obs;
var isStartPrice_FS = "0".obs;
var isEndPrice_FS = "100000".obs;

}

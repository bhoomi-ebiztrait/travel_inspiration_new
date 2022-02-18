import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/MyResponse.dart';
import 'package:travel_inspiration/Models/AllProjectModel.dart';
import 'package:travel_inspiration/Models/AuthInfoModel.dart';
import 'package:travel_inspiration/Models/CountryModel.dart';
import 'package:travel_inspiration/Models/FlightModel.dart';
import 'package:travel_inspiration/Models/HaudosUserModel.dart';
import 'package:travel_inspiration/Models/RouteModel.dart';
import 'package:travel_inspiration/Models/TransportModel.dart';
import 'package:travel_inspiration/TIModel/FaqListTitleModel.dart';
import 'package:travel_inspiration/Models/LoginModel.dart';
import 'package:travel_inspiration/Models/UserInfo.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/TIModel/TIArticalListModel.dart';
import 'package:travel_inspiration/TIModel/TIDestinationInProgressModel.dart';
import 'package:travel_inspiration/TIModel/TIFaqQuestionAnswerModel.dart';
import 'package:travel_inspiration/TIModel/TIMyAccountLanguageModel.dart';
import 'package:travel_inspiration/screens/LoginScreen.dart';
import 'package:travel_inspiration/screens/SingupConfirmScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';
import 'package:travel_inspiration/utils/TITag.dart';

import 'ApiCall.dart';
import 'ApiParameter.dart';

class ApiManager extends GetxController {
  LoginModel loginModel = LoginModel();

  var isAgree = false.obs;

  static ApiManager _apiManager;

  //single ton object
  static ApiManager getInstance() {
    if (_apiManager != null) {
      return _apiManager;
    }
    _apiManager = new ApiManager();
    return _apiManager;
  }

  //----------------------------------------------Common Method -------------------------------------------------------------------//
  getResponsecode(data) {
    String msg = data["message"];
    if (data == null) {
      return null;
    } else if (data["code"] == 200 || data["code"] == 201) {
      if (data["status"] == 'success') {
        return data;
      } else {
        MyUtility.showErrorMsg(msg);
        return null;
      }
    } else if (data["code"] == 422 ||
        data["code"] == 401 ||
        data["code"] == 400 ||
        data["code"] == 500 ||
        data["code"] == 404) {
      if (msg == "Invalid token.") {
        MyPreference.clearPref();
        Get.offAll(() => LoginScreen());
        MyUtility.showErrorMsg(msg);
        // return data;
      } else {
        MyUtility.showErrorMsg(msg);
        return null;
      }
    }
  }

/*=============== login api ===========================*/
  getLoginAPI(param) async {
    if (await isConnected()) {
      try {
        final response = await ApiCall()
            .CallPostAPI(url: ApiParameter.loginURL, payload: param);
        if (response.isSuccess()) {
          var result = response.getDATAJSONArray1();
          //var data = result["userInfo"];

          if (result != null) {
            loginModel = LoginModel.fromJson(result);
            MyPreference.setPrefStringValue(
                key: MyPreference.userId,
                value: loginModel.userInfo.userId.toString());
            MyPreference.setPrefStringValue(
                key: MyPreference.dob,
                value: loginModel.userInfo.dob.toString());
            MyPreference.setPrefStringValue(
                key: MyPreference.address,
                value: loginModel.userInfo.address.toString());
            MyPreference.setPrefStringValue(
                key: MyPreference.city,
                value: loginModel.userInfo.city.toString());
            MyPreference.setPrefStringValue(
                key: MyPreference.pinCode,
                value: loginModel.userInfo.pincode.toString());
            MyPreference.setPrefStringValue(
                key: MyPreference.country, value: loginModel.userInfo.country.toString());

            MyPreference.setPrefStringValue(
                key: MyPreference.accessToken, value: loginModel.accessToken);
            String mode = loginModel.mode!= null ? loginModel.mode.toString() : null;
            if (mode == null) mode = "0";
            MyPreference.setPrefIntValue(
                key: MyPreference.APPMODE, value: int.parse(mode));
            return true;
          }
        } else {
          MyUtility.showErrorMsg(response.getMessage());
          return false;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  /*=============== login with BIO api ===========================*/
  getLoginWithBIOAPI(param) async {
    if (await isConnected()) {
      try {
        final response = await ApiCall()
            .CallPostAPI(url: ApiParameter.loginWithbioURL, payload: param);
        if (response.isSuccess()) {
          var result = response.getDATAJSONArray1();
          //var data = result["userInfo"];
          if (result != null) {
            loginModel = LoginModel.fromJson(result);
            MyPreference.setPrefStringValue(
                key: MyPreference.userId,
                value: loginModel.userInfo.userId.toString());
            MyPreference.setPrefStringValue(
                key: MyPreference.accessToken, value: loginModel.accessToken);
            String mode = loginModel.mode;
            if (mode == null) mode = "0";
            MyPreference.setPrefIntValue(
                key: MyPreference.APPMODE, value: int.parse(mode));
            return true;
          }
        }
        else{
          MyUtility.showErrorMsg("${response.getMessage()}");
          return false;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  /*======================= get profile api ========================*/
  getProfileAPI() async {
    if (await isConnected()) {
      try {
        String userId =
            MyPreference.getPrefStringValue(key: MyPreference.userId);
        final response = await ApiCall().CallGetWithTokenAPI(
            ApiParameter.getProfileURL + "?userId=$userId");
        var result = response.getDATAJSONArray1();

        UserInfo userInfo = UserInfo();
        if (result != null) {
          userInfo = UserInfo.fromJson(result);
          return userInfo;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  /*======================= get authInfo api ========================*/
  getAuthInfo(int id) async {
    if (await isConnected()) {
      try {
String mLang = MyPreference.getPrefStringValue(key: MyPreference.language_code);
if(mLang == null){
  mLang = "en";
}
        final response = await ApiCall()
            .CallGetAPI(url: ApiParameter.getAuthInfoURL + "?id=$id&language=$mLang");
        var result = response.getDATAJSONArray1();

        if (result != null) {
          return result["data"];
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  /*======================= getAllProject api ========================*/
  getAllProject() async {
    if (await isConnected()) {
      try {
        String userId =
            MyPreference.getPrefStringValue(key: MyPreference.userId);
        // String userId = "43";
        final response = await ApiCall().CallGetAPI(
            url: "${ApiParameter.getAllProjectsURL}?userId=$userId");
        var data = response.getDATAJSONArray1();
        var result = getResponsecode(data);

        if (result != null) {
          var listData = result["data"] as List;
          print(listData);

          return listData
              .map<AllProjectModel>((json) => AllProjectModel.fromJson(json))
              .toList();
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  /*======================= getHaudosUser api ========================*/
  getHaudosUser(param) async {
    if (await isConnected()) {
      try {

        // String userId = "43";
        final response = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.gethuadosUsersURL,param: param);
        var data = response.getDATAJSONArray1();
        var result = getResponsecode(data);

        if (result != null) {

          var listData = result["data"] as List;
          print(listData);

          return listData
              .map<HaudosUserModel>((json) => HaudosUserModel.fromJson(json))
              .toList();
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }


  /*======================= get settings api ========================*/
  getSettingList(param) async {
    if (await isConnected()) {
      try {
        String userId =
        MyPreference.getPrefStringValue(key: MyPreference.userId);
        // String userId = "43";
        final response = await ApiCall().CallPostWithParamTokenAPI(
            url:ApiParameter.getSettingsURL,param:param);
        var data = response.getDATAJSONArray1();
        var result = getResponsecode(data);

         if (result != null) {
          // var listData = result["data"] as List;
          print("result:: ${result["data"]}");

          return result["data"];
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }


  /*======================= get transportList api ========================*/
  getTransportList(tag) async {
    if (await isConnected()) {
      try {
        String userId =
        MyPreference.getPrefStringValue(key: MyPreference.userId);
        // String userId = "43";
        String mUrl = tag == TITag.TAGPLAIN ? ApiParameter.getFlightListURL : ApiParameter.getTrainListURL;
        final response = await ApiCall().CallGetAPI(
            url: "${mUrl}?userId=$userId");
        var data = response.getDATAJSONArray1();
        var result = getResponsecode(data);

        if (result != null) {
          var listData = result["data"] as List;
          print(listData);

          return listData
              .map<TransportModel>((json) => TransportModel.fromJson(json))
              .toList();
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }



  /*======================= get favlist api ========================*/
  getFavList() async {
    if (await isConnected()) {
      String userId = MyPreference.getPrefStringValue(key: MyPreference.userId);

      try {
        final response = await ApiCall().CallGetAPI(
            url: "${ApiParameter.getFavouriteListURL}?userId=$userId");
        var data = response.getDATAJSONArray1();
        var result = getResponsecode(data);
        List<TIDestinationInProgressModel> cityList =
            List<TIDestinationInProgressModel>();
        if (result != null) {
          for (int i = 0; i < result["data"].length; i++) {
            TIDestinationInProgressModel mObj = TIDestinationInProgressModel();
            mObj.id = result["data"][i]["id"];
            mObj.name = result["data"][i]["city"];
            mObj.km = double.parse(result["data"][i]["km"]);
            mObj.imgUrl = result["data"][i]["image"];
            cityList.add(mObj);
          }

          return cityList;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  /*======================= get countrylist api ========================*/
  getCountryList() async {
    if (await isConnected()) {
      try {
        final response =
            await ApiCall().CallGetAPI(url: ApiParameter.countryListURL);
        var data = response.getDATAJSONArray1();
        var result = getResponsecode(data);

        if (result != null) {
          var listData = result["country_list"] as List;
          print(listData);

          return listData
              .map<CountryModel>((json) => CountryModel.fromJson(json))
              .toList();
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  /*======================= get available flight list api ========================*/
  getAvailableFlightList(param,tofilter) async {
    print("param.....$param");
    if (await isConnected()) {
      try {
        final response =
        await ApiCall().CallGetWithParamAPI(authority : "solutiontrackers.com",url: tofilter?ApiParameter.searchFlights:ApiParameter.availableFlightsURL,param: param);
        print("mres :: ${response.toString()}");
        var data = response.getDATAJSONArray1();
        var result = getResponsecode(data);
        print("result............$result['data']");
        if (result != null && result['data'] != null) {
          return FlightModel.fromJson(result['data']);
        }
      } catch (e) {
       // MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  /*======================= CreateProfile api ========================*/
  createProfileAPI(request, image) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final result = await ApiCall().CallPostWithImageAPI(
            ApiParameter.createProfileURL, request, image,"avatar");
        var data = result.getDATAJSONArray1();
        var response = getResponsecode(data);
        if (response != null) {
          return true;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  /*======================= UpdateAvtar api ========================*/
  updateAvtarAPI(request, image) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final result = await ApiCall()
            .CallPostWithImageAPI(ApiParameter.updateAvtarURL, request, image,"avatar");
        var data = result.getDATAJSONArray1();
        var response = getResponsecode(data);
        if (response != null) {
          return true;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  /*======================= UpdateTHeme api ========================*/
  updateThemeAPI(request, image) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final result = await ApiCall()
            .CallPostWithImageAPI(ApiParameter.updateThemeURL, request, image,"projectImage");
        var data = result.getDATAJSONArray1();
        var response = getResponsecode(data);
        if (response != null) {
          return true;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  /*================= select mode ==============================*/
  selectModeAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final result = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.selectModeURL, param: param);
        var data = result.getDATAJSONArray1();
        var response = getResponsecode(data);
        if (response != null) {
          String mode = response["data"]["mode"];
// TIPrint(tag: "Selected Mode",value: mode);
          MyPreference.setPrefIntValue(
              key: MyPreference.APPMODE, value: int.parse(mode));
          return true;
        }else{
          return false;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
        return false;
      } finally {
        Get.back();
      }
    }
  }

  /*================= pinDestination api ==============================*/
  pinDestinationAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final result = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.pinDestinationURL, param: param);
        var data = result.getDATAJSONArray1();
        var response = getResponsecode(data);
        if (response != null) {
          return true;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }

  /*================= create pin api ==============================*/
  createPinAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final result = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.createPinURL, param: param);
        var data = result.getDATAJSONArray1();
        var response = getResponsecode(data);
        if (response != null) {
          return true;
        }else{ return false;}
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }


  /*================= send Notification to user api ==============================*/
  sendNotificationToUser(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final result = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.sendNotificationToUserURL, param: param);
        var data = result.getDATAJSONArray1();
        var response = getResponsecode(data);
        MyUtility.showErrorMsg(response.getMessage().toString());
        /*if (response != null) {
          MyUtility.showErrorMsg(response.getMessage());
        //  return true;
        }else{
          MyUtility.showErrorMsg(response.getMessage());
          // return false;
        }*/
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }

  /*================= get pin list api ==============================*/
  getPinAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        List<TIDestinationInProgressModel> mPinList =
            List<TIDestinationInProgressModel>.empty(growable: true);
        final result = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.getPinListURL, param: param);
        var data = result.getDATAJSONArray1();
        var response = getResponsecode(data);
        if (response != null) {

          if(response['data'].length > 0) {
            for (int i = 0; i < response['data'].length; i++) {
              TIDestinationInProgressModel obj = TIDestinationInProgressModel();
              obj.name = response['data'][i]['title'];
              obj.id = response['data'][i]['pinId'];
              obj.description = response['data'][i]['description'];
              obj.rating = double.parse(response['data'][i]['rating']);

              obj.imgUrl = response['data'][i]['imgUrl'];
              if (obj.imgUrl.startsWith("http")) {
                obj.photo_ref = null;
              } else {
                obj.photo_ref = obj.imgUrl;
              }
              mPinList.add(obj);
            }
          }else{
            MyUtility.showErrorMsg("txtNoRecordFound".tr);
          }
          return mPinList;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }

  /*================= delete pin list api ==============================*/
  deletePinAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final result = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.deletePinListURL, param: param);
        var data = result.getDATAJSONArray1();
        var response = getResponsecode(data);
        if (response != null) {
  return true;
        }
        return false;
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }



  /*================= update dob ==============================*/
  updateDOBAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final response = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.updateDOBURL, param: param);
        var result = response.getDATAJSONArray1();
        if (result != null) {
          return true;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }

  /*================= update address ==============================*/
  updateAddressAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final response = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.updateAddressURL, param: param);
        var result = response.getDATAJSONArray1();
        if (result != null) {
          return true;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }


  /*================= add route ==============================*/
  addRouteAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final response = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.addRoute, param: param);
        var result = response.getDATAJSONArray1();
        if (result != null) {
          return true;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }


  /*================= get route list ==============================*/
  getRouteListAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final response = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.getMyRoutes, param: param);
        var result = response.getDATAJSONArray1();
        if (result != null) {
          print("res :: ${result.toString()}");
          if (result != null) {
            var listData = result["data"] as List;
            print(listData);

            return listData
                .map<RouteModel>((json) => RouteModel.fromJson(json))
                .toList();
          }
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }

  /*================= update km ==============================*/
  updateKmAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final response = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.updateKmURL, param: param);
        var result = response.getDATAJSONArray1();
        if (result != null) {
          return true;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }

/*=================  create favourite api ==============================*/
  createFavAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final response = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.createFavouriteURL, param: param);
        var result = response.getDATAJSONArray1();
        if (response.isSuccess()) {
          return true;
        } else {
          MyUtility.showErrorMsg(response.getMessage());
          return false;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }

  /*=================  delete favourite api ==============================*/
  deleteFavAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final response = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.deleteFavouriteURL, param: param);
        var result = response.getDATAJSONArray1();
        if (response.isSuccess()) {
          return true;
        } else {
          MyUtility.showErrorMsg(response.getMessage());
          return false;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }

  /*=================  confirm user api ==============================*/
  confirmUserAPI() async {
    Get.dialog(Loading());
    String userId = MyPreference.getPrefStringValue(key:MyPreference.userId);
    if (await isConnected()) {
      try {
        final response = await ApiCall().CallGetWithTokenAPI("${ApiParameter.verify_user}?userId=$userId");
       // var result = response.getDATAJSONArray1();
        if(response != null) {
          if (response.isSuccess()) {
            return response;
          } else {
            MyUtility.showErrorMsg(response.getMessage());
            return response;
          }
        }else{
          return null;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }

  /*=================  delete project api ==============================*/
  deleteProjAPI(pId) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final response = await ApiCall().CallGetAPI(
            url: "${ApiParameter.deleteProjectURL}?projectId=$pId");
        var result = response.getDATAJSONArray1();
        if (response.isSuccess()) {
          return true;
        } else {
          MyUtility.showErrorMsg(response.getMessage());
          return false;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }


  /*=================  create subproject mode ==============================*/
  createSubProjectAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final response = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.createSubProjectURL, param: param);
        var result = response.getDATAJSONArray1();
        if (response.isSuccess()) {
          return true;
        } else {
          MyUtility.showErrorMsg(response.getMessage());
          return false;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }

  /*=================  create Reflect project mode ==============================*/
  createReflectProjectAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final response = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.createReflectProjectURL, param: param);
        var result = response.getDATAJSONArray1();
        if (response.isSuccess()) {
          return true;
        } else {
          MyUtility.showErrorMsg(response.getMessage());
          return false;
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }

  /*=================  create Inspire project mode ==============================*/
  createInspireProjectAPI(param) async {
    Get.dialog(Loading());
    if (await isConnected()) {
      try {
        final response = await ApiCall().CallPostWithParamTokenAPI(
            url: ApiParameter.createInspireProjectURL, param: param);
        var result = response.getDATAJSONArray1();
        if (response.isSuccess()) {
          //store created project details in selectedProject
          // return project instead of bool true
          return true;
        } else {
          MyUtility.showErrorMsg(response.getMessage());
        }
      } catch (e) {
        MyUtility.showErrorMsg(e.toString());
        TIPrint(tag: "catch..", value: e.toString());
      } finally {
        Get.back();
      }
    }
  }

  //sign up api call

  Future<MyResponse> signUpApiCall(param) async {
    TIPrint(tag: "API CALL", value: "SIGN UP");
    if (await isConnected()) {
      try {
        MyResponse response = await ApiCall()
            .CallPostAPI(url: ApiParameter.signUp, payload: param);

        if (response.isSuccess()) {
          return response;
        } else {
          return response;
        }
      } catch (e) {
        // TIPrint(tag: "catch..", value: e);
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  //forgot password api call
  var isVisibleMsg = false.obs;
  var forgotAutoValidate = false.obs;

  forgotPasswordApiCall({param}) async {
    if (await isConnected()) {
      MyResponse response = await ApiCall()
          .CallPostAPI(url: ApiParameter.FORGOTPASSWORD, payload: param);

      if (response.isSuccess()) {
        isVisibleMsg.value = true;
        return response.getMessage();
      } else {
        return response.getMessage();
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  ///======chang password api call=======
  Future<MyResponse> changePasswordApiCall({param}) async {
    if (await isConnected()) {
      MyResponse response = await ApiCall().CallPostWithParamTokenAPI(
          url: ApiParameter.CHANGEPASSWORD, param: param);

      if (response.isSuccess()) {
        return response;
      } else {
        return response;
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  ///======updateProject api call=======
  Future<MyResponse> updateProjectApiCall({param}) async {
    if (await isConnected()) {
      MyResponse response = await ApiCall().CallPostWithParamTokenAPI(
          url: ApiParameter.updateProjectURL, param: param);

      if (response.isSuccess()) {
        return response;
      } else {
        return response;
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  ///=====faq list title api call======
  var futureFaqList = Future.value(<FaqListTitleModel>[]).obs;

  futureFaqListApiCall() async {
    futureFaqList.value = faqListTitleApiCall();
  }

  Future<List<FaqListTitleModel>> faqListTitleApiCall() async {
    List<FaqListTitleModel> faqTitleList = [];

    if (await isConnected()) {
      MyResponse response =
          await ApiCall().CallGetAPI(url: ApiParameter.GETFAQTITLELIST);

      if (response.isSuccess()) {
        List result = response.getDATAJSONArray1()[ApiParameter.data];

        result.forEach((element) {
          faqTitleList.add(FaqListTitleModel.fromMap(element));
          // print("success ${faqTitleList.length.toString()}");
        });
        //print("faq list ${faqTitleList.length.toString()}");

      }
      print("Faq title list length:");
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }

    TIPrint(
        tag: "Faq title list length:",
        value: "${faqTitleList.length.toString()}");
    return faqTitleList;
  }

  ///=====faq list  api call======
  var futureFaqQueAnsList = Future.value(<TIFaqQuestionAnswerModel>[]).obs;

  futureFaqQueAnsListApiCall({titleId}) async {
    futureFaqQueAnsList.value = faqListApiCall(titleId: titleId);
  }

  Future<List<TIFaqQuestionAnswerModel>> faqListApiCall({titleId}) async {
    List<TIFaqQuestionAnswerModel> faqList = [];

    if (await isConnected()) {
      MyResponse response = await ApiCall()
          .CallGetAPI(url: ApiParameter.GETFAQLIST + "?titleId=$titleId");

      if (response.isSuccess()) {
        List result = response.getDATAJSONArray1()[ApiParameter.data];

        result.forEach((element) {
          faqList.add(TIFaqQuestionAnswerModel.fromMap(element));
        });
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }

    TIPrint(
        tag: "Faq title list length:", value: "${faqList.length.toString()}");
    return faqList;
  }

  //article list api call
  var articleListObs = List<TIArticalListModel>.empty().obs;

  Future<List<TIArticalListModel>> articleListApiCall() async {
    List<TIArticalListModel> articleList = [];
    if (await isConnected()) {
      MyResponse response =
          await ApiCall().CallGetAPI(url: ApiParameter.GETARTICALLIST);

      if (response.isSuccess()) {
        List result = response.getDATAJSONArray1()[ApiParameter.data];

        result.forEach((element) {
          articleList.add(TIArticalListModel.fromMap(element));
        });
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }

    TIPrint(
        tag: "Article list length:", value: "${articleList.length.toString()}");
    return articleList;
  }

  // gaiainfo api call
  var gaiaInfo = "".obs;

  Future<MyResponse> getGaiaInfo() async {
    if (await isConnected()) {
      MyResponse response =
          await ApiCall().CallGetAPI(url: ApiParameter.GAIAINFO);

      return response;
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  //get language api call
  var languageList = List<TIMyAccountLanguageModel>.empty().obs;

  Future<List<TIMyAccountLanguageModel>> getLanguageApiCall() async {
    List<TIMyAccountLanguageModel> langList = [];
    if (await isConnected()) {
      MyResponse response =
          await ApiCall().CallGetAPI(url: ApiParameter.GETLANGUAGE);

      if (response.isSuccess()) {
        List result = response.getDATAJSONArray1()[ApiParameter.data];

        result.forEach((element) {
          langList.add(TIMyAccountLanguageModel.fromMap(element));
        });
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }

    TIPrint(
        tag: "Language List length:", value: "${langList.length.toString()}");
    return langList;
  }

  //update language api call
  Future<MyResponse> updateLanguageApiCall(param) async {
    if (await isConnected()) {
      MyResponse response = await ApiCall().CallPostWithParamTokenAPI(
          url: ApiParameter.UPDATELANGUAGE, param: param);

      if (response.isSuccess()) {
        return response;
      } else {
        return response;
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  //delete account api call
  Future<MyResponse> deleteAccountApiCall() async {
    int userId =
        int.parse(MyPreference.getPrefStringValue(key: MyPreference.userId));

    if (await isConnected()) {
      MyResponse response = await ApiCall().CallGetWithTokenAPI(
        ApiParameter.DELETEACCOUNT + "?userId=$userId",
      );

      if (response.isSuccess()) {
        return response;
      } else {
        return response;
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  //sign out api call
//delete account api call
  Future<MyResponse> signOutApiCall(param) async {
    if (await isConnected()) {
      MyResponse response = await ApiCall()
          .CallPostWithParamTokenAPI(url: ApiParameter.SIGNOUT, param: param);

      if (response.isSuccess()) {
        return response;
      } else {
        return response;
      }
    } else {
      MyCommonMethods.showInfoCenterDialog(
          msgContent: "txtNoInternetConnection".tr);
    }
  }

  notificationstatusAPICall(param) async
  {
    if (await isConnected()) {
  MyResponse response = await ApiCall()
      .CallPostWithParamTokenAPI(url: ApiParameter.general_setting, param: param);
  var data = response.getDATAJSONArray1();
  if (response.isSuccess()) {
    MyCommonMethods.showInfoCenterDialog(
        msgContent: data['message']);
  return response;
  } else {
  return null;
  }
  } else {
  MyCommonMethods.showInfoCenterDialog(
  msgContent: "txtNoInternetConnection".tr);
  }
  }
}

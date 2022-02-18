import 'dart:convert';

import 'package:travel_inspiration/APICallServices/ApiParameter.dart';

class MyResponse{
  Map _result;
  int _statusCode;
  //Map mapResult;

  MyResponse(Map result, int statusCode){
    _result = result;
    _statusCode = statusCode;
  }

  getStatusCode(){
    return _statusCode;
  }

  bool isSuccess(){
    return _result[ApiParameter.STATUS]=="success"?true:false;
  }
  String getMessage(){
    return _result[ApiParameter.MESSAGE];
  }
  getDATAJSONArray1(){
    return _result;
  }

  @override
  String toString() {
    return 'ApiResponse{_result: $_result, _statusCode: $_statusCode}';
  }
}
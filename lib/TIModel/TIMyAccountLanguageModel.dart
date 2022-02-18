import 'package:flutter/material.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';

class TIMyAccountLanguageModel{

  int id;
  String language_name,language_code;
  bool isSelected=false;
  Locale local;

  TIMyAccountLanguageModel({this.id,this.isSelected,this.language_code,this.language_name,this.local});

  TIMyAccountLanguageModel.fromMap(Map map){
     id=map[ApiParameter.id];
     language_name=map[ApiParameter.language_name].toString();
     language_code=map[ApiParameter.language_code].toString();

  }
}
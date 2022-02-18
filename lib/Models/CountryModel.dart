
import 'dart:convert';

List<CountryModel> CountryModelFromJson(str) =>
    List<CountryModel>.from(json.decode(str).map((x) => CountryModel.fromJson(x)));

String CountryModelToJson(List<CountryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));



class CountryModel {
  int id;
  String countrycode;
  String countryname;
  String code;

  CountryModel({this.id, this.countrycode, this.countryname, this.code});

  CountryModel.fromJson(Map json) {
    id = json['id'];
    countrycode = json['countrycode'];
    countryname = json['countryname'];
    code = json['code'];
  }

}
import 'dart:convert';

import 'UserInfo.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  UserInfo userInfo = UserInfo();
  String accessToken;
  String mode;

  LoginModel({this.userInfo, this.accessToken,this.mode});

  LoginModel.fromJson(Map<String, dynamic> json) {

    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    accessToken = json['access_token'];
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo.toJson();
    }
    data['access_token'] = this.accessToken;
    data['mode'] = this.mode;
    return data;
  }
}



class AuthInfo {
  int code;
  String status;
  String message;
  Data data;

  AuthInfo({this.code, this.status, this.message, this.data});

  AuthInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
class Data {
  int id;
  String pageTitle;
  String details;

  Data({this.id, this.pageTitle, this.details});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageTitle = json['page_title'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['page_title'] = this.pageTitle;
    data['details'] = this.details;
    return data;
  }
}

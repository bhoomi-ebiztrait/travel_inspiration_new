import 'dart:convert';

/*List<AllProjectModel> AllProjectModelFromJson(str) =>
    List<AllProjectModel>.from(
        json.decode(str).map((x) => AllProjectModel.fromJson(x)));

String AllProjectModelToJson(List<AllProjectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));*/

class AllProjectModel {
  String title;
  String totalKm;
  String modeName;
  String projectMode;
  bool isSelected = false;
  int id;
  String pinDestination = "";

  String projectNoPerson;
  String projectVacationDate;
  String projectDestinationDate;
  // String subprojectName;
  // String subStartVacationDate;
  // String subProjectNoPerson;
  String city;
  String project_image;
  String msg;
  List<TypePin> typePin;
  List<SubProjectDetail> subProjectDetail;

  AllProjectModel(
      {this.id,
      this.title,
      this.totalKm,
      this.modeName,
      this.projectMode,
      this.isSelected = false,
      this.projectNoPerson,
      this.projectVacationDate,
      this.projectDestinationDate,
      // this.subprojectName,
      // this.subStartVacationDate,
      // this.subProjectNoPerson,
      this.city,
      this.project_image,
      this.msg,
      this.pinDestination = "",
        this.subProjectDetail,
      this.typePin});

  AllProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    totalKm = json['totalKm'];
    modeName = json['modeName'];
    projectMode = json['projectMode'];
    projectNoPerson = json['project_no_person'];
    projectVacationDate = json['project_vacation_date'];
    projectDestinationDate = json['project_destination_date'];
    // subprojectName = json['subprojectName'];
    // subStartVacationDate = json['sub_start_vacation_date'];
    // subProjectNoPerson = json['sub_project_no_person'];
    city = json['city'];
    project_image = json['project_image'];
    pinDestination = json['pin_destination'];
    msg = json['msg'];
    if (json['type_pin'] != null) {
      typePin = new List<TypePin>();
      json['type_pin'].forEach((v) {
        typePin.add(new TypePin.fromJson(v));
      });
    }
    if (json['subProjectDetail'] != null) {
      subProjectDetail = <SubProjectDetail>[];
      json['subProjectDetail'].forEach((v) {
        subProjectDetail.add(new SubProjectDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['totalKm'] = this.totalKm;
    data['modeName'] = this.modeName;
    data['projectMode'] = this.projectMode;
    data['project_no_person'] = this.projectNoPerson;
    data['project_vacation_date'] = this.projectVacationDate;
    data['project_destination_date'] = this.projectDestinationDate;
    // data['subprojectName'] = this.subprojectName;
    // data['sub_start_vacation_date'] = this.subStartVacationDate;
    // data['sub_project_no_person'] = this.subProjectNoPerson;
    data['city'] = this.city;
    data['project_image'] = this.project_image;
    data['pin_destination'] = this.pinDestination;
    data['msg'] = this.msg;
    if (this.typePin != null) {
      data['type_pin'] = this.typePin.map((v) => v.toJson()).toList();
    }
    if (this.subProjectDetail != null) {
      data['subProjectDetail'] =
          this.subProjectDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TypePin {
  int id;
  String userId;
  String projectId;
  String placeId;
  String type;
  String title;
  String description;
  String image;
  String rating;

  TypePin(
      {this.id,
      this.userId,
      this.projectId,
      this.placeId,
      this.type,
      this.title,
      this.description,
      this.image,
      this.rating});

  TypePin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    projectId = json['project_id'];
    placeId = json['place_id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['project_id'] = this.projectId;
    data['place_id'] = this.placeId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['rating'] = this.rating;
    return data;
  }
}
class SubProjectDetail {
  int id;
  int userId;
  int projectId;
  String name;
  String startVacationDate;
  int noPerson;
  String city;
  String createdAt;
  String updatedAt;

  SubProjectDetail(
      {this.id,
        this.userId,
        this.projectId,
        this.name,
        this.startVacationDate,
        this.noPerson,
        this.city,
        this.createdAt,
        this.updatedAt});

  SubProjectDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    projectId = json['project_id'];
    name = json['name'];
    startVacationDate = json['start_vacation_date'];
    noPerson = json['no_person'];
    city = json['city'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['project_id'] = this.projectId;
    data['name'] = this.name;
    data['start_vacation_date'] = this.startVacationDate;
    data['no_person'] = this.noPerson;
    data['city'] = this.city;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class UserInfo {
  String userId;
  String dob;
  String userName;
  String email;
  String country;
  String address;
  String city;
  String phoneNo;
  String pincode;
  bool isPremium;
  int age;
  String totalKm;
  int totalNoOfCreatedProject;
  int noOfCreateProjInsp;
  int noOfCreatedProjReflect;
  String avatar;

  UserInfo(
      {this.userId,
        this.dob,
        this.userName,
        this.email,
        this.country,
        this.address,
        this.phoneNo,
        this.city,
        this.pincode,
        this.isPremium,
        this.age,
        this.totalKm,
        this.totalNoOfCreatedProject,
        this.noOfCreateProjInsp,
        this.noOfCreatedProjReflect,
        this.avatar});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    dob = json['dob'];
    userName = json['userName'];
    email = json['email'];
    country = json['country'];
    address = json['address'];
    city = json['city'];
    pincode = json['pincode'];
    phoneNo = json['phoneNo'];
    isPremium = json['isPremium'];
    age = json['age'];
    totalKm = json['totalKm'];
    totalNoOfCreatedProject = json['totalNoOfCreatedProject'];
    noOfCreateProjInsp = json['noOfCreateProjInsp'];
    noOfCreatedProjReflect = json['noOfCreatedProjReflect'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['dob'] = this.dob;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['country'] = this.country;
    data['address'] = this.address;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['phoneNo'] = this.phoneNo;
    data['isPremium'] = this.isPremium;
    data['age'] = this.age;
    data['totalKm'] = this.totalKm;
    data['totalNoOfCreatedProject'] = this.totalNoOfCreatedProject;
    data['noOfCreateProj_insp'] = this.noOfCreateProjInsp;
    data['noOfCreatedProj_reflect'] = this.noOfCreatedProjReflect;
    data['avatar'] = this.avatar;
    return data;
  }
}

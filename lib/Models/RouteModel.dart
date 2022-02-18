class RouteModel {
  int id;
  int userId;
  String originLat;
  String originLng;
  String destLat;
  String destLng;
  String startAddress;
  String endAddress;
  String selectedPlace;
  String createdAt;

  RouteModel(
      {this.id,
        this.userId,
        this.originLat,
        this.originLng,
        this.destLat,
        this.destLng,
        this.startAddress,
        this.endAddress,
        this.selectedPlace,
        this.createdAt});

  RouteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    originLat = json['origin_lat'];
    originLng = json['origin_lng'];
    destLat = json['dest_lat'];
    destLng = json['dest_lng'];
    startAddress = json['start_address'];
    endAddress = json['end_address'];
    selectedPlace = json['selected_place'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['origin_lat'] = this.originLat;
    data['origin_lng'] = this.originLng;
    data['dest_lat'] = this.destLat;
    data['dest_lng'] = this.destLng;
    data['start_address'] = this.startAddress;
    data['end_address'] = this.endAddress;
    data['selected_place'] = this.selectedPlace;
    data['created_at'] = this.createdAt;
    return data;
  }
}
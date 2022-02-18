
class TransportModel {
  int id;
  String projectId;
  String departure;
  String arrival;
  String departDate;
  String arriveDate;
  String airline;
  String ticketNumber;

  TransportModel(
      {this.id,
        this.projectId,
        this.departure,
        this.arrival,
        this.departDate,
        this.arriveDate,
        this.airline,
        this.ticketNumber});

  TransportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['projectId'];
    departure = json['departure'];
    arrival = json['arrival'];
    departDate = json['depart_date'];
    arriveDate = json['arrive_date'];
    airline = json['airline'];
    ticketNumber = json['ticket_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectId'] = this.projectId;
    data['departure'] = this.departure;
    data['arrival'] = this.arrival;
    data['depart_date'] = this.departDate;
    data['arrive_date'] = this.arriveDate;
    data['airline'] = this.airline;
    data['ticket_number'] = this.ticketNumber;
    return data;
  }
}
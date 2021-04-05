class ReservationsModel {
  int status;
  String message;
  Data data;

  ReservationsModel({this.status, this.message, this.data});

  ReservationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

////////////////////////////////////////////////////////////////////////////////
class Data {
  List<Reservations> reservations;

  Data({this.reservations});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['reservations'] != null) {
      reservations = new List<Reservations>();
      json['reservations'].forEach((v) {
        reservations.add(new Reservations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reservations != null) {
      data['reservations'] = this.reservations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////
class Reservations {
  int id;
  String clinic;
  String doctor;
  String date;
  String status;

  Reservations({this.id, this.clinic, this.doctor, this.date, this.status});

  Reservations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinic = json['clinic'];
    doctor = json['doctor'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clinic'] = this.clinic;
    data['doctor'] = this.doctor;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}

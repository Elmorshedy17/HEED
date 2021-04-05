import 'package:heed/src/models/api_models/GET/category_model.dart';

class FavoritesActionsModel {
  int status;
  String message;
  Data data;

  FavoritesActionsModel({this.status, this.message, this.data});

  FavoritesActionsModel.fromJson(Map<String, dynamic> json) {
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

///////////////////////////////////////////////////////////////////////////////////////////////
class Data {
  List<Clinics> clinics;

  Data({this.clinics});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['clinics'] != null) {
      clinics = new List<Clinics>();
      json['clinics'].forEach((v) {
        clinics.add(new Clinics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clinics != null) {
      data['clinics'] = this.clinics.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//class Clinics {
//  int id;
//  String name;
//  String image;
//  String address;
//  String favourite;
//  String s24Hours;
//
//  Clinics(
//      {this.id,
//      this.name,
//      this.image,
//      this.address,
//      this.favourite,
//      this.s24Hours});
//
//  Clinics.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    name = json['name'];
//    image = json['image'];
//    address = json['address'];
//    favourite = json['favourite'];
//    s24Hours = json['24_hours'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['name'] = this.name;
//    data['image'] = this.image;
//    data['address'] = this.address;
//    data['favourite'] = this.favourite;
//    data['24_hours'] = this.s24Hours;
//    return data;
//  }
//}

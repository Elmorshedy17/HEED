import 'package:heed/src/models/api_models/POST/login_model.dart';

class ProfileUpdateModel {
  int status;
  String message;
  Data data;

  ProfileUpdateModel({this.status, this.message, this.data});

  ProfileUpdateModel.fromJson(Map<String, dynamic> json) {
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////
class Data {
  User user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// class User {
//   int id;
//   String name;
//   String email;
//   String phone;
//   String authorization;

//   User({this.id, this.name, this.email, this.phone, this.authorization});

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     authorization = json['authorization'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['authorization'] = this.authorization;
//     return data;
//   }
// }

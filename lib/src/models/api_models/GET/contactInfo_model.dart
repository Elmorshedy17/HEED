class ContactInfoModel {
  int status;
  String message;
  Data data;

  ContactInfoModel({this.status, this.message, this.data});

  ContactInfoModel.fromJson(Map<String, dynamic> json) {
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Data {
  Info info;

  Data({this.info});

  Data.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
class Info {
  String email;
  String phone;
  String mobile;
  String lat;
  String lng;

  Info({this.email, this.phone, this.mobile, this.lat, this.lng});

  Info.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    mobile = json['mobile'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

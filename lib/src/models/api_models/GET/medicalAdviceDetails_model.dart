class MedicalAdviceDetailsModel {
  int status;
  String message;
  Data data;

  MedicalAdviceDetailsModel({this.status, this.message, this.data});

  MedicalAdviceDetailsModel.fromJson(Map<String, dynamic> json) {
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

//////////////////////////////////////////////////////////////////////////////////////////////
class Data {
  MedicalAdvice medicalAdvice;

  Data({this.medicalAdvice});

  Data.fromJson(Map<String, dynamic> json) {
    medicalAdvice = json['medical_advice'] != null
        ? new MedicalAdvice.fromJson(json['medical_advice'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medicalAdvice != null) {
      data['medical_advice'] = this.medicalAdvice.toJson();
    }
    return data;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////
class MedicalAdvice {
  int id;
  String title;
  String desc;
  String image;

  MedicalAdvice({this.id, this.title, this.desc, this.image});

  MedicalAdvice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['image'] = this.image;
    return data;
  }
}

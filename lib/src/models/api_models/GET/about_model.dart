class AboutModel {
  int status;
  String message;
  Data data;

  AboutModel({this.status, this.message, this.data});

  AboutModel.fromJson(Map<String, dynamic> json) {
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

//////////////////////////////////////////////////////////////////////////////////////////
class Data {
  About about;

  Data({this.about});

  Data.fromJson(Map<String, dynamic> json) {
    about = json['about'] != null ? new About.fromJson(json['about']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.about != null) {
      data['about'] = this.about.toJson();
    }
    return data;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////
class About {
  String title;
  String content;

  About({this.title, this.content});

  About.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}

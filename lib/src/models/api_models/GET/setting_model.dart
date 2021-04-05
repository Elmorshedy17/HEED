class SettingModel {
  int status;
  String message;
  Data data;

  SettingModel({this.status, this.message, this.data});

  SettingModel.fromJson(Map<String, dynamic> json) {
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

/////////////////////////////////////////////////////////////////////////////////////////////////
class Data {
  List<Pages> pages;
  List<SocialMedia> socialMedia;

  Data({this.pages, this.socialMedia});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pages'] != null) {
      pages = new List<Pages>();
      json['pages'].forEach((v) {
        pages.add(new Pages.fromJson(v));
      });
    }
    if (json['social_media'] != null) {
      socialMedia = new List<SocialMedia>();
      json['social_media'].forEach((v) {
        socialMedia.add(new SocialMedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pages != null) {
      data['pages'] = this.pages.map((v) => v.toJson()).toList();
    }
    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////
class Pages {
  String title;
  String content;

  Pages({this.title, this.content});

  Pages.fromJson(Map<String, dynamic> json) {
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

/////////////////////////////////////////////////////////////////////////////////////////////////
class SocialMedia {
  int id;
  String name;
  String link;
  String image;

  SocialMedia({this.id, this.name, this.link, this.image});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['link'] = this.link;
    data['image'] = this.image;
    return data;
  }
}

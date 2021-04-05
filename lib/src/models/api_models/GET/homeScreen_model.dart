class HomeScreenModel {
  int status;
  String message;
  Data data;

  HomeScreenModel({this.status, this.message, this.data});

  HomeScreenModel.fromJson(Map<String, dynamic> json) {
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

///////////////////////////////////////////////////////////////////////////
class Data {
  Ads ads;
  List<Slider> slider;
  List<Categories> categories;

  Data({this.ads, this.slider, this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    ads = json['ads'] != null ? new Ads.fromJson(json['ads']) : null;
    if (json['slider'] != null) {
      slider = new List<Slider>();
      json['slider'].forEach((v) {
        slider.add(new Slider.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ads != null) {
      data['ads'] = this.ads.toJson();
    }
    if (this.slider != null) {
      data['slider'] = this.slider.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//////////////////////////////////////////////////////////////////////////////
class Ads {
  String desc;
  int clinicId;
  String image;

  Ads({this.desc, this.clinicId, this.image});

  Ads.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    clinicId = json['clinic_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['clinic_id'] = this.clinicId;
    data['image'] = this.image;
    return data;
  }
}

///////////////////////////////////////////////////////////////////////////
class Slider {
  int id;
  int clinicId;
  String desc;
  String image;

  Slider({this.id, this.clinicId, this.desc, this.image});

  Slider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinicId = json['clinic_id'];
    desc = json['desc'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clinic_id'] = this.clinicId;
    data['desc'] = this.desc;
    data['image'] = this.image;
    return data;
  }
}

/////////////////////////////////////////////////////////////////////
class Categories {
  int id;
  String name;
  String icon;
  String image;

  Categories({this.id, this.name, this.icon, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['image'] = this.image;
    return data;
  }
}

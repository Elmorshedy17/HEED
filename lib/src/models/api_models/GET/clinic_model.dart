class ClinicModel {
  int status;
  String message;
  Data data;

  ClinicModel({this.status, this.message, this.data});

  ClinicModel.fromJson(Map<String, dynamic> json) {
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Data {
  Clinic clinic;
  List<Slider> slider;
  String currency;

  Data({this.clinic, this.slider, this.currency});

  Data.fromJson(Map<String, dynamic> json) {
    clinic =
        json['clinic'] != null ? new Clinic.fromJson(json['clinic']) : null;
    if (json['slider'] != null) {
      slider = new List<Slider>();
      json['slider'].forEach((v) {
        slider.add(new Slider.fromJson(v));
      });
    }
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clinic != null) {
      data['clinic'] = this.clinic.toJson();
    }
    if (this.slider != null) {
      data['slider'] = this.slider.map((v) => v.toJson()).toList();
    }
    data['currency'] = this.currency;
    return data;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Clinic {
  int id;
  String name;
  String image;
  String address;
  String workTimes;
  String knet;
  String cash;
  String latitude;
  String longitude;
  List<Services> services;
  List<IncuranceCompanies> incuranceCompanies;

  Clinic(
      {this.id,
      this.name,
      this.image,
      this.address,
      this.workTimes,
      this.knet,
      this.cash,
      this.latitude,
      this.longitude,
      this.services,
      this.incuranceCompanies});

  Clinic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    address = json['address'];
    workTimes = json['work_times'];
    knet = json['knet'];
    cash = json['cash'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
    if (json['incurance_companies'] != null) {
      incuranceCompanies = new List<IncuranceCompanies>();
      json['incurance_companies'].forEach((v) {
        incuranceCompanies.add(new IncuranceCompanies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['address'] = this.address;
    data['work_times'] = this.workTimes;
    data['knet'] = this.knet;
    data['cash'] = this.cash;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    if (this.incuranceCompanies != null) {
      data['incurance_companies'] =
          this.incuranceCompanies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////
class Services {
  int id;
  String name;
  String image;
  List<Doctors> doctors;

  Services({this.id, this.name, this.image, this.doctors});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['doctors'] != null) {
      doctors = new List<Doctors>();
      json['doctors'].forEach((v) {
        doctors.add(new Doctors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.doctors != null) {
      data['doctors'] = this.doctors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
class Doctors {
  int id;
  String name;
  String specialist;
  String image;
  int price;
  List<Times> times;

  Doctors(
      {this.id,
      this.name,
      this.specialist,
      this.image,
      this.price,
      this.times});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    specialist = json['specialist'];
    image = json['image'];
    price = json['price'];
    if (json['times'] != null) {
      times = new List<Times>();
      json['times'].forEach((v) {
        times.add(new Times.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['specialist'] = this.specialist;
    data['image'] = this.image;
    data['price'] = this.price;
    if (this.times != null) {
      data['times'] = this.times.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////
class Times {
  String day;
  List<String> times;

  Times({this.day, this.times});

  Times.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    times = json['times'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['times'] = this.times;
    return data;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////
class IncuranceCompanies {
  int id;
  String name;
  String image;

  IncuranceCompanies({this.id, this.name, this.image});

  IncuranceCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

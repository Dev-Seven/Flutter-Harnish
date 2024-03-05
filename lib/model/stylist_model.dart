import 'package:harnishsalon/model/package_model.dart';

class StylistModel {
  String sId;
  String firstName;
  String lastName;
  String name;
  String email;
  String phoneNumber;
  String dob;
  String gender;
  String location;
  String latitude;
  String longitude;
  String designation;
  String timeSchedule;
  String city;
  String otp;
  int status;
  String parentId;
  String salonId;
  int ratings;
  String totalRevenue;
  int role;
  String image;
  String updatedAt;
  String createdAt;
  String token;
  int activationStatus;

  StylistModel({
    this.sId,
    this.firstName,
    this.lastName,
    this.name,
    this.email,
    this.phoneNumber,
    this.dob,
    this.gender,
    this.location,
    this.latitude,
    this.longitude,
    this.designation,
    this.timeSchedule,
    this.city,
    this.otp,
    this.status,
    this.parentId,
    this.salonId,
    this.ratings,
    this.totalRevenue,
    this.role,
    this.image,
    this.updatedAt,
    this.createdAt,
    this.token,
    this.activationStatus,
  });

  StylistModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    dob = json['dob'];
    gender = json['gender'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    designation = json['designation'];
    timeSchedule = json['time_schedule'];
    city = json['city'];
    otp = json['otp'];
    status = json['status'];
    parentId = json['parent_id'];
    salonId = json['salon_id'];
    ratings = json['ratings'];
    totalRevenue = json['total_revenue'];
    role = json['role'];
    image = json['image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    token = json['token'];
    activationStatus = json['activation_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['designation'] = this.designation;
    data['time_schedule'] = this.timeSchedule;
    data['city'] = this.city;
    data['otp'] = this.otp;
    data['status'] = this.status;
    data['parent_id'] = this.parentId;
    data['salon_id'] = this.salonId;
    data['ratings'] = this.ratings;
    data['total_revenue'] = this.totalRevenue;
    data['role'] = this.role;
    data['image'] = this.image;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['token'] = this.token;
    data['activation_status'] = this.activationStatus;

    return data;
  }
}

class SalonDetail {
  String sId;
  String salonName;
  String ownerName;
  String userId;
  Null email;
  String phoneNumber;
  String address;
  String city;
  String type;
  int status;
  int ratings;
  int totalRevenue;
  String updatedAt;
  String createdAt;
  String area;
  String latitude;
  String longitude;
  String state;
  String towerName;

  SalonDetail(
      {this.sId,
      this.salonName,
      this.ownerName,
      this.userId,
      this.email,
      this.phoneNumber,
      this.address,
      this.city,
      this.type,
      this.status,
      this.ratings,
      this.totalRevenue,
      this.updatedAt,
      this.createdAt,
      this.area,
      this.latitude,
      this.longitude,
      this.state,
      this.towerName});

  SalonDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    salonName = json['salon_name'];
    ownerName = json['owner_name'];
    userId = json['user_id'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    city = json['city'];
    type = json['type'];
    status = json['status'];
    ratings = json['ratings'];
    totalRevenue = json['total_revenue'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    area = json['area'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    state = json['state'];
    towerName = json['tower_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['salon_name'] = this.salonName;
    data['owner_name'] = this.ownerName;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    data['type'] = this.type;
    data['status'] = this.status;
    data['ratings'] = this.ratings;
    data['total_revenue'] = this.totalRevenue;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['area'] = this.area;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['state'] = this.state;
    data['tower_name'] = this.towerName;
    return data;
  }
}

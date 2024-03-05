import 'package:harnishsalon/model/salon_images_model.dart';
import 'package:harnishsalon/model/salon_services_model.dart';
import 'package:harnishsalon/model/stylist_model.dart';

class UserSalonModel {
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
  String totalRevenue;
  String updatedAt;
  String createdAt;
  String area;
  String latitude;
  String longitude;
  String state;
  String towerName;
  List<SalonImagesModel> salonImages;
  List<SalonServiceModel> services;
  List<StylistModel> employee;

  UserSalonModel(
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
      this.towerName,
      this.salonImages,
      this.services,
      this.employee});

  UserSalonModel.fromJson(Map<String, dynamic> json) {
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
    if (json['salon_images'] != null) {
      salonImages = new List<SalonImagesModel>();
      json['salon_images'].forEach((v) {
        salonImages.add(new SalonImagesModel.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = new List<SalonServiceModel>();
      json['services'].forEach((v) {
        services.add(new SalonServiceModel.fromJson(v));
      });
    }
    if (json['employee'] != null) {
      employee = new List<StylistModel>();
      json['employee'].forEach((v) {
        employee.add(new StylistModel.fromJson(v));
      });
    }
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
    if (this.salonImages != null) {
      data['salon_images'] = this.salonImages.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    if (this.employee != null) {
      data['employee'] = this.employee.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



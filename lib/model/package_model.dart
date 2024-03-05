import 'package:harnishsalon/model/package_service_model.dart';

class PackageModel {
  String sId;
  String name;
  String price;
  String discount;
  String userId;
  int serviceCount;
  String salonId;
  String updatedAt;
  String createdAt;
  SalonDetail salonDetail;
  List<PackageServiceModel> services;

  PackageModel(
      {this.sId,
      this.name,
      this.price,
      this.discount,
      this.userId,
      this.serviceCount,
      this.salonId,
      this.updatedAt,
      this.createdAt,
      this.salonDetail,
      this.services});

  PackageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    userId = json['user_id'];
    serviceCount = json['service_count'];
    salonId = json['salon_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    salonDetail = json['salon_detail'] != null
        ? new SalonDetail.fromJson(json['salon_detail'])
        : null;
    if (json['services'] != null) {
      services = new List<Null>();
      json['services'].forEach((v) {
        services.add(new PackageServiceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['user_id'] = this.userId;
    data['service_count'] = this.serviceCount;
    data['salon_id'] = this.salonId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    if (this.salonDetail != null) {
      data['salon_detail'] = this.salonDetail.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
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
  String totalRevenue;
  String updatedAt;
  String createdAt;
  String area;
  String latitude;
  String longitude;
  String state;
  String towerName;
  String nearBy;

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
      this.towerName,
      this.nearBy});

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
    nearBy = json['near_by'];
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
    data['near_by'] = this.nearBy;
    return data;
  }
}
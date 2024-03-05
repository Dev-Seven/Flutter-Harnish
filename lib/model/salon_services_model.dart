class SalonServiceModel {
  String sId;
  String userId;
  String salonId;
  String serviceId;
  String serviceName;
  String servicePrice;
  String updatedAt;
  String createdAt;

  SalonServiceModel(
      {this.sId,
      this.userId,
      this.salonId,
      this.serviceId,
      this.serviceName,
      this.servicePrice,
      this.updatedAt,
      this.createdAt});

  SalonServiceModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    salonId = json['salon_id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    servicePrice = json['service_price'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['salon_id'] = this.salonId;
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    data['service_price'] = this.servicePrice;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }

  @override
  String toString() {
    return 'SalonServiceModel{sId: $sId, userId: $userId, salonId: $salonId, serviceId: $serviceId, serviceName: $serviceName, servicePrice: $servicePrice, updatedAt: $updatedAt, createdAt: $createdAt}';
  }
}

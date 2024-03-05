class SalonTimingModel {
  String sId;
  String salonId;
  String userId;
  String weekDay;
  String status;
  String openingTime;
  String closingTime;
  String updatedAt;
  String createdAt;

  SalonTimingModel({
    this.sId,
    this.salonId,
    this.userId,
    this.weekDay,
    this.status,
    this.openingTime,
    this.closingTime,
    this.updatedAt,
    this.createdAt,
  });

  SalonTimingModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    salonId = json['salon_id'];
    userId = json['user_id'];
    weekDay = json['week_day'];
    status = json['status'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['salon_id'] = this.salonId;
    data['user_id'] = this.userId;
    data['week_day'] = this.weekDay;
    data['status'] = this.status;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

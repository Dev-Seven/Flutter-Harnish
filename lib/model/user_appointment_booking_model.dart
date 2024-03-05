class AppointmentBookingModel {
  String sId;
  String salonId;
  String employeeId;
  String userId;
  String time;
  String date;
  String dateTime;
  int notificationTenMinutes;
  int notificationAnHour;
  int status;
  String updatedAt;
  String createdAt;
  int adminCommission;
  Salon salon;
  List<AppointmentServices> appointmentServices;

  AppointmentBookingModel(
      {this.sId,
      this.salonId,
      this.employeeId,
      this.userId,
      this.time,
      this.date,
      this.dateTime,
      this.notificationTenMinutes,
      this.notificationAnHour,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.adminCommission,
      this.salon,
      this.appointmentServices});

  AppointmentBookingModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    salonId = json['salon_id'];
    employeeId = json['employee_id'];
    userId = json['user_id'];
    time = json['time'];
    date = json['date'];
    dateTime = json['date_time'];
    notificationTenMinutes = json['notification_ten_minutes'];
    notificationAnHour = json['notification_an_hour'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    adminCommission = json['admin_commission'];
    salon = json['salon'] != null ? new Salon.fromJson(json['salon']) : null;
    if (json['appointment_services'] != null) {
      appointmentServices = new List<AppointmentServices>();
      json['appointment_services'].forEach((v) {
        appointmentServices.add(new AppointmentServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['salon_id'] = this.salonId;
    data['employee_id'] = this.employeeId;
    data['user_id'] = this.userId;
    data['time'] = this.time;
    data['date'] = this.date;
    data['date_time'] = this.dateTime;
    data['notification_ten_minutes'] = this.notificationTenMinutes;
    data['notification_an_hour'] = this.notificationAnHour;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['admin_commission'] = this.adminCommission;
    if (this.salon != null) {
      data['salon'] = this.salon.toJson();
    }
    if (this.appointmentServices != null) {
      data['appointment_services'] =
          this.appointmentServices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Salon {
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

  Salon(
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

  Salon.fromJson(Map<String, dynamic> json) {
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

class AppointmentServices {
  String sId;
  String appointmentId;
  String dataId;
  String price;
  String name;
  String salonId;
  String userId;
  String employeeId;
  String type;
  String updatedAt;
  String createdAt;

  AppointmentServices(
      {this.sId,
      this.appointmentId,
      this.dataId,
      this.price,
      this.name,
      this.salonId,
      this.userId,
      this.employeeId,
      this.type,
      this.updatedAt,
      this.createdAt});

  AppointmentServices.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    appointmentId = json['appointment_id'];
    dataId = json['data_id'];
    price = json['price'];
    name = json['name'];
    salonId = json['salon_id'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    type = json['type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['appointment_id'] = this.appointmentId;
    data['data_id'] = this.dataId;
    data['price'] = this.price;
    data['name'] = this.name;
    data['salon_id'] = this.salonId;
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
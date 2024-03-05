class AppointmentModel {
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
  double adminCommission;
  Salon salon;
  Stylist stylist;
  List<AppointmentServices> appointmentServices;
  Customer customer;

  AppointmentModel(
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
      this.stylist,
      this.appointmentServices,
      this.customer});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
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
    stylist =
        json['stylist'] != null ? new Stylist.fromJson(json['stylist']) : null;
    if (json['appointment_services'] != null) {
      appointmentServices = new List<AppointmentServices>();
      json['appointment_services'].forEach((v) {
        appointmentServices.add(new AppointmentServices.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
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
    if (this.stylist != null) {
      data['stylist'] = this.stylist.toJson();
    }
    if (this.appointmentServices != null) {
      data['appointment_services'] =
          this.appointmentServices.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
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

class Stylist {
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
  Null otp;
  int status;
  String parentId;
  String salonId;
  int ratings;
  String totalRevenue;
  int role;
  String image;
  String updatedAt;
  String createdAt;
  int activationStatus;

  Stylist(
      {this.sId,
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
      this.activationStatus});

  Stylist.fromJson(Map<String, dynamic> json) {
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
    data['activation_status'] = this.activationStatus;
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

class Customer {
  String sId;
  String firstName;
  Null lastName;
  String name;
  String phoneNumber;
  Null password;
  int role;
  int status;
  int confirmed;
  Null image;
  String otp;
  Null dob;
  Null gender;
  Null city;
  int rating;
  int activationStatus;
  String updatedAt;
  String createdAt;

  Customer(
      {this.sId,
      this.firstName,
      this.lastName,
      this.name,
      this.phoneNumber,
      this.password,
      this.role,
      this.status,
      this.confirmed,
      this.image,
      this.otp,
      this.dob,
      this.gender,
      this.city,
      this.rating,
      this.activationStatus,
      this.updatedAt,
      this.createdAt});

  Customer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    role = json['role'];
    status = json['status'];
    confirmed = json['confirmed'];
    image = json['image'];
    otp = json['otp'];
    dob = json['dob'];
    gender = json['gender'];
    city = json['city'];
    rating = json['rating'];
    activationStatus = json['activation_status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['password'] = this.password;
    data['role'] = this.role;
    data['status'] = this.status;
    data['confirmed'] = this.confirmed;
    data['image'] = this.image;
    data['otp'] = this.otp;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['rating'] = this.rating;
    data['activation_status'] = this.activationStatus;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
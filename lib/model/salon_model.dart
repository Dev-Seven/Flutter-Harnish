class SalonModel {
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
  String city;
  int rating;
  int activationStatus;
  String updatedAt;
  String createdAt;
  int parentId;
  String salonId;
  String token;

  SalonModel(
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
      this.createdAt,
      this.parentId,
      this.salonId,
      this.token});

  SalonModel.fromJson(Map<String, dynamic> json) {
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
    parentId = json['parent_id'];
    salonId = json['salon_id'];
    token = json['token'];
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
    data['parent_id'] = this.parentId;
    data['salon_id'] = this.salonId;
    data['token'] = this.token;
    return data;
  }
}

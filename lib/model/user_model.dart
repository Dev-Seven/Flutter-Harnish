class UserModel {
  int id;
  String firstName;
  String lastName;
  String name;
  String email;
  String emailVerifiedAt;
  String password;
  String rememberToken;
  int role;
  String companyName;
  String address;
  String latitude;
  String longitude;
  String city;
  String state;
  String zipCode;
  String about;
  String otp;
  String phone;
  String image;
  String googleId;
  String stripeCustomerId;
  String stripeBankAccountId;
  String routingNumber;
  String accountNumber;
  String accountHolderName;
  String accountHolderType;
  String accountStatus;
  int status;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String token;
  String subscriptionStatus;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.rememberToken,
      this.role,
      this.companyName,
      this.address,
      this.latitude,
      this.longitude,
      this.city,
      this.state,
      this.zipCode,
      this.about,
      this.otp,
      this.phone,
      this.image,
      this.googleId,
      this.stripeCustomerId,
      this.stripeBankAccountId,
      this.routingNumber,
      this.accountNumber,
      this.accountHolderName,
      this.accountHolderType,
      this.accountStatus,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.token,
      this.subscriptionStatus});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    rememberToken = json['remember_token'];
    role = json['role'];
    companyName = json['company_name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    about = json['about'];
    otp = json['otp'];
    phone = json['phone'];
    image = json['image'];
    googleId = json['google_id'];
    stripeCustomerId = json['stripe_customer_id'];
    stripeBankAccountId = json['stripe_bank_account_id'];
    routingNumber = json['routing_number'];
    accountNumber = json['account_number'];
    accountHolderName = json['account_holder_name'];
    accountHolderType = json['account_holder_type'];
    accountStatus = json['account_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    token = json['token'];
    subscriptionStatus = json["subscription_status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['remember_token'] = this.rememberToken;
    data['role'] = this.role;
    data['company_name'] = this.companyName;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['about'] = this.about;
    data['otp'] = this.otp;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['google_id'] = this.googleId;
    data['stripe_customer_id'] = this.stripeCustomerId;
    data['stripe_bank_account_id'] = this.stripeBankAccountId;
    data['routing_number'] = this.routingNumber;
    data['account_number'] = this.accountNumber;
    data['account_holder_name'] = this.accountHolderName;
    data['account_holder_type'] = this.accountHolderType;
    data['account_status'] = this.accountStatus;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['token'] = this.token;
    return data;
  }
}

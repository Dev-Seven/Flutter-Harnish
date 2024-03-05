class SalonImagesModel {
  String sId;
  String name;
  String userId;
  String type;
  String updatedAt;
  String createdAt;

  SalonImagesModel(
      {this.sId,
      this.name,
      this.userId,
      this.type,
      this.updatedAt,
      this.createdAt});

  SalonImagesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    userId = json['user_id'];
    type = json['type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

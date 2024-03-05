class PackageServiceModel {
  String sId;
  String name;
  int status;
  String updatedAt;
  String createdAt;

  PackageServiceModel({
    this.sId,
    this.name,
    this.status,
    this.updatedAt,
    this.createdAt,
  });

  PackageServiceModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class SuppportDataModel {
  String sId;
  String name;
  String type;
  String updatedAt;
  String createdAt;

  SuppportDataModel(
      {this.sId, this.name, this.type, this.updatedAt, this.createdAt});

  SuppportDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
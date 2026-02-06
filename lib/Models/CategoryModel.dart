class CategoryModel {
  String? sId;
  String? categoryName;
  String? merchantId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryModel(
      {this.sId,
        this.categoryName,
        this.merchantId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['categoryName'];
    merchantId = json['merchantId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryName'] = categoryName;
    data['merchantId'] = merchantId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
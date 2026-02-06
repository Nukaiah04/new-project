class ItemModels {
  String? sId;
  String? productName;
  String? categoryId;
  String? merchantId;
  String? image;
  var price;
  bool? isAvailable;
  String? createdAt;
  String? updatedAt;
  int qty = 1;
  int? total;

  ItemModels(
      {this.sId,
      this.productName,
      this.categoryId,
      this.merchantId,
      this.image,
      this.price,
      this.isAvailable,
      this.createdAt,
      this.updatedAt,
      required this.qty,
      this.total});

  ItemModels.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    categoryId = json['categoryId'];
    merchantId = json['merchantId'];
    image = json['image'];
    price = json['price'];
    isAvailable = json['isAvailable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    qty = 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['productName'] = productName;
    data['categoryId'] = categoryId;
    data['merchantId'] = merchantId;
    data['image'] = image;
    data['price'] = price;
    data['isAvailable'] = isAvailable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['qty'] = qty;
    return data;
  }
}

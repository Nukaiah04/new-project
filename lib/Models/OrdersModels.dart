class OrdersGetAllModels {
  String? sId;
  int? totalAmount;
  String? paymentType;
  String? merchantId;
  List<Items>? items;
  String? orderDate;
  int? iV;

  OrdersGetAllModels(
      {this.sId,
        this.totalAmount,
        this.paymentType,
        this.merchantId,
        this.items,
        this.orderDate,
        this.iV});

  OrdersGetAllModels.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalAmount = json['totalAmount'];
    paymentType = json['paymentType'];
    merchantId = json['merchantId'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    orderDate = json['orderDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['totalAmount'] = this.totalAmount;
    data['paymentType'] = this.paymentType;
    data['merchantId'] = this.merchantId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['orderDate'] = this.orderDate;
    data['__v'] = this.iV;
    return data;
  }
}

class Items {
  String? itemId;
  int? count;
  int? itemCost;
  String? sId;

  Items({this.itemId, this.count, this.itemCost, this.sId});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    count = json['count'];
    itemCost = json['itemCost'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['count'] = this.count;
    data['itemCost'] = this.itemCost;
    data['_id'] = this.sId;
    return data;
  }
}

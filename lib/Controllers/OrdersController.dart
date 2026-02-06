import 'package:flutter/cupertino.dart';
import 'package:merchant_bill/Constants/ApiFunctions.dart';
import 'package:merchant_bill/Models/OrdersModels.dart';

class OrdersController extends ChangeNotifier{
  Future<void> saveOrder({postJson})async{
    final response = await ApiMethods.postMethod(endpoint: "endpoint", postJson: postJson);
    if(response!=null&&response["status"]==true){}
    else{}
  }

  List<OrdersGetAllModels> _ordersList = [];
  List<OrdersGetAllModels> get ordersList =>[..._ordersList];
  Future<void> getAllOrders()async{
    final response = await ApiMethods.getMethod(endpoint: "order/getAll");
    if(response!=null&&response["status"]==true){
      final ordersData = response["data"];
      _ordersList = ordersData == null
          ? []
          : List<OrdersGetAllModels>.from(
          ordersData.map((e) => OrdersGetAllModels.fromJson(e)));
    }
    else{
      _ordersList = [];
    }
    notifyListeners();
  }

}
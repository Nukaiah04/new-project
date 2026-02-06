import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merchant_bill/Constants/ApiFunctions.dart';
import 'package:merchant_bill/Constants/AppColors.dart';
import 'package:merchant_bill/Controllers/AuthenticationController.dart';
import 'package:merchant_bill/Models/ItemsModels.dart';

class ItemsController extends ChangeNotifier {

  bool createLoad = false;
  Future<void> CreateItem(context, {postJson}) async {
    createLoad = true;
    notifyListeners();
    final response = await ApiMethods.postMethod(
        endpoint: "product/create", postJson: postJson);
    if (response != null && response["status"] == true) {
      WebToast.show(context,
          message: "Item Created Successfully", color: appColor);
      GetAllItems();
      Navigator.pop(context);
    } else {
      WebToast.show(context, message: "Item Created Failed", color: Colors.red);
    }
    createLoad = false;
    notifyListeners();
  }

  List<ItemModels> _itemsList = [];

  List<ItemModels> get itemsList => [..._itemsList];

  List<ItemModels> _dashboardItemsList = [];

  List<ItemModels> get dashboardItemsList => [..._dashboardItemsList];

  Future<void> GetAllItems() async {
    final response = await ApiMethods.getMethod(endpoint: "product/getAll");

    if (response != null && response["status"] == true) {
      final itemData = response["data"];
      _dashboardItemsList = _itemsList = itemData == null
          ? []
          : List<ItemModels>.from(itemData.map((e) => ItemModels.fromJson(e)));
    } else {
      _itemsList = _dashboardItemsList = [];
    }
    notifyListeners();
  }

  FilterItems({value}) {
    _dashboardItemsList = _itemsList
        .where((e) => e.categoryId.toString() == value.toString())
        .toList();
    notifyListeners();
  }

  List<ItemModels> _cartList = [];
  List<ItemModels> get cartList => [..._cartList];

  AddtoCart({required ItemModels itemModels}) {
    if (_cartList.contains(itemModels)) {
    } else {
      _cartList.add(itemModels);
    }
    notifyListeners();
  }

  RemoveCart({value}) {
    for (var item in _cartList) {
      if (item.sId.toString() == value.toString()) {
        item.qty = 1;
        _cartList.removeWhere((e) => e.sId.toString() == value.toString());
        break;
      }
    }
    notifyListeners();
  }

  void increaseItemCount(List<ItemModels> myCartList, String value) {
    for (var item in myCartList) {
      if (item.sId.toString() == value.toString()) {
        item.qty++; // Increase the count
        break; // Stop after finding the first match (optional)
      }
    }
    notifyListeners();
  }

  DecreaseCount(List<ItemModels> myCartList, String value) {
    for (var item in myCartList) {
      if (item.sId.toString() == value.toString()) {
        if (item.qty > 1) {
          item.qty--;
        } else {}
        break; // Stop after finding the first match (optional)
      }
    }
    notifyListeners();
  }

  double calculateTotalSum(List<ItemModels> items) {
    double sum = 0.0;
    for (var item in items) {
      sum += double.parse(item.qty.toString()) *
          double.parse(item.price.toString());
    }
    return sum;
  }
}

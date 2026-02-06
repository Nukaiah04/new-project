import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_bill/Constants/ApiFunctions.dart';
import 'package:merchant_bill/Constants/AppColors.dart';
import 'package:merchant_bill/Controllers/AuthenticationController.dart';
import 'package:merchant_bill/Models/CategoryModel.dart';
import 'package:provider/provider.dart';

class CategoryController extends ChangeNotifier {
  var categoryId;

  ChangeCat({value}) {
    categoryId = value;
    notifyListeners();
  }

  List<CategoryModel> _categorylist = [];

  List<CategoryModel> get categorylist => [..._categorylist];

  Future<void> GetAllCategory() async {
    final response = await ApiMethods.postMethod(
        endpoint: "category/getCategory", postJson: {});
    if (response != null && response["status"] == true) {
      final catData = response["data"];
      _categorylist = catData == null
          ? []
          : List<CategoryModel>.from(
              catData.map((e) => CategoryModel.fromJson(e)));
    } else {
      _categorylist = [];
    }
    notifyListeners();
  }

  bool createLoad = false;

  Future<void> CreateCategory(context, {required String categoryName}) async {
    createLoad = true;
    notifyListeners();
    final response = await ApiMethods.postMethod(endpoint: "category/create", postJson: {"categoryName": categoryName});
    log(response.toString());
    if(response!=null&& response["status"]==true){
      Navigator.pop(context);
      GetAllCategory();
      WebToast.show(context, message: response["message"], color: appColor);
    }
    else{
      WebToast.show(context, message:response["message"], color: Colors.red);
    }
    createLoad = false;
    notifyListeners();
  }
}

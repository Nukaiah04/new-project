import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Urls {
  static String baseUrl = "http://localhost:3000/api/";
}

class ApiMethods {
  static const jsonHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };

  static headers1({required usertoken}) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $usertoken',
      };

  static var token;
  static var userId;
  static var roleId;

  static Future<void> getKeys() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    userId = sharedPreferences.getString("_id");
    roleId = sharedPreferences.getInt("roleId");
  }

  static getMethod({required endpoint}) async {
    try {
      Uri url = Uri.parse(Urls.baseUrl + endpoint);
      final response = await http.get(url, headers: headers1(usertoken: token));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      }
    } on Exception {
      return null;
    }
  }

  static postMethod({required endpoint, required postJson}) async {
    try {
      Uri url = Uri.parse(Urls.baseUrl + endpoint);
      final response = await http.post(url,
          headers: headers1(usertoken: token), body: jsonEncode(postJson));
      log(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        return responseData;
      }
    } on Exception {
      return null;
    }
  }

  static loginMethod({required endpoint, required postJson}) async {
    try {
      Uri url = Uri.parse(Urls.baseUrl + endpoint);
      final response = await http.post(url,
          body: jsonEncode(postJson), headers: jsonHeaders);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      }
    } on Exception {
      return null;
    }
  }
}

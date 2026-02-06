import 'dart:convert';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merchant_bill/Constants/ApiFunctions.dart';
import 'package:merchant_bill/Constants/AppColors.dart';
import 'package:merchant_bill/Constants/TextStyles.dart';
import 'package:merchant_bill/Constants/Urls.dart';
import 'package:merchant_bill/Views/LandingView.dart';
import 'package:merchant_bill/Views/LoginView.dart';
import 'package:shared_preferences/shared_preferences.dart';

String eMessage =
    "Check Internet connection\nSomething went wrong try again after some time !";

class AuthenticationController extends ChangeNotifier {
  /// User Login Function is Here..........>>>

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> Login(context, {postJson}) async {
    try {
      _isLoading = true;
      notifyListeners();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var response = await ApiMethods.loginMethod(endpoint: "merchant/login", postJson: postJson);
      if(response!=null){
        log(response.toString());
        var userData = response["data"];
        if(userData["status"]=="ACTIVE"){
          await sharedPreferences.setString("token", response["token"]);
          await sharedPreferences.setString("_id", userData["_id"]);
          await sharedPreferences.setInt("roleId", userData["roleId"]);
          Navigator.push(context, MaterialPageRoute(builder: (_)=>const LandingView()));
        }
        else{
          WebToast.show(context, message: "Account is not active", color: Colors.red);
        }
      }
      else {
        WebToast.show(context, message: "Something went wrong try again", color: Colors.red);
      }
      _isLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      WebToast.show(context, message: e.toString(), color: Colors.red);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> LogoUt(context)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginView()), (route)=>false);
  }

  var image;
  var filename;

  Future<void> OpenFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['jpg', 'png', 'jpeg'], type: FileType.custom);
    if (result != null) {
      final bytes = result.files.single.bytes;
      image = bytes;
      filename = result.files.single.name;
    } else {}
    notifyListeners();
  }

  Future<void> ClearImageData()async{
    image=null;
    filename=null;
    notifyListeners();
  }
}

class WebToast {
  static void show(BuildContext context,
      {required String message, color = Colors.black}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        right: 20,
        child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      message,
                      style: TxtStls.whistle,
                      softWrap: true, // Allow text to wrap within the container
                    ),
                  ),
                ],
              ),
            )),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3)).then((value) {
      overlayEntry.remove();
    });
  }
}

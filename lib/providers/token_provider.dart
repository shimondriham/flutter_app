import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Token with ChangeNotifier {
  String _token = "";

  String get token => _token;

  void newToken(String token) {
    _token = token;
    notifyListeners();
  }

  void deleteToken() {
    _token = "";
    notifyListeners();
  }

  bool isVlidToken() {
    if (_token != "" && !JwtDecoder.isExpired(_token)) {
      return true;
    }
    return false;
  }

  //  retutn name / email frome token 
  String userTokenDetails(String type) {
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(_token);
    final userDetails = decodedToken[type];
    print(decodedToken["exp"]);// ignore: avoid_print
    print(decodedToken["iat"]);// ignore: avoid_print
    // print(decodedToken["email"]); // ignore: avoid_print
    // print(decodedToken["name"]);// ignore: avoid_print
    // print(decodedToken['phone_number']);// ignore: avoid_print
    return userDetails;
  }
}

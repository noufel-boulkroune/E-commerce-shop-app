import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiredDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    if (token != null) {
      return true;
    }
    return false;
  }

  String? get userId {
    return _userId;
  }

  String? get token {
    if (_expiredDate != null &&
        _expiredDate!.isAfter(DateTime.now()) &&
        _token != "" &&
        _token != null) {
      return _token;
    }
    return null;
  }

  static const String firebaseApiKey =
      "AIzaSyCEwjICYw5fXf9TMGrr03RI1NC6UHkOS70";

  Future<void> _authonticate(
      String email, String password, String authonticationType) async {
    try {
      print("dsfsdf");
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:$authonticationType?key=$firebaseApiKey');

      final response = await http.post(
        url,
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}),
      );
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiredDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData["expiresIn"])));
      _autoLogout();
      notifyListeners();
      final preferences = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": _userId,
        "expiryDate": _expiredDate?.toIso8601String()
      });
      preferences.setString("userPrefs", userData);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey("userPrefs")) {
      return false;
    }
    final extractedUserData =
        json.decode(preferences.getString("userPrefs") as String)
            as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData["expiryDate"]);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData["token"] as String;
    _userId = extractedUserData["userId"] as String;
    _expiredDate = DateTime.parse(extractedUserData["expiryDate"]);
    notifyListeners();
    _autoLogout();

    return true;
  }

  Future<void> signup(String email, String password, returnSecureToken) async {
    print(isAuth);
    return _authonticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authonticate(email, password, "signInWithPassword");
  }

  Future<void> logout() async {
    _token = "";
    _userId = "";
    _expiredDate = null;
    notifyListeners();
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
      notifyListeners();
    }
    notifyListeners();
    final prefrences = await SharedPreferences.getInstance();
    //prefs.remove('userData');
    //this ^ removes only userData but since thats the only thing being stored we can just use clear
    prefrences.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiredDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}

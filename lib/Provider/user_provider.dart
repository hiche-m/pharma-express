import 'dart:convert';

import 'package:code/Models/user_object.dart';
import 'package:code/Services/http_requests.dart';
import 'package:code/Utils/fake_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserObj? _currentUser;
  UserObj? get currentUser => _currentUser;

  void updateUserValue(UserObj user) {
    _currentUser = user;
    notifyListeners();
  }

  bool isLoading = true;

  Future fetchUser({bool devMode = false}) async {
    if (devMode) {
      await Future.delayed(const Duration(seconds: 2));

      _currentUser = UserObj.fromMap(FakeData.userInfo);
      isLoading = false;
      notifyListeners();

      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? userToken = prefs.getString('authToken');

    if (userToken == null) {
      print("No token found, please log in or create an account.");
    } else {
      try {
        final response = await http.get(
          Uri.parse('${HttpRequests.host}/api/confirmation/:$userToken'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 500) {
          final responseData = jsonDecode(response.body);
          print(responseData);
          // Create user value
          // currentUser = smthn
          // notify listeners
        }
      } on Exception catch (e) {
        print(e.toString());
      }
    }
    isLoading = false;
    notifyListeners();
    return;
  }

  void disconnect() async {
    isLoading = true;
    notifyListeners();
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('authToken');

      _currentUser = null;
    } on Exception catch (e) {
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
    print("User disconnected.");
  }
}

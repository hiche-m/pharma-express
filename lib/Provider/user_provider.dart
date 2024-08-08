import 'package:code/Models/user_object.dart';
import 'package:code/Utils/fake_data.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserObj? currentUser;
  bool isLoading = true;

  void fetchUser() async {
    try {
      throw Exception(
          "User Token is expired! please sign in or create a new account.\n\n");
      await Future.delayed(const Duration(milliseconds: 500));
      currentUser = UserObj.fromMap(FakeData.userInfo);
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
    isLoading = false;
  }

  void disconnect() async {
    isLoading = true;
    notifyListeners();
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      currentUser = null;
    } on Exception catch (e) {
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
    print("User disconnected.");
  }
}

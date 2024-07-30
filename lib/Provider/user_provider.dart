import 'package:code/Models/user_object.dart';
import 'package:code/Utils/fake_data.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserObj? currentUser;

  void fetchUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    currentUser = UserObj.fromMap(FakeData.userInfo);
    notifyListeners();
  }

  void disconnect() async {
    await Future.delayed(const Duration(milliseconds: 800));
    currentUser = null;
    notifyListeners();
    print("User disconnected.");
  }
}

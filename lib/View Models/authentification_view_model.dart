import 'package:code/Models/phone_local.dart';
import 'package:code/Utils/fake_data.dart';
import 'package:flutter/material.dart';

class AuthVM {
  static int pageIndex = 0;
  static var controller = PageController(initialPage: pageIndex);
  static List<PhoneLocal> countryLocals = [];
  static bool loadingLocals = true;

  static var loginKey = GlobalKey<FormState>();
  static var signupKey = GlobalKey<FormState>();

  static void togglePage() {
    int newIndex = pageIndex == 0 ? 1 : 0;
    controller.animateToPage(newIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    pageIndex = newIndex;
  }

  static Future<List<PhoneLocal>> getLocals() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return FakeData.supportedLocales;
  }
}

import 'dart:developer';

import 'package:code/Models/user_object.dart';
import 'package:code/Provider/user_provider.dart';
import 'package:code/Services/http_requests.dart';
import 'package:code/Utils/parameters.dart';
import 'package:code/Utils/text_formulations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future logIn(BuildContext context, String id, String password) async {
    log("Logging in...");
    var response = await HttpRequests.userLogin(id, password);
    log("RESPONSE: $response");

    if (response is! String) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', response['token']);
      Map userMap = response['data'][0];
      print(userMap["phoneNumber"].runtimeType);
      final UserObj user = UserObj.fromMap({
        "firstName": userMap["firstname"],
        "lastName": userMap["lastname"],
        "gender": TextFM.genderByIndex(int.parse(userMap["sex"])),
        "birthDate": Params.defaultDateFormat
            .format(DateTime.parse(userMap["dateOfBirth"])),
        "pictureUrl": userMap["userPic"],
        "email": userMap["email"],
        // To be changed after Internationalization
        "phoneNumber": userMap["phoneNumber"] != null
            ? "213;${userMap["phoneNumber"][0] == '0' ? userMap["phoneNumber"].substring(1) : userMap["phoneNumber"]}"
            : null,
      });
      context.read<UserProvider>().updateUserValue(user);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
    }
    return;
  }

  static Future signUp(
      BuildContext context, Map<String, dynamic> formValues) async {
    try {
      String? response = await HttpRequests.userSignUp(formValues);
      log('RESPONSE: $response');
      return response;
    } on Exception catch (e) {
      log('signUp Exception: ${e.toString()}');
      return e.toString();
    }
  }
}

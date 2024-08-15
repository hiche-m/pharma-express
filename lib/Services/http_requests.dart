import 'dart:convert';
import 'dart:developer';

import 'package:code/Models/user_object.dart';
import 'package:code/Utils/text_formulations.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HttpRequests {
  static const String host = 'http://192.168.1.107';
  static const int port = 3000;

  static Future userLogin(String id, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$host:$port/api/login/v1'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': id,
          'password': password,
        }),
      );

      if (response.statusCode != 500) {
        return null;
      }

      return jsonDecode(response.body);
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<String?> userSignUp(Map<String, dynamic> formData) async {
    try {
      final response = await http.post(
        Uri.parse('$host:$port/api/signup/v1'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(formData),
      );

      if (response.statusCode != 500) {
        return jsonDecode(response.body)["error"] ??
            'An error has occured while trying to create your account, please try again in a moment.';
      }

      return null;
    } catch (e) {
      log(e.toString());
    }

    return 'An error has occured while trying to create your account, please try again in a moment.';
  }
}

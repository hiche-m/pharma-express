import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:io';

class HttpRequests {
  static const String host = '192.168.1.102';
  static const int port = 3000;

  // Authentication

  static Future userLogin(String id, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://$host:$port/api/login/v1'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': id,
          'password': password,
        }),
      );

      if (response.statusCode != 500) {
        return 'An error has occured, please try again later...';
      }

      return jsonDecode(response.body);
    } on Exception catch (e) {
      print(e.toString());
      return e.toString();
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

  // Perscription Search

  static Future sendPerscriptionRequest(
      Map<String, String> formData, File perscription) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('http://$host:$port/api/uploadPrescription'));

      request.headers.addAll(<String, String>{
        'Content-Type': 'multipart/form-data',
      });

      formData.forEach((key, value) {
        request.fields[key] = value;
      });

      var fileStream = http.ByteStream(perscription.openRead());
      var length = await perscription.length();
      var multipartFile = http.MultipartFile('prescription', fileStream, length,
          filename: perscription.path.split('/').last);

      request.files.add(multipartFile);
      log("Fields set, sending...");
      var response = await request.send();
      log("Request Sent!");

      return http.Response.fromStream(response);
    } catch (e) {
      log(e.toString());
    }

    return 'An error has occured while trying send the perscription, please try again in a moment.';
  }
}

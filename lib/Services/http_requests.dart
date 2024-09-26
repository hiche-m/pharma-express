import 'dart:convert';
import 'dart:developer';
import 'package:code/Utils/parameters.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:latlong2/latlong.dart';

class HttpRequests {
  static const String host = '192.168.245.12';
  static const int port = 3050;

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
      Map<String, String> formData, File? perscription) async {
    if (perscription == null) {
      return 'File is null!';
    }

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

  static Future checkAccepts(String uid, String perscriptionId) async {
    try {
      final response = await http.post(
        Uri.parse('http://$host:$port/api/getWhoAccept'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"idClient": uid, "idprescription": perscriptionId}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future getRoutePoints(
      LatLng start, LatLng destination, int typeIndex) async {
    if (typeIndex > 3 || typeIndex < 0) {
      return "Error: [typeIndex] must be between 0 and 3.\n\n0: 'driving-traffic'\n1: 'driving'\n2: 'walking'\n3: 'cycling'\n";
    }
    const List<String> types = [
      'driving-traffic',
      'driving',
      'walking',
      'cycling',
    ];
    try {
      final response = await http.get(Uri.parse(
          'https://api.mapbox.com/directions/v5/mapbox/${types[typeIndex]}/${start.longitude}%2C${start.latitude}%3B${destination.longitude}%2C${destination.latitude}?alternatives=false&geometries=polyline&language=en&overview=simplified&steps=true&access_token=${Params.mapboxAcessToken}'));
      return jsonDecode(response.body);
    } catch (e) {
      return e.toString();
    }
  }
}

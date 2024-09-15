import 'dart:developer';
import 'package:code/Utils/fake_data.dart';
import 'package:code/Utils/parameters.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';

class MapVM {
  static LatLng currentLocation = Params.myLocation;

  static MapController? mapController;

  static List<Marker>? markers;

  static Future<List<Marker>> loadMarkers() async {
    List<Marker> markersData = [];
    await Future.delayed(const Duration(seconds: 1));
    for (var item in FakeData.pharmaciesLocation.entries) {
      markersData.add(Marker(
        point: LatLng(item.value["longtitude"], item.value["latitude"]),
        child: FaIcon(
          FontAwesomeIcons.locationDot,
          size: 25.r,
        ),
      ));
    }

    markers = markersData;
    return markersData;
  }

  static Future<LatLng?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      log('Location services are disabled.');
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        log('Location permissions are denied.');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      log('Location permissions are permanently denied, we cannot request permissions.');
      return null;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position currentPosition = await Geolocator.getCurrentPosition();
    currentLocation =
        LatLng(currentPosition.latitude, currentPosition.longitude);
    return currentLocation;
  }
}
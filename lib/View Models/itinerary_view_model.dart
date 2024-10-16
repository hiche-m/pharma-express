import 'dart:developer';

import 'package:code/Models/itinerary_object.dart';
import 'package:code/Models/pharmacy_object.dart';
import 'package:code/Provider/request_provider.dart';
import 'package:code/Services/http_requests.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class ItineraryVM {
  static late GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  static Future getItinerary(BuildContext context,
      {required PharmacyObj pharma,
      required LatLng start,
      required String perscriptionId,
      int typeIndex = 0,
      Key? key}) async {
    context.read<RequestProvider>().setLoading(true);

    var response =
        await HttpRequests.initiateRoute(pharma.pharmaId, perscriptionId);
    log("Initiate Route: ${response.toString()}");

    var result =
        await HttpRequests.getRoutePoints(start, pharma.position, typeIndex);

    if (result is Map) {
      context
          .read<RequestProvider>()
          .setItinerary(ItineraryObj.fromMap(result));
    }
    context.read<RequestProvider>().setLoading(false);
  }
}

import 'package:code/Components/main_input_button.dart';
import 'package:code/Models/itinerary_object.dart';
import 'package:code/Utils/parameters.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItineraryView extends StatefulWidget {
  const ItineraryView({required this.itinerary, super.key});

  final ItineraryObj itinerary;

  @override
  State<ItineraryView> createState() => IitineraryStateView();
}

class IitineraryStateView extends State<ItineraryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: 'itinerary_tag',
            child: FlutterMap(
              mapController: MapVM.mapController,
              options: MapOptions(
                minZoom: 5,
                maxZoom: 17,
                initialZoom: 15,
                initialCenter: widget.itinerary.start,
              ),
              children: [
                TileLayer(
                  urlTemplate: Params.mapboxUrlTemplate,
                  additionalOptions: const {
                    'mapStyleId': Params.mapboxStyleId,
                    'accessToken': Params.mapboxAcessToken,
                  },
                ),
                MarkerLayer(markers: [
                  Marker(
                    point: widget.itinerary.end,
                    child: FaIcon(
                      FontAwesomeIcons.locationCrosshairs,
                      size: 25.r,
                      color: Palette.mainColor,
                    ),
                  ),
                  Marker(
                    point: widget.itinerary.start,
                    child: FaIcon(
                      FontAwesomeIcons.locationCrosshairs,
                      size: 25.r,
                      color: Palette.mainColor,
                    ),
                  ),
                ]),
                PolylineLayer(polylines: [
                  Polyline(
                    points: widget.itinerary.stops,
                    strokeWidth: 4.0,
                    color: Palette.mainColor,
                  ),
                ]),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: MainInputButton(
                  label: 'Exit',
                  wide: false,
                  backgroundColor: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

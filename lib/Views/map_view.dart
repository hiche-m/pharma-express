import 'package:code/Utils/parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FlutterMap(
        options: const MapOptions(
          minZoom: 5,
          maxZoom: 18,
          initialZoom: 13,
          initialCenter: Params.myLocation,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/hich10/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
            additionalOptions: const {
              'mapStyleId': Params.mapboxStyleId,
              'accessToken': Params.mapboxAcessToken,
            },
          ),
        ],
      ),
    );
  }
}

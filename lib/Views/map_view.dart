import 'package:code/Components/search_bar.dart';
import 'package:code/Utils/parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapView extends StatefulWidget {
  const MapView({this.devMode = false, super.key});

  final bool devMode;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          !widget.devMode
              ? FlutterMap(
                  options: const MapOptions(
                    minZoom: 5,
                    maxZoom: 18,
                    initialZoom: 13,
                    initialCenter: Params.myLocation,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: Params.mapboxUrlTemplate,
                      additionalOptions: const {
                        'mapStyleId': Params.mapboxStyleId,
                        'accessToken': Params.mapboxAcessToken,
                      },
                    ),
                  ],
                )
              : const Placeholder(),
          const Align(
            alignment: Alignment.topCenter,
            child: MySearchBar(),
          ),
        ],
      ),
    );
  }
}

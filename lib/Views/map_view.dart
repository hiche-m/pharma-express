import 'package:code/Components/search_bar.dart';
import 'package:code/Utils/parameters.dart';
import 'package:code/View%20Models/map_view_model.dart';
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
  void initState() {
    super.initState();
    MapVM.determinePosition().then((result) => {
          if (result != null && MapVM.mapController != null)
            {MapVM.mapController!.move(result, 13.0)}
        });
    MapVM.loadMarkers();
  }

  @override
  void dispose() {
    super.dispose();
    MapVM.mapController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          !widget.devMode
              ? FlutterMap(
                  mapController: MapVM.mapController,
                  options: MapOptions(
                    minZoom: 5,
                    maxZoom: 18,
                    initialZoom: 18,
                    initialCenter: MapVM.currentLocation,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: Params.mapboxUrlTemplate,
                      additionalOptions: const {
                        'mapStyleId': Params.mapboxStyleId,
                        'accessToken': Params.mapboxAcessToken,
                      },
                    ),
                    MarkerLayer(markers: MapVM.markers ?? []),
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

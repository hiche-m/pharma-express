import 'package:code/Components/search_bar.dart';
import 'package:code/Utils/parameters.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    MapVM.mapController = MapController();
    MapVM.determinePosition().then((result) => {
          if (result != null) {MapVM.mapController.move(result, 13.0)}
        });
    MapVM.loadMarkers();
  }

  @override
  void dispose() {
    super.dispose();
    MapVM.mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            !widget.devMode
                ? FlutterMap(
                    mapController: MapVM.mapController,
                    options: MapOptions(
                      minZoom: 5,
                      maxZoom: 17,
                      initialZoom: 15,
                      initialCenter: MapVM.currentLocation,
                      onPositionChanged: (position, hasGesture) {
                        if (!MapVM.movedPosition &&
                            position.center != MapVM.currentLocation) {
                          setState(() {
                            MapVM.movedPosition = true;
                          });
                        }
                        if (MapVM.movedPosition &&
                            position.center == MapVM.currentLocation) {
                          setState(() {
                            MapVM.movedPosition = false;
                          });
                        }
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: Params.mapboxUrlTemplate,
                        additionalOptions: const {
                          'mapStyleId': Params.mapboxStyleId,
                          'accessToken': Params.mapboxAcessToken,
                        },
                      ),
                      MarkerLayer(
                          markers: MapVM.markers +
                              [
                                Marker(
                                  point: MapVM.currentLocation,
                                  child: FaIcon(
                                    FontAwesomeIcons.locationCrosshairs,
                                    size: 25.r,
                                    color: Palette.mainColor,
                                  ),
                                )
                              ]),
                    ],
                  )
                : const Placeholder(),
            const Align(
              alignment: Alignment.topCenter,
              child: MySearchBar(),
            ),
          ],
        ),
      ),
      floatingActionButton: MapVM.movedPosition
          ? FloatingActionButton(
              onPressed: () {
                MapVM.recenter();
              },
              backgroundColor: Palette.mainColor,
              shape: const StadiumBorder(),
              child: FaIcon(
                FontAwesomeIcons.compass,
                color: Colors.white,
                size: 35.r,
              ),
            )
          : null,
    );
  }
}

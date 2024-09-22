import 'dart:developer';

import 'package:code/Components/loading_indicator.dart';
import 'package:code/Components/search_bar.dart';
import 'package:code/Models/pharmacy_object.dart';
import 'package:code/Utils/parameters.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';

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
    MapVM.loadingController = StreamController<bool>.broadcast();

    MapVM.mapController = MapController();
    MapVM.determinePosition().then((result) => {
          if (result != null) {MapVM.mapController.move(result, 14.0)}
        });
    MapVM.loadMarkers();
    MapVM.loadingController.stream.listen((value) {
      setState(() {
        MapVM.isLoading = value;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MapVM.pharmaAcceptController.stream.listen((event) {
      setState(() {
        MapVM.pharmaAcceptList.add(PharmacyObj.fromMap(event));
      });
      log(MapVM.pharmaAcceptList.toString());
      if (MapVM.pharmaAcceptList.length == 1) {
        MapVM.showPharmaSheet(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    MapVM.mapController.dispose();
    MapVM.loadingController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MapVM.scaffoldMessengerKey,
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
            if (MapVM.isLoading)
              Container(
                color: Colors.black.withOpacity(0.25),
                child: const Center(
                  child: MyLoadingIndicator(type: 2),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: MapVM.movedPosition && !MapVM.isLoading
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

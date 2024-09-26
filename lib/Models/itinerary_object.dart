import 'package:latlong2/latlong.dart';

class ItineraryObj {
  final List<LatLng> stops;
  final LatLng start;
  final LatLng end;

  ItineraryObj({required this.stops, required this.start, required this.end});

  ItineraryObj.fromMap(Map map)
      : stops = (map['routes'][0]['legs'][0]['steps'] as List)
            .map((step) => LatLng(step['maneuver']['location'][1],
                step['maneuver']['location'][0]))
            .toList(),
        start =
            LatLng.fromJson({'coordinates': map['waypoints'][0]['location']}),
        end = LatLng.fromJson({'coordinates': map['waypoints'][1]['location']});
}

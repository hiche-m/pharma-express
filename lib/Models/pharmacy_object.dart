import 'package:latlong2/latlong.dart';

class PharmacyObj {
  final String label;
  final List<String> tags;
  final LatLng position;
  final String address;

  PharmacyObj({
    required this.label,
    required this.tags,
    required this.position,
    required this.address,
  });

  PharmacyObj.fromMap(Map map)
      : label = map['storeName'],
        tags = map['services'].toString().trim().split(','),
        position = LatLng(map['latitude'], map['longitude']),
        address = map['adresse'];
}

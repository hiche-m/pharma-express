import 'package:latlong2/latlong.dart';

class PharmacyObj {
  final String label;
  final List<String> tags;
  final LatLng position;
  final String address;
  final String pharmaId;

  PharmacyObj({
    required this.label,
    required this.tags,
    required this.position,
    required this.address,
    required this.pharmaId,
  });

  PharmacyObj.fromMap(Map map)
      : label = map['storeName'],
        tags = map['services'].toString().trim().split(','),
        position = LatLng(
            map['latitude'] is double
                ? map['latitude']
                : double.parse(map['latitude']),
            map['longitude'] is double
                ? map['longitude']
                : double.parse(map['longitude'])),
        pharmaId = map['idpharma'].toString(),
        address = map['adresse'];
}

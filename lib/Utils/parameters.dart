import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class Params {
  static final DateFormat defaultDateFormat =
      DateFormat('dd-MM-yyyy HH:mm:ss.SSS');

  static final RegExp phoneFormat1 = RegExp(r'^0\d{9}$');
  static final RegExp phoneFormat2 = RegExp(r'^\+213\d{9}$');

  static const String mapboxAcessToken =
      "pk.eyJ1IjoiaGljaDEwIiwiYSI6ImNtMDg4ZzJwOTFpdzUycnF6ZmlseDl3YXEifQ.aWhY8LcAOx5-2m4B9Xfdyw";

  static const String mapboxStyleId = "cm0o2il8f00fn01pmg8n72uwt";

  static const myLocation = LatLng(30, 30);
}

import 'package:intl/intl.dart';

class Params {
  static final DateFormat defaultDateFormat =
      DateFormat('dd-MM-yyyy HH:mm:ss.SSS');

  static final RegExp phoneFormat1 = RegExp(r'^0\d{9}$');
  static final RegExp phoneFormat2 = RegExp(r'^\+213\d{9}$');
}

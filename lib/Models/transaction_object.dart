import 'package:code/Models/instructions_object.dart';
import 'package:code/Utils/parameters.dart';

class TransactionObj {
  final String source;
  final String location;
  final DateTime timestamp;
  final DateTime? openedAt;
  final double? total;
  final Map<String, InstructionsObj?> medicineList;

  TransactionObj({
    required this.source,
    required this.location,
    required this.timestamp,
    required this.openedAt,
    required this.medicineList,
    this.total,
  });

  TransactionObj.fromMap(Map map, Map<String, InstructionsObj?> medicine)
      : source = map["source"].toString(),
        location = map["location"].toString(),
        timestamp = Params.defaultDateFormat.parse(map["timestamp"]),
        openedAt = map["openedAt"] != null
            ? Params.defaultDateFormat.parse(map["openedAt"])
            : null,
        total =
            map["total"] != null ? double.parse(map["total"].toString()) : null,
        medicineList = medicine;
}

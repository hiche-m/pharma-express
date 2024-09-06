class InstructionsObj {
  final String? label;

  /// [Duration] Duration: For how long in days is the medicine going to be taken?
  final Duration? duration;

  /// [int] TPd: Times Per Day
  final int? tpd;

  /// [double] PPT: (Can be a fraction, like 1/2).
  ///
  /// Portion Per Take
  final double? ppt;

  /// [int] Time: When is it taken during the day?
  ///
  ///
  /// 0: Before Meals
  ///
  /// 1: After Meals
  ///
  /// 2: First thing in the morning
  final int? time;

  InstructionsObj({this.label, this.duration, this.tpd, this.ppt, this.time});

  InstructionsObj.fromMap(Map map)
      : label = map["label"],
        duration = Duration(days: int.parse(map["duration"].toString())),
        tpd = int.parse(map["tpd"].toString()),
        ppt = double.parse(map["ppt"].toString()),
        time = int.parse(map["time"].toString());
}

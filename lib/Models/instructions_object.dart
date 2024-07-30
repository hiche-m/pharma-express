class InstructionsObj {
  final Duration? duration;

  /// [Duration] Duration: For how long in days is the medicine going to be taken?

  final int? tpd;

  /// [int] TPd: Times Per Day

  final double? ppt;

  /// [double] PPT: (Can be a fraction, like 1/2).
  ///
  /// Portion Per Time

  final int? time;

  /// [int] Time: When is it taken during the day?
  ///
  ///
  /// 0: Before Meals
  ///
  /// 1: After Meals
  ///
  /// 2: First thing in the morning

  InstructionsObj({this.duration, this.tpd, this.ppt, this.time});

  InstructionsObj.fromMap(Map map)
      : duration = Duration(days: int.parse(map["duration"].toString())),
        tpd = int.parse(map["tpd"].toString()),
        ppt = double.parse(map["ppt"].toString()),
        time = int.parse(map["time"].toString());
}

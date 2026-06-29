class SWTime {
  final int hour;
  final int minute;
  final int? second;
  final int? millisecond;

  SWTime({
    required this.hour,
    required this.minute,
    this.second,
    this.millisecond,
  });
}

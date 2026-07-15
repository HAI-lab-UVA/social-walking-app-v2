class SWTime {
  final int hour;
  final int minute;

  // ALWAYS USE UTC!!!
  SWTime({required this.hour, required this.minute});

  String tolocalString() {
    final dateTimeObj = DateTime.utc(0, 0, 0, hour, minute);
    final dateTimeObjLocal = dateTimeObj.toLocal();
    return "${dateTimeObjLocal.hour.toString().padLeft(2)}:${dateTimeObjLocal.minute.toString().padLeft(2)}";
  }

  String toUTCString() {
    return "${hour.toString().padLeft(2)}:${minute.toString().padLeft(2)}";
  }

  factory SWTime.fromUTCString(String str) {
    final split = str.split(":");
    final hour = int.parse(split[0]);
    final minute = int.parse(split[1]);
    return SWTime(hour: hour, minute: minute);
  }
}

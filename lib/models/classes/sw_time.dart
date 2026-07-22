import 'package:intl/intl.dart';

class SWTime {
  final int hour;
  final int minute;

  // ALWAYS USE UTC!!!
  SWTime({required this.hour, required this.minute});

  String tolocalString() {
    final dateTimeObj = DateTime.utc(0, 0, 0, hour, minute);
    final dateTimeObjLocal = dateTimeObj.toLocal();
    return DateFormat("hh:mm aa").format(dateTimeObjLocal);
  }

  String toUTCString() {
    return "${hour.toString().padLeft(2)}:${minute.toString().padLeft(2)}";
  }

  String to12HourString() {
    int newHour = hour % 12;
    if (newHour == 0) {
      newHour = 12;
    }
    String timePeriod = hour >= 12 ? "PM" : "AM";
    String hourStr = newHour.toString();
    String minuteStr = minute.toString().padLeft(2, '0');

    return "$hourStr:$minuteStr $timePeriod";
  }

  String to12HourStringWithoutMinutes() {
    int newHour = hour % 12;
    if (newHour == 0) {
      newHour = 12;
    }
    String timePeriod = hour >= 12 ? "PM" : "AM";
    String hourStr = newHour.toString();

    return "$hourStr $timePeriod";
  }

  SWTime addMinutes(int mins) {
    int totalMinutes = (hour * 60) + minute + mins;
    totalMinutes = totalMinutes % 1440; // mins in a day
    int newHour = totalMinutes ~/ 60;
    int newMinute = totalMinutes % 60;

    return SWTime(hour: newHour, minute: newMinute);
  }

  bool equals(SWTime other) {
    return hour == other.hour && minute == other.minute;
  }

  factory SWTime.fromUTCString(String str) {
    final split = str.split(":");
    final hour = int.parse(split[0]);
    final minute = int.parse(split[1]);
    return SWTime(hour: hour, minute: minute);
  }
}

class SWTime {
  final int hour;
  final int minute;

  // ALWAYS USE UTC!!!
  SWTime({required this.hour, required this.minute});

  String tolocalString() {
    final local = toLocalTime();
    return local.to12HourString();
  }

  SWTime toLocalTime() {
    final now = DateTime.timestamp();
    final dateTimeObj = DateTime.utc(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    final dateTimeObjLocal = dateTimeObj.toLocal();
    return SWTime(hour: dateTimeObjLocal.hour, minute: dateTimeObjLocal.minute);
  }

  SWTime toUTCTimeFromLocalTime() {
    final now = DateTime.now();
    final dateTimeObj = DateTime(now.year, now.month, now.day, hour, minute);
    final dateTimeObjUtc = dateTimeObj.toUtc();
    return SWTime(hour: dateTimeObjUtc.hour, minute: dateTimeObjUtc.minute);
  }

  String toUTCString() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
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

  SWTime roundUpToFifteen() {
    if (minute > 45) {
      return addMinutes(60 - minute);
    } else if (minute > 30) {
      return addMinutes(45 - minute);
    } else if (minute > 15) {
      return addMinutes(30 - minute);
    } else if (minute > 0) {
      return addMinutes(15 - minute);
    } else {
      return addMinutes(0);
    }
  }

  SWTime roundDownToFifteen() {
    if (minute > 45) {
      return addMinutes(45 - minute);
    } else if (minute > 30) {
      return addMinutes(30 - minute);
    } else if (minute > 15) {
      return addMinutes(15 - minute);
    } else if (minute > 0) {
      return addMinutes(0 - minute);
    } else {
      return addMinutes(0);
    }
  }

  factory SWTime.fromISOString(String str) {
    final parsed = DateTime.parse(str);
    return SWTime(hour: parsed.hour, minute: parsed.minute);
  }

  factory SWTime.fromUTCString(String str) {
    final split = str.split(":");
    final hour = int.parse(split[0]);
    final minute = int.parse(split[1]);
    return SWTime(hour: hour, minute: minute);
  }

  factory SWTime.fromDateTime(DateTime time) {
    return SWTime(hour: time.hour, minute: time.minute);
  }
}

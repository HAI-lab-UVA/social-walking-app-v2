import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:social_walking_2/models/classes/sw_availability_slot.dart';
import 'package:social_walking_2/models/classes/sw_time.dart';
import 'package:social_walking_2/models/classes/sw_time_range.dart';

class GoogleCalendarService {
  static const String _freeBusyUrl =
      'https://www.googleapis.com/calendar/v3/freeBusy';

  /// Fetches the busy time blocks for the current work week.
  Future<List<SWAvailabilitySlot>> getWeeklyBusyBlocks(
    String accessToken,
  ) async {
    // 1. Define the time range (e.g., this Monday to this Friday)
    final now = DateTime.now();

    // Calculate the most recent Monday
    final currentDayOfWeek = now.weekday;
    final monday = now.subtract(Duration(days: currentDayOfWeek - 1));

    // Set time limits: Monday 12:00 AM to Friday 11:59 PM
    final timeMin = DateTime(monday.year, monday.month, monday.day).toUtc();
    final timeMax = timeMin
        .add(const Duration(days: 4, hours: 23, minutes: 59))
        .toUtc();

    // 2. Construct the request body
    final Map<String, dynamic> requestBody = {
      "timeMin": timeMin.toIso8601String(),
      "timeMax": timeMax.toIso8601String(),
      "timeZone": "UTC",
      "items": [
        {
          "id": "primary",
        }, // "primary" automatically targets the logged-in user's main calendar
      ],
    };

    // 3. Make the HTTP POST request
    try {
      final response = await http.post(
        Uri.parse(_freeBusyUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return _parseBusyBlocksToAvailabilitySlots(response.body);
      } else {
        print("Failed to fetch calendar: ${response.statusCode}");
        print("Error details: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Network error fetching freebusy: $e");
      return [];
    }
  }

  List<SWAvailabilitySlot> _parseBusyBlocksToAvailabilitySlots(
    String responseBody,
  ) {
    final Map<String, dynamic> data = jsonDecode(responseBody);
    final availabilitySlots =
        SWTimeRange(
              start: SWTime(hour: 0, minute: 0),
              stop: SWTime(hour: 23, minute: 45),
              interval: 15,
            )
            .getTimes()
            .map((e) => SWAvailabilitySlot(time: e, allTrue: true))
            .toList();

    // Navigate the JSON tree: data -> calendars -> primary -> busy
    final calendars = data['calendars'] as Map<String, dynamic>?;
    if (calendars != null && calendars.containsKey('primary')) {
      final primaryCalendar = calendars['primary'] as Map<String, dynamic>;
      final busyArray = primaryCalendar['busy'] as List<dynamic>?;
      if (busyArray != null) {
        for (var block in busyArray) {
          final startStr = block['start'] as String;
          final endStr = block['end'] as String;

          final startDateTime = DateTime.parse(startStr).toLocal();
          final endDateTime = DateTime.parse(endStr).toLocal();
          final startDateIndex = startDateTime.weekday - 1;
          final endDateIndex = endDateTime.weekday - 1;
          print(block);
          print(startDateTime);
          print(endDateTime);
          print(startDateIndex);
          print(endDateIndex);
          if (startDateIndex != endDateIndex) {
            final startTimeRange = SWTimeRange(
              start: SWTime.fromDateTime(startDateTime).roundDownToFifteen(),
              stop: SWTime(hour: 23, minute: 45),
              interval: 15,
            ).getTimes();
            for (var t in startTimeRange) {
              final index = availabilitySlots.indexWhere(
                (e) => e.time.equals(t),
              );
              if (index != -1) {
                availabilitySlots[index].availability[startDateIndex] = false;
              }
            }
            final endTimeRange = SWTimeRange(
              start: SWTime(hour: 0, minute: 0),
              stop: SWTime.fromDateTime(endDateTime).roundDownToFifteen(),
              interval: 15,
            ).getTimes();
            for (var t in endTimeRange) {
              final index = availabilitySlots.indexWhere(
                (e) => e.time.equals(t),
              );
              if (index != -1) {
                availabilitySlots[index].availability[endDateIndex] = false;
              }
            }
          } else {
            final times = SWTimeRange(
              start: SWTime.fromDateTime(startDateTime).roundDownToFifteen(),
              stop: SWTime.fromDateTime(endDateTime).roundDownToFifteen(),
              interval: 15,
            ).getTimes();
            for (var t in times) {
              final index = availabilitySlots.indexWhere(
                (e) => e.time.equals(t),
              );
              if (index != -1) {
                availabilitySlots[index].availability[startDateIndex] = false;
              }
            }
          }
        }
      }
    }

    return availabilitySlots;
  }
}

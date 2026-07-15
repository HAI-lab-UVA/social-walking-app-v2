import 'dart:convert';

import 'package:social_walking_2/models/classes/sw_fitness_goal.dart';
import 'package:social_walking_2/models/classes/sw_location.dart';
import 'package:social_walking_2/models/classes/sw_time_range.dart';
import 'package:social_walking_2/models/enums/sw_gender.dart';
import 'package:social_walking_2/models/enums/sw_walk_preference.dart';

class SWUser {
  final DateTime created;
  final String id;
  String fcmToken;
  String firstName;
  String lastName;
  String pronouns;
  DateTime dateOfBirth;
  SWGender gender;
  String biography;
  String? profileImageURL;
  late List<SWWalkPreference> walkPreferences;
  late Map<String, int> walkedWith = {};
  late List<String> chattedWith = [];
  late Map<int, List<SWTimeRange>> availability;
  late bool isSharingProximity;
  late Map<int, SWFitnessGoal?> weeklySocialStepGoals;
  late bool finishedSetup;
  SWFitnessGoal? weeklyMeetPeopleGoal;
  SWLocation? location;

  SWUser({
    required this.created,
    required this.id,
    required this.fcmToken,
    required this.firstName,
    required this.lastName,
    required this.pronouns,
    required this.dateOfBirth,
    required this.gender,
    required this.biography,
    required this.profileImageURL,
    List<SWWalkPreference>? walkPreferences,
    Map<String, int>? walkedWith,
    List<String>? chattedWith,
    Map<int, List<SWTimeRange>>? availability,
    bool? isSharingProximity,
    Map<int, SWFitnessGoal?>? weeklySocialStepGoals,
    this.weeklyMeetPeopleGoal,
    bool? finishedSetup,
    this.location,
  }) {
    this.walkPreferences = walkPreferences ?? [];
    this.walkedWith = walkedWith ?? {};
    this.chattedWith = chattedWith ?? [];
    this.availability =
        availability ??
        {0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 6: [], 7: []};
    this.isSharingProximity = isSharingProximity ?? false;
    this.weeklySocialStepGoals =
        weeklySocialStepGoals ??
        {
          0: null,
          1: null,
          2: null,
          3: null,
          4: null,
          5: null,
          6: null,
          7: null,
        };
    this.finishedSetup = finishedSetup ?? false;
  }

  factory SWUser.fromJson(Map<String, dynamic> json) {
    return SWUser(
      created: DateTime.parse(json["created"]),
      id: json["id"] as String,
      fcmToken: json["fcmToken"] as String,
      firstName: json["firstName"] as String,
      lastName: json["lastName"] as String,
      pronouns: json["pronouns"] as String,
      dateOfBirth: DateTime.parse(json["dateOfBirth"] as String),
      gender: SWGender.values.byName(json["gender"] as String),
      biography: json["biography"] as String,
      profileImageURL: json["profileImageURL"] as String?,
      walkPreferences: (json["walkPreferences"] as List<dynamic>)
          .map((e) => SWWalkPreference.values.byName(e))
          .toList(),
      walkedWith: json["walkedwith"] as Map<String, int>?,
      chattedWith: (json["walkPreferences"] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      availability: (json["availability"] as Map<int, dynamic>).map(
        (k, v) => MapEntry(
          k,
          (v as List<dynamic>)
              .map((e) => SWTimeRange.fromString(e as String))
              .toList(),
        ),
      ),
      isSharingProximity: json["isSharingProximity"] as bool,
      weeklySocialStepGoals:
          (json["weeklySocialStepGoals"] as Map<int, dynamic>).map(
            (k, v) => MapEntry(k, SWFitnessGoal.fromString(v as String)),
          ),
      weeklyMeetPeopleGoal: SWFitnessGoal.fromString(
        json["weeklyMeetPeopleGoal"],
      ),
      finishedSetup: json["finishedSetup"] as bool,
      location: SWLocation.fromJson(json["location"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "created": created,
      "id": id,
      "fcmToken": fcmToken,
      "firstName": firstName,
      "lastName": lastName,
      "pronouns": pronouns,
      "dateOfBirth": dateOfBirth.toString(),
      "gender": gender.toString(),
      "biography": biography,
      "profileImageURL": profileImageURL,
      "walkPreferences": jsonEncode(walkPreferences.map((e) => e.toString())),
      "walkedWith": jsonEncode(walkedWith),
      "chattedWith": jsonEncode(chattedWith),
      "availability": jsonEncode(
        availability.map((k, v) => MapEntry(k, v.toString())),
      ),
      "isSharingProximity": isSharingProximity.toString(),
      "weeklySocialStepGoals": jsonEncode(
        weeklySocialStepGoals.map((k, v) => MapEntry(k, v.toString())),
      ),
      "weeklyMeetPeopleGoal": weeklyMeetPeopleGoal.toString(),
      "finishedSetup": finishedSetup.toString(),
      "location": location?.toJson(),
    };
  }
}

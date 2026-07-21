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
  DateTime dateOfBirth;
  SWGender gender;
  String biography;
  String? profileImageURL;
  late String pronouns;
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
    required this.dateOfBirth,
    required this.gender,
    required this.biography,
    required this.profileImageURL,
    String? pronouns,
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
    this.pronouns = pronouns ?? "";
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
      walkedWith: (json["walkedWith"] as Map<String, dynamic>).map(
        (k, v) => MapEntry(k, v as int),
      ),
      chattedWith: (json["chattedWith"] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      availability: (json["availability"] as Map<String, dynamic>).map(
        (k, v) => MapEntry(
          int.parse(k),
          (v as List<dynamic>)
              .map((e) => SWTimeRange.fromString(e as String))
              .toList(),
        ),
      ),
      isSharingProximity: json["isSharingProximity"] as bool,
      weeklySocialStepGoals:
          (json["weeklySocialStepGoals"] as Map<String, dynamic>).map(
            (k, v) => MapEntry(
              int.parse(k),
              v != null ? SWFitnessGoal.fromString(v as String) : null,
            ),
          ),
      weeklyMeetPeopleGoal: json["weeklyMeetPeopleGoal"] != null
          ? SWFitnessGoal.fromString(json["weeklyMeetPeopleGoal"])
          : null,
      finishedSetup: json["finishedSetup"] as bool,
      location: json["location"] != null
          ? SWLocation.fromJson(json["location"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "created": created.toIso8601String(),
      "id": id,
      "fcmToken": fcmToken,
      "firstName": firstName,
      "lastName": lastName,
      "pronouns": pronouns,
      "dateOfBirth": dateOfBirth.toIso8601String(),
      "gender": gender.name,
      "biography": biography,
      "profileImageURL": profileImageURL,
      "walkPreferences": walkPreferences.map((e) => e.name).toList(),
      "walkedWith": walkedWith,
      "chattedWith": chattedWith,
      "availability": availability.map(
        (k, v) => MapEntry(k.toString(), v.map((e) => e.toString()).toList()),
      ),
      "isSharingProximity": isSharingProximity,
      "weeklySocialStepGoals": weeklySocialStepGoals.map(
        (k, v) => MapEntry(k.toString(), v?.toString()),
      ),
      "weeklyMeetPeopleGoal": weeklyMeetPeopleGoal?.toString(),
      "finishedSetup": finishedSetup,
      "location": location?.toJson(),
    };
  }
}

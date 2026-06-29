import 'package:social_walking_2/models/classes/sw_date_time.dart';
import 'package:social_walking_2/models/classes/sw_fitness_goal.dart';
import 'package:social_walking_2/models/classes/sw_time_range.dart';
import 'package:social_walking_2/models/enums/sw_gender.dart';
import 'package:social_walking_2/models/enums/sw_walk_preference.dart';

class SWUser {
  final SWDateTime created;
  final String firstName;
  final String lastName;
  final SWDateTime dateOfBirth;
  final String pronouns;
  final SWGender gender;
  final String biography;
  final List<SWWalkPreference> walkPreferences;
  final String fcmToken;
  final String id;
  final String profileImageURL;
  final Map<String, int> walkedWith = {};
  final List<String> chattedWith = [];
  final Map<int, SWTimeRange?> availability = {
    0: null,
    1: null,
    2: null,
    3: null,
    4: null,
    5: null,
    6: null,
    7: null,
  };
  final bool isSharingProximity = false;
  final Map<int, SWFitnessGoal?> weeklySocialStepGoals = {
    0: null,
    1: null,
    2: null,
    3: null,
    4: null,
    5: null,
    6: null,
    7: null,
  };
  SWFitnessGoal? weeklyMeetPeopleGoal;
  bool finishedSetup = false;

  SWUser({
    required this.created,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.pronouns,
    required this.gender,
    required this.biography,
    required this.walkPreferences,
    required this.fcmToken,
    required this.id,
    required this.profileImageURL,
  });
}

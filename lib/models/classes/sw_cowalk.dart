import 'package:social_walking_2/models/classes/sw_location.dart';
import 'package:social_walking_2/models/classes/sw_survey_question.dart';
import 'package:social_walking_2/models/enums/sw_cowalk_status.dart';

class SWCowalk {
  final SWCowalkStatus status;
  final DateTime created;
  final String id;
  final String senderId;
  final String receiverId;
  late SWLocation? scheduledLocation;
  late DateTime scheduledDate;
  late Map<String, Map<SWSurveyQuestion, dynamic>?> feedback;
  late Map<String, SWLocation?> userStartLocations;
  late Map<String, SWLocation?> userEndLocations;
  late Map<String, DateTime?> userStartTimes;
  late Map<String, DateTime?> userEndTimes;

  SWCowalk({
    required this.status,
    required this.created,
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.scheduledLocation,
    required this.scheduledDate,
  }) {
    userStartLocations = {senderId: null, receiverId: null};
    userEndLocations = {senderId: null, receiverId: null};
    userStartTimes = {senderId: null, receiverId: null};
    userEndTimes = {senderId: null, receiverId: null};
    feedback = {senderId: null, receiverId: null};
  }
}

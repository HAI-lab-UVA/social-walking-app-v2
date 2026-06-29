import 'package:social_walking_2/models/classes/sw_survey_question.dart';

class SWSurvey {
  final List<SWSurveyQuestion> questions;
  final List<dynamic> answers = [];

  SWSurvey({required this.questions});
}

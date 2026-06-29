import 'package:social_walking_2/models/enums/sw_survey_question_type.dart';

class SWSurveyQuestion {
  final String text;
  final SWSurveyQuestionType type;
  final bool required;
  final String? radioOptions;
  final String? hintText;
  final bool onlyOnFirstWalk;

  SWSurveyQuestion({
    required this.text,
    required this.type,
    required this.required,
    required this.radioOptions,
    required this.hintText,
    required this.onlyOnFirstWalk,
  });
}

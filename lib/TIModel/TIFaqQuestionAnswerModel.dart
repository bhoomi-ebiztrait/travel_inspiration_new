import 'package:travel_inspiration/APICallServices/ApiParameter.dart';

class TIFaqQuestionAnswerModel {
  String question, answer;
  int queId;

  TIFaqQuestionAnswerModel.fromMap(Map map) {
    queId = map[ApiParameter.queId];
    question = map[ApiParameter.question].toString();
    answer = map[ApiParameter.answer].toString();
  }
}

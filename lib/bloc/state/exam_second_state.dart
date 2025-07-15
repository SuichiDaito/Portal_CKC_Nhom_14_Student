import 'package:portal_ckc/api/model/exam_model.dart';
import 'package:portal_ckc/api/model/exam_second_model.dart';

abstract class ExamSecondState {}

class ExamSecondStateInitial extends ExamSecondState {}

class ExamSecondStateLoading extends ExamSecondState {}

class ExamSecondStateLoaded extends ExamSecondState {
  final List<ThiData> exams;

  ExamSecondStateLoaded(this.exams);
}

class ExamSecondStateError extends ExamSecondState {
  final String message;

  ExamSecondStateError(this.message);
}

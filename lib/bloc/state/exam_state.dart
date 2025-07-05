import 'package:portal_ckc/api/model/exam_model.dart';

abstract class ExamState {}

class ExamStateInitial extends ExamState {}

class ExamStateLoading extends ExamState {}

class ExamStateLoaded extends ExamState {
  final List<ExamSchedule> exams;

  ExamStateLoaded(this.exams);
}

class ExamStateError extends ExamState {
  final String message;

  ExamStateError(this.message);
}

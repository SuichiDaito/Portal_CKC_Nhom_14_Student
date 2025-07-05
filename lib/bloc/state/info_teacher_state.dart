import 'package:portal_ckc/api/model/info_teacher_model.dart';

abstract class InfoTeacherState {}

class InfoTeacherStateInitial extends InfoTeacherState {}

class InfoTeacherStateLoading extends InfoTeacherState {}

class InfoTeacherStateLoaded extends InfoTeacherState {
  final List<Teacher> teachers;

  InfoTeacherStateLoaded(this.teachers);
}

class InfoTeacherStateError extends InfoTeacherState {
  final String message;

  InfoTeacherStateError(this.message);
}

import 'package:portal_ckc/api/model/list_subject_student_model.dart';

abstract class ListSubjectFailState {}

class ListSubjectFailInitial extends ListSubjectFailState {}

class ListSubjectFailStateLoading extends ListSubjectFailState {}

class ListSubjectFailStateLoaded extends ListSubjectFailState {
  final List<DiemHocPhan> subject;

  ListSubjectFailStateLoaded(this.subject);
}

class ListSubjectFailStateError extends ListSubjectFailState {
  final String message;

  ListSubjectFailStateError(this.message);
}

import 'package:portal_ckc/api/model/danh_sach_sinh_vien.dart';
import 'package:portal_ckc/api/model/student_login.dart';

abstract class ListStudentState {}

class ListStudentInitial extends ListStudentState {}

class ListStudentStateLoading extends ListStudentState {}

class ListStudentStateLoaded extends ListStudentState {
  final List<ListStudent> studens;

  ListStudentStateLoaded(this.studens);
}

class CreateReportSuccess extends ListStudentState {
  final String message;

  CreateReportSuccess(this.message);
}

class CreateReportError extends ListStudentState {
  final String message;

  CreateReportError(this.message);
}

class ListStudentStateError extends ListStudentState {
  final String message;

  ListStudentStateError(this.message);
}

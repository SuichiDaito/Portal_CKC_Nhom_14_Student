import 'package:portal_ckc/api/model/danh_sach_sinh_vien.dart';
import 'package:portal_ckc/api/model/student_login.dart';

abstract class ListStudentState {}

class ListStudentInitial extends ListStudentState {}

class ListStudentStateLoading extends ListStudentState {}

class ListStudentStateLoaded extends ListStudentState {
  final List<ListStudent> studens;

  ListStudentStateLoaded(this.studens);
}

class ListStudentStateError extends ListStudentState {
  final String message;

  ListStudentStateError(this.message);
}

import 'package:portal_ckc/api/model/admin_thongtin.dart';
import 'package:portal_ckc/api/model/student_login.dart';

abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentSuccess extends StudentState {
  final SinhVien student;

  StudentSuccess(this.student);
}

class StudentLoaded extends StudentState {
  final SinhVien student;

  StudentLoaded(this.student);
}

class StudentError extends StudentState {
  final String message;

  StudentError(this.message);
}

class StudentLogoutSuccess extends StudentState {
  final String message;

  StudentLogoutSuccess(this.message);
}

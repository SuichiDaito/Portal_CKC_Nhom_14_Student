import 'package:portal_ckc/api/model/admin_thongtin.dart';

abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentSuccess extends StudentState {
  final User user;

  StudentSuccess(this.user);
}

class StudentLoaded extends StudentState {
  final User user;

  StudentLoaded(this.user);
}

class StudentError extends StudentState {
  final String message;

  StudentError(this.message);
}

import 'package:portal_ckc/api/model/student_point_result.dart';

abstract class StudentResultPointState {}

class StudentPointStateLoaded extends StudentResultPointState {
  final Map<String, List<Subject>> subjects;

  StudentPointStateLoaded(this.subjects);
}

class StudentPointStateLoading extends StudentResultPointState {
  StudentPointStateLoading();
}

class StudentPointStateInitial extends StudentResultPointState {
  StudentPointStateInitial();
}

class StudentPointStateError extends StudentResultPointState {
  final String message;
  StudentPointStateError(this.message);
}

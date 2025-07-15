import 'package:portal_ckc/api/model/exam_model.dart';
import 'package:portal_ckc/api/model/sign_up_class_subject_model.dart';

abstract class ClassSubjectState {}

class ClassSubjectStateInitial extends ClassSubjectState {}

class ClassSubjectStateLoading extends ClassSubjectState {}

class ClassSubjectStateLoaded extends ClassSubjectState {
  final DangKyHocPhanResponse classSubject;

  ClassSubjectStateLoaded(this.classSubject);
}

class ClassSubjectStateError extends ClassSubjectState {
  final String message;

  ClassSubjectStateError(this.message);
}

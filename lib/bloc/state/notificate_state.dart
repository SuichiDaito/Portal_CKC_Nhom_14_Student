import 'package:portal_ckc/api/model/student_notifications_model.dart';

abstract class NotificateState {}

class NotificateStateInitial extends NotificateState {}

class NotificateStateLoading extends NotificateState {}

class NotificateStateLoaded extends NotificateState {
  final List<ThongBao> exams;

  NotificateStateLoaded(this.exams);
}

class NotificateStateError extends NotificateState {
  final String message;

  NotificateStateError(this.message);
}

import 'package:portal_ckc/api/model/notification_model.dart';

abstract class NotificateState {}

class NotificateStateInitial extends NotificateState {}

class NotificateStateLoading extends NotificateState {}

class NotificateStateLoaded extends NotificateState {
  final List<ThongBao> notifications;

  NotificateStateLoaded(this.notifications);
}

class NotificateStateError extends NotificateState {
  final String message;

  NotificateStateError(this.message);
}

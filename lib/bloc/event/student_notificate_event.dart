abstract class NotificateEvent {}

class FetchNotificateEvent extends NotificateEvent {}

class FetchNotificationDetailEvent extends NotificateEvent {
  final int id;
  FetchNotificationDetailEvent(this.id);
}

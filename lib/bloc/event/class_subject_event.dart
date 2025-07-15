abstract class ClassSubjectEvent {}

class RequestClassSubjectEvent extends ClassSubjectEvent {
  final int id_mon_hoc;
  RequestClassSubjectEvent({required this.id_mon_hoc});
}

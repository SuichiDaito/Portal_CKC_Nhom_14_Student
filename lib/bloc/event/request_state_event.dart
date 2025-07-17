abstract class RequestStateEvent {}

class RequestReportFromStudentEvent extends RequestStateEvent {
  int id;
  RequestReportFromStudentEvent(this.id);
}

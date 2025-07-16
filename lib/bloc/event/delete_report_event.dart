abstract class DeleteReportEvent {}

class DeleteReportListEvent extends DeleteReportEvent {
  final int id;

  DeleteReportListEvent(this.id);
}

abstract class ListStudentEvent {}

class FetchListStudent extends ListStudentEvent {}

class CreatReportEvent extends ListStudentEvent {
  final Map<String, dynamic> data;
  final int lopId;
  CreatReportEvent({required this.data, required this.lopId});
}

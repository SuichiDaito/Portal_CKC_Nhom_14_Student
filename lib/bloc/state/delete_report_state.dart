abstract class DeleteReportState {}

class DeleteReportStateInitial extends DeleteReportState {}

class DeleteReportStateLoading extends DeleteReportState {}

class DeleteReportStateLoaded extends DeleteReportState {
  final String message;

  DeleteReportStateLoaded(this.message);
}

class DeleteReportStateError extends DeleteReportState {
  final String message;

  DeleteReportStateError(this.message);
}

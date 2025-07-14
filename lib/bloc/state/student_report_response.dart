import 'package:portal_ckc/api/model/student_report_model.dart';

abstract class StudentReportResponseState {}

class StudentReportResponseInitial extends StudentReportResponseState {}

class StudentReportResponseLoading extends StudentReportResponseState {}

class StudentReportResponseLoaded extends StudentReportResponseState {
  final List<BienBanItem> reportResponseList;

  StudentReportResponseLoaded(this.reportResponseList);
}

class StudentReportResponseError extends StudentReportResponseState {
  final String message;

  StudentReportResponseError(this.message);
}

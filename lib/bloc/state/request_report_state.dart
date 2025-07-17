import 'package:portal_ckc/api/model/exam_model.dart';

abstract class RequestReportState {}

class RequestReportStateInitial extends RequestReportState {}

class RequestReportStateLoading extends RequestReportState {}

class RequestReportStateLoaded extends RequestReportState {
  final String message;

  RequestReportStateLoaded(this.message);
}

class RequestReportStateError extends RequestReportState {
  final String message;

  RequestReportStateError(this.message);
}

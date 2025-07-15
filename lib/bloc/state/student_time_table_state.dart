import 'package:portal_ckc/api/model/student_time_table_model.dart';

abstract class TimeTableState {}

class TimeTableStateInitial extends TimeTableState {}

class TimeTableStateLoading extends TimeTableState {}

class TimeTableStateLoaded extends TimeTableState {
  final List<ScheduleData> timeTables;

  TimeTableStateLoaded(this.timeTables);
}

class TimeTableStateError extends TimeTableState {
  final String message;

  TimeTableStateError(this.message);
}

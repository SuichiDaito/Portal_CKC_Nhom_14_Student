import 'package:equatable/equatable.dart';

abstract class StudentEvent {}

class StudentLoginEvent extends StudentEvent {
  final String ma_sv;
  final String password;

  StudentLoginEvent({required this.ma_sv, required this.password});
}

class FetchAdminDetail extends StudentEvent {
  final int userId;

  FetchAdminDetail({required this.userId});
}

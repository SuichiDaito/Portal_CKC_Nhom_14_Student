import 'package:portal_ckc/api/model/student_payment_model.dart';

abstract class PaymentState {}

class PaymentStateInitial extends PaymentState {}

class PaymentStateLoading extends PaymentState {}

class PaymentStateLoaded extends PaymentState {
  final MainResponse students;

  PaymentStateLoaded(this.students);
}

class PaymentStateError extends PaymentState {
  final String message;

  PaymentStateError(this.message);
}

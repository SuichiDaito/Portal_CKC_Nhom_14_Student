abstract class PaymentExamSecondEvent {}

class RequestPaymentExamSecond extends PaymentExamSecondEvent {
  final int id;
  RequestPaymentExamSecond({required this.id});
}

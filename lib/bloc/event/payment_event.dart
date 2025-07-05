abstract class PaymentEvent {}

class FetchPaymentEvent extends PaymentEvent {
  final int lop;

  FetchPaymentEvent({required this.lop});
}

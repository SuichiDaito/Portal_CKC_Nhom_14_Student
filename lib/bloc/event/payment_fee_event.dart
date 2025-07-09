abstract class PaymentRequestFeeEvent {}

class RequestPaymentFee extends PaymentRequestFeeEvent {
  final int total_vnpay;

  RequestPaymentFee({required this.total_vnpay});
}

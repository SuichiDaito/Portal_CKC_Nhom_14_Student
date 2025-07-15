abstract class PaymentRequestFeeEvent {}

class RequestPaymentFee extends PaymentRequestFeeEvent {
  final int id;
  final int total_vnpay;

  RequestPaymentFee(this.id, this.total_vnpay);
}

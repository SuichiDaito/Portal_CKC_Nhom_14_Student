abstract class PaymentClassSubjectEvent {}

class RequestPaymentClassSubjectEvent extends PaymentClassSubjectEvent {
  final int id_lop_hoc;
  final int id_mon_hoc;
  RequestPaymentClassSubjectEvent({
    required this.id_lop_hoc,
    required this.id_mon_hoc,
  });
}

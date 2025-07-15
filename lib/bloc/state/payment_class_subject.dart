abstract class PaymentClassSubjectState {}

class PaymentClassSubjectStateInitial extends PaymentClassSubjectState {}

class PaymentClassSubjectStateLoading extends PaymentClassSubjectState {}

class PaymentClassSubjectStateLoaded extends PaymentClassSubjectState {
  final String url;

  PaymentClassSubjectStateLoaded(this.url);
}

class PaymentClassSubjectStateError extends PaymentClassSubjectState {
  final String message;

  PaymentClassSubjectStateError(this.message);
}

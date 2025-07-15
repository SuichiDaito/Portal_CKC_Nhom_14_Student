abstract class PaymentExamSecondState {}

class PaymentExamSecondStateInitial extends PaymentExamSecondState {}

class PaymentExamSecondStateLoading extends PaymentExamSecondState {}

class PaymentExamSecondStateLoaded extends PaymentExamSecondState {
  final String url;

  PaymentExamSecondStateLoaded(this.url);
}

class PaymentExamSecondStateError extends PaymentExamSecondState {
  final String message;

  PaymentExamSecondStateError(this.message);
}

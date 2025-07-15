abstract class PaymentFeeRequestState {}

class PaymentFeeRequestStateInitial extends PaymentFeeRequestState {}

class PaymentFeeRequestStateLoading extends PaymentFeeRequestState {}

class PaymentFeeRequestStateLoaded extends PaymentFeeRequestState {
  final String url;

  PaymentFeeRequestStateLoaded(this.url);
}

class PaymentFeeRequestStateError extends PaymentFeeRequestState {
  final String message;

  PaymentFeeRequestStateError(this.message);
}

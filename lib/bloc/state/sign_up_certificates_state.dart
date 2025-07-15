abstract class SignUpCertificatesState {}

class SignUpCertificatesStateInitial extends SignUpCertificatesState {}

class SignUpCertificatesStateLoading extends SignUpCertificatesState {}

class SignUpCertificatesStateLoaded extends SignUpCertificatesState {
  final String message;

  SignUpCertificatesStateLoaded(this.message);
}

class SignUpCertificatesStateError extends SignUpCertificatesState {
  final String message;

  SignUpCertificatesStateError(this.message);
}

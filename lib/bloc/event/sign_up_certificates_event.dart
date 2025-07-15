abstract class SignUpCertificatesEvent {}

class RequestSignupCertificatesEvent extends SignUpCertificatesEvent {
  final List<int> documentType;

  RequestSignupCertificatesEvent(this.documentType);
}

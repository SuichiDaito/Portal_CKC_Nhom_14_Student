import 'package:portal_ckc/api/model/student_certificates.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';

abstract class CertificatesState {}

class StudentReceiveListCertificatesSuccess extends CertificatesState {
  final List<Certificates> certificates;

  StudentReceiveListCertificatesSuccess(this.certificates);
}

class StudentReceiveListCertificatesLoading extends CertificatesState {
  StudentReceiveListCertificatesLoading();
}

class StudentReceiveListCertificatesInitial extends CertificatesState {
  StudentReceiveListCertificatesInitial();
}

class StudentCertificatesError extends CertificatesState {
  final String message;
  StudentCertificatesError(this.message);
}

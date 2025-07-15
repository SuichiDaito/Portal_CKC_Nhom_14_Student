import 'package:portal_ckc/api/model/student_certificates.dart';

abstract class StudentPaperCertificatesState {}

class StudentPaperCertificatesInitial extends StudentPaperCertificatesState {}

class StudentPaperCertificatesLoading extends StudentPaperCertificatesState {}

class StudentPaperCertificatesLoaded extends StudentPaperCertificatesState {
  final List<LoaiGiay> papers;

  StudentPaperCertificatesLoaded(this.papers);
}

class StudentPaperCertificatesError extends StudentPaperCertificatesState {
  final String message;

  StudentPaperCertificatesError(this.message);
}

class StudentPaperCertificatesSuccess extends StudentPaperCertificatesState {
  final String message;

  StudentPaperCertificatesSuccess(this.message);
}

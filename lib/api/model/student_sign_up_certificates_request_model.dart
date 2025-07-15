class StudentSignUpCertificatesRequestModel {
  final List<int> documentType;

  StudentSignUpCertificatesRequestModel({required this.documentType});

  Map<String, dynamic> toJson() {
    return {'document_type': documentType};
  }
}

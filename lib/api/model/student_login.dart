class StudentLogin {
  final String ma_sv;
  final String password;

  StudentLogin({required this.ma_sv, required this.password});

  Map<String, dynamic> toJson() {
    return {'ma_sv': ma_sv, 'password': password};
  }
}

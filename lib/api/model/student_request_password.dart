class StudentRequestChangePassword {
  final String idStudent;
  final int typeAccount;

  StudentRequestChangePassword({
    required this.idStudent,
    required this.typeAccount,
  });

  Map<String, dynamic> toJson() {
    return {'ma_sv': idStudent, 'loai': typeAccount};
  }
}

class StudentRequestPassword {
  final String status;
  final String message;
  final DataResponse data;

  StudentRequestPassword({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StudentRequestPassword.fromJson(Map<String, dynamic> json) {
    return StudentRequestPassword(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: DataResponse.fromJson(json['data'] ?? {}),
    );
  }
}

class DataResponse {
  final String idStudent;
  final String nameStudent;
  final String email;
  final String typeAccount;

  DataResponse({
    required this.idStudent,
    required this.nameStudent,
    required this.email,
    required this.typeAccount,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    return DataResponse(
      idStudent: json['ma_sv'] ?? '',
      nameStudent: json['ho_ten'] ?? '',
      email: json['email'] ?? '',
      typeAccount: json['loai'] ?? '',
    );
  }
}

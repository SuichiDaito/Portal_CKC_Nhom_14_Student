
  class StudentPayment {
  final int id;
  final String maSv;
  final int idHoSo;
  final String password;
  final int trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  StudentPayment({
    required this.id,
    required this.maSv,
    required this.idHoSo,
    required this.password,
    required this.trangThai,
    this.createdAt,
    this.updatedAt,
  });

  factory StudentPayment.fromJson(Map<String, dynamic> json) {
    return StudentPayment(
      id: json['id'],
      maSv: json['ma_sv'],
      idHoSo: json['id_ho_so'],
      password: json['password'],
      trangThai: json['trang_thai'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ma_sv': maSv,
      'id_ho_so': idHoSo,
      'password': password,
      'trang_thai': trangThai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

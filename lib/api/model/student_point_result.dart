class KetQuaModel {
  final bool success;
  final Map<String, List<MonHoc>> ketQua;

  KetQuaModel({required this.success, required this.ketQua});

  factory KetQuaModel.fromJson(Map<String, dynamic> json) {
    return KetQuaModel(
      success: json['success'],
      ketQua: (json['ket_qua'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List).map((e) => MonHoc.fromJson(e)).toList(),
        ),
      ),
    );
  }
}

class MonHoc {
  final String tenHocKy;
  final String tenMon;
  final int tinChi;
  final String tongKet;

  MonHoc({
    required this.tenHocKy,
    required this.tenMon,
    required this.tinChi,
    required this.tongKet,
  });

  factory MonHoc.fromJson(Map<String, dynamic> json) {
    return MonHoc(
      tenHocKy: json['ten_hoc_ky'],
      tenMon: json['ten_mon'],
      tinChi: json['tin_chi'] ?? 0,
      tongKet: json['tongket'],
    );
  }
}

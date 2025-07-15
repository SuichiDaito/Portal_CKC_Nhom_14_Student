class Subject {
  final String tenMon;
  final String? soTinChi;
  final String diemTongKet;

  Subject({required this.tenMon, this.soTinChi, required this.diemTongKet});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      tenMon: json['ten_mon'] ?? '',
      soTinChi: json['so_tin_chi']?.toString(), // Có thể null
      diemTongKet:
          json['diem_tong_ket']?.toString() ??
          '-', // Dù là double hay string đều convert sang string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ten_mon': tenMon,
      'so_tin_chi': soTinChi,
      'diem_tong_ket': diemTongKet,
    };
  }
}

class MainModel {
  final bool success;
  final Map<String, List<Subject>> monTheoHocKy;

  MainModel({required this.success, required this.monTheoHocKy});

  factory MainModel.fromJson(Map<String, dynamic> json) {
    final rawMap = json['monTheoHocKy'] as Map<String, dynamic>? ?? {};

    final Map<String, List<Subject>> parsedMap = {};
    rawMap.forEach((ky, monList) {
      parsedMap[ky] = (monList as List)
          .map((mon) => Subject.fromJson(mon as Map<String, dynamic>))
          .toList();
    });

    return MainModel(
      success: json['success'] ?? false,
      monTheoHocKy: parsedMap,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> mapped = {};
    monTheoHocKy.forEach((ky, monList) {
      mapped[ky] = monList.map((mon) => mon.toJson()).toList();
    });

    return {'success': success, 'monTheoHocKy': mapped};
  }
}

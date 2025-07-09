class Subject {
  final String tenMon;
  final int? soTinChi;
  final String diemTongKet;

  Subject({
    required this.tenMon,
    required this.soTinChi,
    required this.diemTongKet,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      tenMon: json['ten_mon'] ?? '',
      soTinChi: json['so_tin_chi'],
      diemTongKet: json['diem_tong_ket'] ?? '-',
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
    final rawMap = json['monTheoHocKy'] as Map<String, dynamic>;

    final mapped = rawMap.map((ky, list) {
      final subjects = (list as List)
          .map((item) => Subject.fromJson(item))
          .toList();
      return MapEntry(ky, subjects);
    });

    return MainModel(success: json['success'] ?? false, monTheoHocKy: mapped);
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'monTheoHocKy': monTheoHocKy.map(
        (ky, list) => MapEntry(ky, list.map((item) => item.toJson()).toList()),
      ),
    };
  }
}

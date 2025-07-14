class ListTrainingPoints {
  List<ChuongTrinhDaoTao> listPoint;

  ListTrainingPoints({required this.listPoint});

  factory ListTrainingPoints.fromJson(Map<String, dynamic> json) {
    return ListTrainingPoints(
      listPoint: (json['data'] as List<dynamic>)
          .map((item) => ChuongTrinhDaoTao.fromJson(item))
          .toList(),
    );
  }
}

class ChuongTrinhDaoTao {
  final int id;
  final int idSinhVien;
  final int idNam;
  final String xepLoai;
  final int thoiGian;
  final NamHocModel? namHoc;

  ChuongTrinhDaoTao({
    required this.id,
    required this.idSinhVien,
    required this.idNam,
    required this.xepLoai,
    required this.thoiGian,
    required this.namHoc,
  });

  factory ChuongTrinhDaoTao.fromJson(Map<String, dynamic> json) {
    return ChuongTrinhDaoTao(
      id: json['id'] ?? 0,
      idSinhVien: int.tryParse(json['id_sinh_vien'] ?? '') ?? 0,
      idNam: int.tryParse(json['id_nam'] ?? '') ?? 0,
      xepLoai: json['xep_loai'] ?? '',
      thoiGian: int.tryParse(json['thoi_gian'] ?? '') ?? 0,
      namHoc: json['nam_hoc'] != null
          ? NamHocModel.fromJson(json['nam_hoc'])
          : null,
    );
  }
}

class NamHocModel {
  final int id;
  final String namBatDau;

  NamHocModel({required this.id, required this.namBatDau});

  factory NamHocModel.fromJson(Map<String, dynamic> json) {
    return NamHocModel(
      id: json['id'] ?? 0,
      namBatDau: json['nam_bat_dau'] ?? '',
    );
  }
}

import 'package:portal_ckc/api/model/exam_model.dart';

class GiangVienResponse {
  final String status;
  final List<GiangVien> data;

  GiangVienResponse({required this.status, required this.data});

  factory GiangVienResponse.fromJson(Map<String, dynamic> json) {
    return GiangVienResponse(
      status: json['status'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => GiangVien.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class GiangVien {
  final int id;
  final int idHoSo;
  final int idBoMon;
  final String taiKhoan;
  final int trangThai;
  final HoSo hoSo;

  GiangVien({
    required this.id,
    required this.idHoSo,
    required this.idBoMon,
    required this.taiKhoan,
    required this.trangThai,
    required this.hoSo,
  });

  factory GiangVien.fromJson(Map<String, dynamic> json) {
    return GiangVien(
      id: json['id'],
      idHoSo: json['id_ho_so'],
      idBoMon: json['id_bo_mon'],
      taiKhoan: json['tai_khoan'],
      trangThai: json['trang_thai'],
      hoSo: HoSo.fromJson(json['ho_so']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_ho_so': idHoSo,
    'id_bo_mon': idBoMon,
    'tai_khoan': taiKhoan,
    'trang_thai': trangThai,
    'ho_so': hoSo.toJson(),
  };
}

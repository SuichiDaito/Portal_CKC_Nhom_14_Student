import 'package:portal_ckc/api/model/student_login.dart';

class SinhVienHocPhiResponse {
  final SinhVien sinhVien;
  final HocKy? hocKyHienTai;
  final HocPhi hocPhi;

  SinhVienHocPhiResponse({
    required this.sinhVien,
    required this.hocKyHienTai,
    required this.hocPhi,
  });

  factory SinhVienHocPhiResponse.fromJson(Map<String, dynamic> json) {
    return SinhVienHocPhiResponse(
      sinhVien: SinhVien.fromJson(json['sinhVien']),
      hocKyHienTai: json['hocKyHienTai'] != null
          ? HocKy.fromJson(json['hocKyHienTai'])
          : null,
      hocPhi: HocPhi.fromJson(json['hocPhi']),
    );
  }
}

class Lop {
  final int id;
  final String tenLop;
  final int idNienKhoa;
  final int idGvcn;
  final int idNganhHoc;
  final int siSo;

  Lop({
    required this.id,
    required this.tenLop,
    required this.idNienKhoa,
    required this.idGvcn,
    required this.idNganhHoc,
    required this.siSo,
  });

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(
      id: json['id'],
      tenLop: json['ten_lop'],
      idNienKhoa: json['id_nien_khoa'],
      idGvcn: json['id_gvcn'],
      idNganhHoc: json['id_nganh_hoc'],
      siSo: json['si_so'],
    );
  }
}

class HocPhi {
  final int id;
  final int idHocKy;
  final int idSinhVien;
  final String tongTien;
  final int trangThai;
  final String? ngayDong;

  final HocKy hocKy;

  HocPhi({
    required this.id,
    required this.idHocKy,
    required this.idSinhVien,
    required this.tongTien,
    required this.trangThai,
    this.ngayDong,

    required this.hocKy,
  });

  factory HocPhi.fromJson(Map<String, dynamic> json) {
    return HocPhi(
      id: json['id'],
      idHocKy: json['id_hoc_ky'],
      idSinhVien: json['id_sinh_vien'],
      tongTien: json['tong_tien'],
      trangThai: json['trang_thai'],
      ngayDong: json['ngay_dong'],

      hocKy: HocKy.fromJson(json['hoc_ky']),
    );
  }
}

class HocKy {
  final int id;
  final int idNienKhoa;
  final String tenHocKy;
  final String ngayBatDau;
  final String ngayKetThuc;

  HocKy({
    required this.id,
    required this.idNienKhoa,
    required this.tenHocKy,
    required this.ngayBatDau,
    required this.ngayKetThuc,
  });

  factory HocKy.fromJson(Map<String, dynamic> json) {
    return HocKy(
      id: json['id'],
      idNienKhoa: json['id_nien_khoa'],
      tenHocKy: json['ten_hoc_ky'],
      ngayBatDau: json['ngay_bat_dau'],
      ngayKetThuc: json['ngay_ket_thuc'],
    );
  }
}

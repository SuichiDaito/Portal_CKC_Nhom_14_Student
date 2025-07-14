import 'dart:convert';

class ChuongTrinhDaoTaoResponse {
  final String? status;
  final List<TrainingProgram>? chuongTrinhDaoTao;

  ChuongTrinhDaoTaoResponse({this.status, this.chuongTrinhDaoTao});

  factory ChuongTrinhDaoTaoResponse.fromJson(Map<String, dynamic> json) {
    return ChuongTrinhDaoTaoResponse(
      status: json['status'] as String?,
      chuongTrinhDaoTao: (json['chuong_trinh_dao_tao'] as List?)
          ?.map((e) => TrainingProgram.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'chuong_trinh_dao_tao': chuongTrinhDaoTao?.map((e) => e.toJson()).toList(),
  };
}

class TrainingProgram {
  final int? id;
  final int? idChuyenNganh;
  final String? tenChuongTrinhDaoTao;
  final String? tongTinChi;
  final String? trangThai;
  final String? thoiGian;
  final String? createdAt;
  final String? updatedAt;
  final List<ProgramDetail>? chiTietChuongTrinhDaoTao;

  TrainingProgram({
    this.id,
    this.idChuyenNganh,
    this.tenChuongTrinhDaoTao,
    this.tongTinChi,
    this.trangThai,
    this.thoiGian,
    this.createdAt,
    this.updatedAt,
    this.chiTietChuongTrinhDaoTao,
  });

  factory TrainingProgram.fromJson(Map<String, dynamic> json) {
    return TrainingProgram(
      id: json['id'] as int?,
      idChuyenNganh: json['id_chuyen_nganh'] as int?,
      tenChuongTrinhDaoTao: json['ten_chuong_trinh_dao_tao'] as String?,
      tongTinChi: json['tong_tin_chi'] as String?,
      trangThai: json['trang_thai'] as String?,
      thoiGian: json['thoi_gian'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      chiTietChuongTrinhDaoTao: (json['chi_tiet_chuong_trinh_dao_tao'] as List?)
          ?.map((e) => ProgramDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_chuyen_nganh': idChuyenNganh,
    'ten_chuong_trinh_dao_tao': tenChuongTrinhDaoTao,
    'tong_tin_chi': tongTinChi,
    'trang_thai': trangThai,
    'thoi_gian': thoiGian,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'chi_tiet_chuong_trinh_dao_tao': chiTietChuongTrinhDaoTao
        ?.map((e) => e.toJson())
        .toList(),
  };
}

class ProgramDetail {
  final int? id;
  final int? idChuongTrinhDaoTao;
  final int? idMonHoc;
  final int? idHocKy;
  final String? soTiet;
  final String? soTinChi;
  final String? createdAt;
  final String? updatedAt;
  final Subject? monHoc;

  ProgramDetail({
    this.id,
    this.idChuongTrinhDaoTao,
    this.idMonHoc,
    this.idHocKy,
    this.soTiet,
    this.soTinChi,
    this.createdAt,
    this.updatedAt,
    this.monHoc,
  });

  factory ProgramDetail.fromJson(Map<String, dynamic> json) {
    return ProgramDetail(
      id: json['id'] as int?,
      idChuongTrinhDaoTao: json['id_chuong_trinh_dao_tao'] as int?,
      idMonHoc: json['id_mon_hoc'] as int?,
      idHocKy: json['id_hoc_ky'] as int?,
      soTiet: json['so_tiet'] as String?,
      soTinChi: json['so_tin_chi'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      monHoc: json['mon_hoc'] != null
          ? Subject.fromJson(json['mon_hoc'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_chuong_trinh_dao_tao': idChuongTrinhDaoTao,
    'id_mon_hoc': idMonHoc,
    'id_hoc_ky': idHocKy,
    'so_tiet': soTiet,
    'so_tin_chi': soTinChi,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'mon_hoc': monHoc?.toJson(),
  };
}

class Subject {
  final int? id;
  final String? tenMon;
  final String? loaiMonHoc;
  final String? createdAt;
  final String? updatedAt;

  Subject({
    this.id,
    this.tenMon,
    this.loaiMonHoc,
    this.createdAt,
    this.updatedAt,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json['id'] as int?,
    tenMon: json['ten_mon'] as String?,
    loaiMonHoc: json['loai_mon_hoc'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'ten_mon': tenMon,
    'loai_mon_hoc': loaiMonHoc,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

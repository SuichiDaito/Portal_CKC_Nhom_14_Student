class ChuongTrinhDaoTaoResponse {
  final String status;
  final List<ChuongTrinhDaoTao> chuongTrinhDaoTao;

  ChuongTrinhDaoTaoResponse({
    required this.status,
    required this.chuongTrinhDaoTao,
  });

  factory ChuongTrinhDaoTaoResponse.fromJson(Map<String, dynamic> json) {
    return ChuongTrinhDaoTaoResponse(
      status: json['status'],
      chuongTrinhDaoTao: List<ChuongTrinhDaoTao>.from(
        json['chuong_trinh_dao_tao'].map((x) => ChuongTrinhDaoTao.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'chuong_trinh_dao_tao': chuongTrinhDaoTao.map((x) => x.toJson()).toList(),
  };
}

class ChuongTrinhDaoTao {
  final int id;
  final int idChuyenNganh;
  final String tenChuongTrinhDaoTao;
  final int tongTinChi;
  final int trangThai;
  final int thoiGian;
  final List<ChiTietChuongTrinhDaoTao> chiTietChuongTrinhDaoTao;

  ChuongTrinhDaoTao({
    required this.id,
    required this.idChuyenNganh,
    required this.tenChuongTrinhDaoTao,
    required this.tongTinChi,
    required this.trangThai,
    required this.thoiGian,
    required this.chiTietChuongTrinhDaoTao,
  });

  factory ChuongTrinhDaoTao.fromJson(Map<String, dynamic> json) {
    return ChuongTrinhDaoTao(
      id: json['id'] ?? 0,
      idChuyenNganh: json['id_chuyen_nganh'] ?? 0,
      tenChuongTrinhDaoTao: json['ten_chuong_trinh_dao_tao'] ?? '',
      tongTinChi: json['tong_tin_chi'] ?? 0,
      trangThai: json['trang_thai'] ?? 0,
      thoiGian: json['thoi_gian'] ?? 0,
      chiTietChuongTrinhDaoTao: List<ChiTietChuongTrinhDaoTao>.from(
        json['chi_tiet_chuong_trinh_dao_tao'].map(
          (x) => ChiTietChuongTrinhDaoTao.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_chuyen_nganh': idChuyenNganh,
    'ten_chuong_trinh_dao_tao': tenChuongTrinhDaoTao,
    'tong_tin_chi': tongTinChi,
    'trang_thai': trangThai,
    'thoi_gian': thoiGian,
    'chi_tiet_chuong_trinh_dao_tao': chiTietChuongTrinhDaoTao
        .map((x) => x.toJson())
        .toList(),
  };
}

class ChiTietChuongTrinhDaoTao {
  final int id;
  final int idChuongTrinhDaoTao;
  final int idMonHoc;
  final int idHocKy;
  final int soTiet;
  final int soTinChi;
  final MonHoc monHoc;

  ChiTietChuongTrinhDaoTao({
    required this.id,
    required this.idChuongTrinhDaoTao,
    required this.idMonHoc,
    required this.idHocKy,
    required this.soTiet,
    required this.soTinChi,
    required this.monHoc,
  });

  factory ChiTietChuongTrinhDaoTao.fromJson(Map<String, dynamic> json) {
    return ChiTietChuongTrinhDaoTao(
      id: json['id'],
      idChuongTrinhDaoTao: json['id_chuong_trinh_dao_tao'] ?? 0,
      idMonHoc: json['id_mon_hoc'] ?? 0,
      idHocKy: json['id_hoc_ky'] ?? 0,
      soTiet: json['so_tiet'] ?? 0,
      soTinChi: json['so_tin_chi'] ?? 0,
      monHoc: MonHoc.fromJson(json['mon_hoc']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_chuong_trinh_dao_tao': idChuongTrinhDaoTao,
    'id_mon_hoc': idMonHoc,
    'id_hoc_ky': idHocKy,
    'so_tiet': soTiet,
    'so_tin_chi': soTinChi,
    'mon_hoc': monHoc.toJson(),
  };
}

class MonHoc {
  final int id;
  final String tenMon;
  final int loaiMonHoc;

  MonHoc({required this.id, required this.tenMon, required this.loaiMonHoc});

  factory MonHoc.fromJson(Map<String, dynamic> json) {
    return MonHoc(
      id: json['id'] ?? 0,
      tenMon: json['ten_mon'] ?? '',
      loaiMonHoc: json['loai_mon_hoc'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'ten_mon': tenMon,
    'loai_mon_hoc': loaiMonHoc,
  };
}

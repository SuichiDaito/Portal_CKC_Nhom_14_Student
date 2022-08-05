class MainResponse {
  final SinhVien? sinhVien;
  final HocKyHienTai? hocKyHienTai;
  final HocPhi? hocPhi;

  MainResponse({
    required this.sinhVien,
    required this.hocKyHienTai,
    required this.hocPhi,
  });

  factory MainResponse.fromJson(Map<String, dynamic> json) {
    return MainResponse(
      sinhVien: json['sinhVien'] != null
          ? SinhVien.fromJson(json['sinhVien'])
          : null,
      hocKyHienTai: json['hocKyHienTai'] != null
          ? HocKyHienTai.fromJson(json['hocKyHienTai'])
          : null,
      hocPhi: json['hocPhi'] != null ? HocPhi.fromJson(json['hocPhi']) : null,
    );
  }
}

class SinhVien {
  final int id;
  final String maSv;
  final int idHoSo;
  final String password;
  final int trangThai;
  final List<DanhSachSinhVien> danhSachSinhVien;

  SinhVien({
    required this.id,
    required this.maSv,
    required this.idHoSo,
    required this.password,
    required this.trangThai,
    required this.danhSachSinhVien,
  });

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json['id'],
      maSv: json['ma_sv'],
      idHoSo: json['id_ho_so'],
      password: json['password'],
      trangThai: json['trang_thai'],
      danhSachSinhVien: (json['danh_sach_sinh_vien'] as List<dynamic>)
          .map((e) => DanhSachSinhVien.fromJson(e))
          .toList(),
    );
  }
}

class DanhSachSinhVien {
  final int id;
  final int idLop;
  final int idSinhVien;
  final int chucVu;
  final Lop lop;

  DanhSachSinhVien({
    required this.id,
    required this.idLop,
    required this.idSinhVien,
    required this.chucVu,
    required this.lop,
  });

  factory DanhSachSinhVien.fromJson(Map<String, dynamic> json) {
    return DanhSachSinhVien(
      id: json['id'],
      idLop: json['id_lop'],
      idSinhVien: json['id_sinh_vien'],
      chucVu: json['chuc_vu'],
      lop: Lop.fromJson(json['lop']),
    );
  }
}

class Lop {
  final int id;
  final String tenLop;
  final int idNienKhoa;
  final int idGvcn;
  final int idChuyenNganh;
  final int siSo;
  final NienKhoa? nienKhoa;

  Lop({
    required this.id,
    required this.tenLop,
    required this.idNienKhoa,
    required this.idGvcn,
    required this.idChuyenNganh,
    required this.siSo,
    this.nienKhoa,
  });

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(
      id: json['id'],
      tenLop: json['ten_lop'],
      idNienKhoa: json['id_nien_khoa'],
      idGvcn: json['id_gvcn'],
      idChuyenNganh: json['id_chuyen_nganh'],
      siSo: json['si_so'],
      nienKhoa: json['nien_khoa'] != null
          ? NienKhoa.fromJson(json['nien_khoa'])
          : null,
    );
  }
}

class NienKhoa {
  final int id;
  final String tenNienKhoa;
  final String namBatDau;
  final String namKetThuc;
  final int trangThai;
  final String? createdAt;
  final String? updatedAt;

  NienKhoa({
    required this.id,
    required this.tenNienKhoa,
    required this.namBatDau,
    required this.namKetThuc,
    required this.trangThai,
    this.createdAt,
    this.updatedAt,
  });

  factory NienKhoa.fromJson(Map<String, dynamic> json) {
    return NienKhoa(
      id: json['id'],
      tenNienKhoa: json['ten_nien_khoa'],
      namBatDau: json['nam_bat_dau'],
      namKetThuc: json['nam_ket_thuc'],
      trangThai: json['trang_thai'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class HocKyHienTai {
  final int id;
  final int idNienKhoa;
  final String tenHocKy;
  final String ngayBatDau;
  final String ngayKetThuc;
  final String createdAt;
  final String updatedAt;

  HocKyHienTai({
    required this.id,
    required this.idNienKhoa,
    required this.tenHocKy,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HocKyHienTai.fromJson(Map<String, dynamic> json) {
    return HocKyHienTai(
      id: json['id'],
      idNienKhoa: json['id_nien_khoa'],
      tenHocKy: json['ten_hoc_ky'],
      ngayBatDau: json['ngay_bat_dau'],
      ngayKetThuc: json['ngay_ket_thuc'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
  final String? createdAt;
  final String? updatedAt;

  HocPhi({
    required this.id,
    required this.idHocKy,
    required this.idSinhVien,
    required this.tongTien,
    required this.trangThai,
    this.ngayDong,
    this.createdAt,
    this.updatedAt,
  });

  factory HocPhi.fromJson(Map<String, dynamic> json) {
    return HocPhi(
      id: json['id'],
      idHocKy: json['id_hoc_ky'],
      idSinhVien: json['id_sinh_vien'],
      tongTien: json['tong_tien'],
      trangThai: json['trang_thai'],
      ngayDong: json['ngay_dong'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

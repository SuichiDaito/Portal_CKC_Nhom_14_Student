class MainResponse {
  final SinhVien? sinhVien;
  final List<HocPhi>? hocPhi;

  MainResponse({this.sinhVien, this.hocPhi});

  factory MainResponse.fromJson(Map<String, dynamic> json) {
    return MainResponse(
      sinhVien: json['sinhVien'] != null
          ? SinhVien.fromJson(json['sinhVien'])
          : null,
      hocPhi: (json['hocPhi'] as List<dynamic>?)
          ?.map((e) => HocPhi.fromJson(e))
          .toList(),
    );
  }
}

class SinhVien {
  final int? id;
  final String? maSv;
  final int? idHoSo;
  final String? password;
  final int? trangThai;
  final String? createdAt;
  final String? updatedAt;
  final List<DanhSachSinhVien>? danhSachSinhVien;

  SinhVien({
    this.id,
    this.maSv,
    this.idHoSo,
    this.password,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.danhSachSinhVien,
  });

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json['id'] as int?,
      maSv: json['ma_sv'] as String?,
      idHoSo: json['id_ho_so'] as int?,
      password: json['password'] as String?,
      trangThai: json['trang_thai'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      danhSachSinhVien: (json['danh_sach_sinh_vien'] as List<dynamic>?)
          ?.map((e) => DanhSachSinhVien.fromJson(e))
          .toList(),
    );
  }
}

class DanhSachSinhVien {
  final int? id;
  final int? idLop;
  final int? idSinhVien;
  final int? chucVu;
  final String? createdAt;
  final String? updatedAt;
  final Lop? lop;

  DanhSachSinhVien({
    this.id,
    this.idLop,
    this.idSinhVien,
    this.chucVu,
    this.createdAt,
    this.updatedAt,
    this.lop,
  });

  factory DanhSachSinhVien.fromJson(Map<String, dynamic> json) {
    return DanhSachSinhVien(
      id: json['id'] as int?,
      idLop: json['id_lop'] as int?,
      idSinhVien: json['id_sinh_vien'] as int?,
      chucVu: json['chuc_vu'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      lop: json['lop'] != null ? Lop.fromJson(json['lop']) : null,
    );
  }
}

class Lop {
  final int? id;
  final String? tenLop;
  final int? idNienKhoa;
  final int? idGvcn;
  final int? idChuyenNganh;
  final String? siSo;
  final String? createdAt;
  final String? updatedAt;
  final NienKhoa? nienKhoa;

  Lop({
    this.id,
    this.tenLop,
    this.idNienKhoa,
    this.idGvcn,
    this.idChuyenNganh,
    this.siSo,
    this.createdAt,
    this.updatedAt,
    this.nienKhoa,
  });

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(
      id: json['id'] as int?,
      tenLop: json['ten_lop'] as String?,
      idNienKhoa: json['id_nien_khoa'] as int?,
      idGvcn: json['id_gvcn'] as int?,
      idChuyenNganh: json['id_chuyen_nganh'] as int?,
      siSo: json['si_so'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      nienKhoa: json['nien_khoa'] != null
          ? NienKhoa.fromJson(json['nien_khoa'])
          : null,
    );
  }
}

class NienKhoa {
  final int? id;
  final String? tenNienKhoa;
  final String? namBatDau;
  final String? namKetThuc;
  final String? trangThai;
  final String? createdAt;
  final String? updatedAt;

  NienKhoa({
    this.id,
    this.tenNienKhoa,
    this.namBatDau,
    this.namKetThuc,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
  });

  factory NienKhoa.fromJson(Map<String, dynamic> json) {
    return NienKhoa(
      id: json['id'] as int?,
      tenNienKhoa: json['ten_nien_khoa'] as String?,
      namBatDau: json['nam_bat_dau'] as String?,
      namKetThuc: json['nam_ket_thuc'] as String?,
      trangThai: json['trang_thai'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class HocPhi {
  final int? id;
  final int? idHocKy;
  final int? idSinhVien;
  final String? tongTien;
  final int? trangThai;
  final String? ngayDong;
  final String? createdAt;
  final String? updatedAt;
  final HocKy? hocKy;

  HocPhi({
    this.id,
    this.idHocKy,
    this.idSinhVien,
    this.tongTien,
    this.trangThai,
    this.ngayDong,
    this.createdAt,
    this.updatedAt,
    this.hocKy,
  });

  factory HocPhi.fromJson(Map<String, dynamic> json) {
    return HocPhi(
      id: json['id'] as int?,
      idHocKy: json['id_hoc_ky'] as int?,
      idSinhVien: json['id_sinh_vien'] as int?,
      tongTien: json['tong_tien'] as String?,
      trangThai: json['trang_thai'] as int?,
      ngayDong: json['ngay_dong'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      hocKy: json['hoc_ky'] != null ? HocKy.fromJson(json['hoc_ky']) : null,
    );
  }
}

class HocKy {
  final int? id;
  final int? idNienKhoa;
  final String? tenHocKy;
  final String? ngayBatDau;
  final String? ngayKetThuc;
  final String? createdAt;
  final String? updatedAt;

  HocKy({
    this.id,
    this.idNienKhoa,
    this.tenHocKy,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.createdAt,
    this.updatedAt,
  });

  factory HocKy.fromJson(Map<String, dynamic> json) {
    return HocKy(
      id: json['id'] as int?,
      idNienKhoa: json['id_nien_khoa'] as int?,
      tenHocKy: json['ten_hoc_ky'] as String?,
      ngayBatDau: json['ngay_bat_dau'] as String?,
      ngayKetThuc: json['ngay_ket_thuc'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

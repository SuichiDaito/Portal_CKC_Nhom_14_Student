class StudentInfoModel {
  final SinhVien? sinhVien;
  final HocPhi? hocPhi;

  StudentInfoModel({this.sinhVien, this.hocPhi});

  factory StudentInfoModel.fromJson(Map<String, dynamic> json) {
    return StudentInfoModel(
      sinhVien: SinhVien.fromJson(json['sinhVien']),
      hocPhi: json['hocPhi'] != null ? HocPhi.fromJson(json['hocPhi']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'sinhVien': sinhVien?.toJson(), 'hocPhi': hocPhi?.toJson()};
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
      id: json['id'],
      maSv: json['ma_sv'],
      idHoSo: json['id_ho_so'],
      password: json['password'],
      trangThai: json['trang_thai'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      danhSachSinhVien: (json['danh_sach_sinh_vien'] as List<dynamic>?)
          ?.map((e) => DanhSachSinhVien.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ma_sv': maSv,
      'id_ho_so': idHoSo,
      'password': password,
      'trang_thai': trangThai,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'danh_sach_sinh_vien': danhSachSinhVien?.map((e) => e.toJson()).toList(),
    };
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
      id: json['id'],
      idLop: json['id_lop'],
      idSinhVien: json['id_sinh_vien'],
      chucVu: json['chuc_vu'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      lop: json['lop'] != null ? Lop.fromJson(json['lop']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_lop': idLop,
      'id_sinh_vien': idSinhVien,
      'chuc_vu': chucVu,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'lop': lop?.toJson(),
    };
  }
}

class Lop {
  final int? id;
  final String? tenLop;
  final int? idNienKhoa;
  final int? idGvcn;
  final int? idChuyenNganh;
  final int? siSo;
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
      id: json['id'],
      tenLop: json['ten_lop'],
      idNienKhoa: json['id_nien_khoa'],
      idGvcn: json['id_gvcn'],
      idChuyenNganh: json['id_chuyen_nganh'],
      siSo: json['si_so'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      nienKhoa: json['nien_khoa'] != null
          ? NienKhoa.fromJson(json['nien_khoa'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_lop': tenLop,
      'id_nien_khoa': idNienKhoa,
      'id_gvcn': idGvcn,
      'id_chuyen_nganh': idChuyenNganh,
      'si_so': siSo,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'nien_khoa': nienKhoa?.toJson(),
    };
  }
}

class NienKhoa {
  final int? id;
  final String? tenNienKhoa;
  final String? namBatDau;
  final String? namKetThuc;
  final int? trangThai;
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
      id: json['id'],
      tenNienKhoa: json['ten_nien_khoa'],
      namBatDau: json['nam_bat_dau'],
      namKetThuc: json['nam_ket_thuc'],
      trangThai: json['trang_thai'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_nien_khoa': tenNienKhoa,
      'nam_bat_dau': namBatDau,
      'nam_ket_thuc': namKetThuc,
      'trang_thai': trangThai,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
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
      id: json['id'],
      idHocKy: json['id_hoc_ky'],
      idSinhVien: json['id_sinh_vien'],
      tongTien: json['tong_tien'],
      trangThai: json['trang_thai'],
      ngayDong: json['ngay_dong'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      hocKy: json['hoc_ky'] != null ? HocKy.fromJson(json['hoc_ky']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_hoc_ky': idHocKy,
      'id_sinh_vien': idSinhVien,
      'tong_tien': tongTien,
      'trang_thai': trangThai,
      'ngay_dong': ngayDong,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'hoc_ky': hocKy?.toJson(),
    };
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
      id: json['id'],
      idNienKhoa: json['id_nien_khoa'],
      tenHocKy: json['ten_hoc_ky'],
      ngayBatDau: json['ngay_bat_dau'],
      ngayKetThuc: json['ngay_ket_thuc'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_nien_khoa': idNienKhoa,
      'ten_hoc_ky': tenHocKy,
      'ngay_bat_dau': ngayBatDau,
      'ngay_ket_thuc': ngayKetThuc,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

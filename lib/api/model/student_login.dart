class StudentLogin {
  final String ma_sv;
  final String password;

  StudentLogin({required this.ma_sv, required this.password});

  Map<String, dynamic> toJson() {
    return {'ma_sv': ma_sv, 'password': password};
  }
}

class SinhVien {
  final int id;
  final String maSv;
  final int idHoSo;
  final String password;
  final int trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final HoSo hoSo;
  final List<DanhSachSinhVien> danhSachSinhVien;

  SinhVien({
    required this.id,
    required this.maSv,
    required this.idHoSo,
    required this.password,
    required this.trangThai,
    this.createdAt,
    this.updatedAt,
    required this.hoSo,
    required this.danhSachSinhVien,
  });

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json['id'],
      maSv: json['ma_sv'],
      idHoSo: json['id_ho_so'],
      password: json['password'],
      trangThai: json['trang_thai'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      hoSo: HoSo.fromJson(json['ho_so']),
      danhSachSinhVien: (json['danh_sach_sinh_vien'] as List)
          .map((e) => DanhSachSinhVien.fromJson(e))
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
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'ho_so': hoSo.toJson(),
      'danh_sach_sinh_vien': danhSachSinhVien.map((e) => e.toJson()).toList(),
    };
  }
}

class HoSo {
  final int id;
  final String hoTen;
  final String email;
  final String password;
  final String soDienThoai;
  final String ngaySinh;
  final String gioiTinh;
  final String cccd;
  final String diaChi;
  final String anh;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HoSo({
    required this.id,
    required this.hoTen,
    required this.email,
    required this.password,
    required this.soDienThoai,
    required this.ngaySinh,
    required this.gioiTinh,
    required this.cccd,
    required this.diaChi,
    required this.anh,
    this.createdAt,
    this.updatedAt,
  });

  factory HoSo.fromJson(Map<String, dynamic> json) {
    return HoSo(
      id: json['id'],
      hoTen: json['ho_ten'],
      email: json['email'],
      password: json['password'],
      soDienThoai: json['so_dien_thoai'],
      ngaySinh: json['ngay_sinh'],
      gioiTinh: json['gioi_tinh'],
      cccd: json['cccd'],
      diaChi: json['dia_chi'],
      anh: json['anh'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ho_ten': hoTen,
      'email': email,
      'password': password,
      'so_dien_thoai': soDienThoai,
      'ngay_sinh': ngaySinh,
      'gioi_tinh': gioiTinh,
      'cccd': cccd,
      'dia_chi': diaChi,
      'anh': anh,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class Lop {
  final int id;
  final String tenLop;
  final int idNienKhoa;
  final int idGvcn;
  final int idChuyenNganh;
  final int siSo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ChuyenNganh chuyenNganh;

  Lop({
    required this.id,
    required this.tenLop,
    required this.idNienKhoa,
    required this.idGvcn,
    required this.idChuyenNganh,
    required this.siSo,
    this.createdAt,
    this.updatedAt,
    required this.chuyenNganh,
  });

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(
      id: json['id'],
      tenLop: json['ten_lop'],
      idNienKhoa: json['id_nien_khoa'],
      idGvcn: json['id_gvcn'],
      idChuyenNganh: json['id_chuyen_nganh'],
      siSo: json['si_so'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      chuyenNganh: ChuyenNganh.fromJson(json['chuyen_nganh']),
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
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'chuyen_nganh': chuyenNganh.toJson(),
    };
  }
}

class ChuyenNganh {
  final int id;
  final String tenChuyenNganh;
  final int idKhoa;
  final int? idChuyenNganhCha;
  final int trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ChuyenNganh({
    required this.id,
    required this.tenChuyenNganh,
    required this.idKhoa,
    this.idChuyenNganhCha,
    required this.trangThai,
    this.createdAt,
    this.updatedAt,
  });

  factory ChuyenNganh.fromJson(Map<String, dynamic> json) {
    return ChuyenNganh(
      id: json['id'],
      tenChuyenNganh: json['ten_chuyen_nganh'],
      idKhoa: json['id_khoa'],
      idChuyenNganhCha: json['id_chuyen_nganh_cha'],
      trangThai: json['trang_thai'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_chuyen_nganh': tenChuyenNganh,
      'id_khoa': idKhoa,
      'id_chuyen_nganh_cha': idChuyenNganhCha,
      'trang_thai': trangThai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_lop': idLop,
      'id_sinh_vien': idSinhVien,
      'chuc_vu': chucVu,
    };
  }
}

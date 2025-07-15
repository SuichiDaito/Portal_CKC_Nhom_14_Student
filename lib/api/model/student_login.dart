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
  final String? createdAt;
  final String? updatedAt;
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      hoSo: HoSo.fromJson(json['ho_so']),
      danhSachSinhVien: (json['danh_sach_sinh_vien'] as List)
          .map((e) => DanhSachSinhVien.fromJson(e))
          .toList(),
    );
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
  final String? createdAt;
  final String? updatedAt;

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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Lop {
  final int id;
  final String tenLop;
  final int idNienKhoa;
  final int idGvcn;
  final int idChuyenNganh;
  final String siSo;
  final String? createdAt;
  final String? updatedAt;
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      chuyenNganh: ChuyenNganh.fromJson(json['chuyen_nganh']),
    );
  }
}

class ChuyenNganh {
  final int id;
  final String tenChuyenNganh;
  final int idKhoa;
  final int? idChuyenNganhCha;
  final String trangThai;
  final String? createdAt;
  final String? updatedAt;

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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class DanhSachSinhVien {
  final int id;
  final int idLop;
  final int idSinhVien;
  final int chucVu;
  final String? createdAt;
  final String? updatedAt;
  final Lop lop;

  DanhSachSinhVien({
    required this.id,
    required this.idLop,
    required this.idSinhVien,
    required this.chucVu,
    this.createdAt,
    this.updatedAt,
    required this.lop,
  });

  factory DanhSachSinhVien.fromJson(Map<String, dynamic> json) {
    return DanhSachSinhVien(
      id: json['id'],
      idLop: json['id_lop'],
      idSinhVien: json['id_sinh_vien'],
      chucVu: json['chuc_vu'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      lop: Lop.fromJson(json['lop']),
    );
  }
}

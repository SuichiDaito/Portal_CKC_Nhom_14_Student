class StudentLogin {
  final String ma_sv;
  final String password;

  StudentLogin({required this.ma_sv, required this.password});

  Map<String, dynamic> toJson() {
    return {'ma_sv': ma_sv, 'password': password};
  }
}

class SinhVien {
  SinhVien({
    required this.id,
    required this.maSv,
    required this.idLop,
    required this.idHoSo,
    this.idLopChuyenNganh,
    required this.chucVu,
    required this.password,
    required this.trangThai,
    this.hoSo,
    this.lop,
  });

  final int id;
  final String maSv;
  final int idLop;
  final int idHoSo;
  final int? idLopChuyenNganh;
  final int chucVu;
  final String password;
  final int trangThai;
  final HoSo? hoSo;
  final Lop? lop;

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json['id'] ?? '',
      maSv: json['ma_sv'] ?? '',
      idLop: json['id_lop'] ?? '',
      idHoSo: json['id_ho_so'] ?? '',
      idLopChuyenNganh: json['id_lop_chuyen_nganh'] ?? 0,
      chucVu: json['chuc_vu'] ?? '',
      password: json['password'] ?? '',
      trangThai: json['trang_thai'] ?? '',
      hoSo: json['ho_so'] != null ? HoSo.fromJson(json['ho_so']) : null,
      lop: json['lop'] != null ? Lop.fromJson(json['lop']) : null,
    );
  }
}

class HoSo {
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
  });

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

  factory HoSo.fromJson(Map<String, dynamic> json) {
    return HoSo(
      id: json['id'],
      hoTen: json['ho_ten'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      soDienThoai: json['so_dien_thoai'] ?? '',
      ngaySinh: json['ngay_sinh'] ?? '',
      gioiTinh: json['gioi_tinh'] ?? '',
      cccd: json['cccd'] ?? '',
      diaChi: json['dia_chi'] ?? '',
      anh: json['anh'] ?? '',
    );
  }
}

class Lop {
  Lop({
    required this.id,
    required this.tenLop,
    required this.idNienKhoa,
    required this.idGvcn,
    required this.idNganhHoc,
    required this.siSo,
  });

  int id;
  String tenLop;
  int idNienKhoa;
  int idGvcn;
  int idNganhHoc;
  int siSo;

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(
      id: json['id'] ?? 0,
      tenLop: json['ten_lop'] ?? '',
      idNienKhoa: json['id_nien_khoa'] ?? 0,
      idGvcn: json['id_gvcn'] ?? 0,
      idNganhHoc: json['id_nganh_hoc'] ?? 0,
      siSo: json['siSo'] ?? 0,
    );
  }
}

class StudentCertificates {
  List<Certificates> data;

  StudentCertificates({required this.data});

  factory StudentCertificates.fromJson(Map<String, dynamic> json) {
    return StudentCertificates(
      data: (json['data'] as List<dynamic>)
          .map((item) => Certificates.fromJson(item))
          .toList(),
    );
  }
}

class Certificates {
  Certificates({
    required this.id,
    required this.idSinhVien,
    required this.idGiangVien,
    required this.idLoaiGiay,
    required this.ngayDangKy,
    required this.ngayNhan,
    required this.trangThai,
    required this.loaiGiay,
    required this.sinhVien,
  });

  final int id;
  final int idSinhVien;
  final int idGiangVien;
  final int idLoaiGiay;
  final DateTime ngayDangKy;
  final DateTime ngayNhan;
  final int trangThai;
  final LoaiGiay loaiGiay;
  final Student sinhVien;

  factory Certificates.fromJson(Map<String, dynamic> json) {
    return Certificates(
      id: json['id'],
      idSinhVien: json['id_sinh_vien'],
      idGiangVien: json['id_giang_vien'] ?? 0,
      idLoaiGiay: json['id_loai_giay'],
      ngayDangKy: DateTime.parse(json['ngay_dang_ky']),
      ngayNhan: DateTime.parse(json['ngay_nhan']),
      trangThai: json['trang_thai'],
      loaiGiay: LoaiGiay.fromJson(json['loai_giay']),
      sinhVien: Student.fromJson(json['sinh_vien']),
    );
  }
}

class LoaiGiay {
  final int id;
  final String tenGiay;
  final int trangThai;

  LoaiGiay({required this.id, required this.tenGiay, required this.trangThai});

  factory LoaiGiay.fromJson(Map<String, dynamic> json) {
    return LoaiGiay(
      id: json['id'],
      tenGiay: json['ten_giay'],
      trangThai: json['trang_thai'],
    );
  }
}

class Student {
  Student({
    required this.id,
    required this.maSv,
    required this.idLop,
    required this.idHoSo,
    required this.idLopChuyenNganh,
    required this.chucVu,
    required this.password,
    required this.trangThai,
    required this.hoSo,
  });

  final int id;
  final String maSv;
  final int idLop;
  final int idHoSo;
  final int idLopChuyenNganh;
  final int chucVu;
  final String password;
  final int trangThai;
  final HoSo hoSo;

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      maSv: json['ma_sv'],
      idLop: json['id_lop'],
      idHoSo: json['id_ho_so'],
      idLopChuyenNganh: json['id_lop_chuyen_nganh'] ?? 0,
      chucVu: json['chuc_vu'],
      password: json['password'],
      trangThai: json['trang_thai'],
      hoSo: HoSo.fromJson(json['ho_so']),
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
      hoTen: json['ho_ten'],
      email: json['email'],
      password: json['password'],
      soDienThoai: json['so_dien_thoai'],
      ngaySinh: json['ngay_sinh'],
      gioiTinh: json['gioi_tinh'],
      cccd: json['cccd'],
      diaChi: json['dia_chi'],
      anh: json['anh'] ?? '',
    );
  }
}

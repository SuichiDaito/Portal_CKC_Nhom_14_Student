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
  final int id;
  final int idSinhVien;
  final int? idGiangVien;
  final int idLoaiGiay;
  final String? ngayDangKy;
  final String? ngayNhan;
  final String? trangThai;
  final String? createdAt;
  final String? updatedAt;
  final LoaiGiay? loaiGiay;
  final Student? sinhVien;

  Certificates({
    required this.id,
    required this.idSinhVien,
    this.idGiangVien,
    required this.idLoaiGiay,
    this.ngayDangKy,
    this.ngayNhan,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.loaiGiay,
    this.sinhVien,
  });

  factory Certificates.fromJson(Map<String, dynamic> json) {
    return Certificates(
      id: json['id'] ?? 0,
      idSinhVien: json['id_sinh_vien'] ?? 0,
      idGiangVien: json['id_giang_vien'],
      idLoaiGiay: json['id_loai_giay'] ?? 0,
      ngayDangKy: json['ngay_dang_ky'],
      ngayNhan: json['ngay_nhan'],
      trangThai: json['trang_thai'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      loaiGiay: json['loai_giay'] != null
          ? LoaiGiay.fromJson(json['loai_giay'])
          : null,
      sinhVien: json['sinh_vien'] != null
          ? Student.fromJson(json['sinh_vien'])
          : null,
    );
  }
}

class LoaiGiay {
  final int id;
  final String? tenGiay;
  final String? trangThai;
  final String? createdAt;
  final String? updatedAt;

  LoaiGiay({
    required this.id,
    this.tenGiay,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
  });

  factory LoaiGiay.fromJson(Map<String, dynamic> json) {
    return LoaiGiay(
      id: json['id'] ?? 0,
      tenGiay: json['ten_giay'],
      trangThai: json['trang_thai'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Student {
  final int id;
  final String? maSv;
  final int idHoSo;
  final String? password;
  final int? trangThai;
  final String? createdAt;
  final String? updatedAt;
  final HoSo? hoSo;

  Student({
    required this.id,
    this.maSv,
    required this.idHoSo,
    this.password,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.hoSo,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? 0,
      maSv: json['ma_sv'],
      idHoSo: json['id_ho_so'] ?? 0,
      password: json['password'],
      trangThai: json['trang_thai'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      hoSo: json['ho_so'] != null ? HoSo.fromJson(json['ho_so']) : null,
    );
  }
}


class HoSo {
  final int id;
  final String? hoTen;
  final String? email;
  final String? password;
  final String? soDienThoai;
  final String? ngaySinh;
  final String? gioiTinh;
  final String? cccd;
  final String? diaChi;
  final String? anh;
  final String? createdAt;
  final String? updatedAt;

  HoSo({
    required this.id,
    this.hoTen,
    this.email,
    this.password,
    this.soDienThoai,
    this.ngaySinh,
    this.gioiTinh,
    this.cccd,
    this.diaChi,
    this.anh,
    this.createdAt,
    this.updatedAt,
  });

  factory HoSo.fromJson(Map<String, dynamic> json) {
    return HoSo(
      id: json['id'] ?? 0,
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


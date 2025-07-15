class ResponseSinhVien {
  final String? status;
  final ThongTin? thongTin;
  final List<ListStudent>? danhSachSinhVien;

  ResponseSinhVien({this.status, this.thongTin, this.danhSachSinhVien});

  factory ResponseSinhVien.fromJson(Map<String, dynamic> json) {
    return ResponseSinhVien(
      status: json['status'] as String?,
      thongTin: json['thongTin'] != null
          ? ThongTin.fromJson(json['thongTin'])
          : null,
      danhSachSinhVien: (json['danhSachSinhVien'] as List<dynamic>?)
          ?.map((e) => ListStudent.fromJson(e))
          .toList(),
    );
  }
}

class ThongTin {
  final int? id;
  final int? idLop;
  final int? idSinhVien;
  final int? chucVu;
  final String? createdAt;
  final String? updatedAt;

  ThongTin({
    this.id,
    this.idLop,
    this.idSinhVien,
    this.chucVu,
    this.createdAt,
    this.updatedAt,
  });

  factory ThongTin.fromJson(Map<String, dynamic> json) {
    return ThongTin(
      id: json['id'] as int?,
      idLop: json['id_lop'] as int?,
      idSinhVien: json['id_sinh_vien'] as int?,
      chucVu: json['chuc_vu'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class ListStudent {
  final int? id;
  final int? idLop;
  final int? idSinhVien;
  final int? chucVu;
  final String? createdAt;
  final String? updatedAt;
  final SinhVien? sinhVien;

  ListStudent({
    this.id,
    this.idLop,
    this.idSinhVien,
    this.chucVu,
    this.createdAt,
    this.updatedAt,
    this.sinhVien,
  });

  factory ListStudent.fromJson(Map<String, dynamic> json) {
    return ListStudent(
      id: json['id'] as int?,
      idLop: json['id_lop'] as int?,
      idSinhVien: json['id_sinh_vien'] as int?,
      chucVu: json['chuc_vu'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      sinhVien: json['sinh_vien'] != null
          ? SinhVien.fromJson(json['sinh_vien'])
          : null,
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
  final HoSo? hoSo;

  SinhVien({
    this.id,
    this.maSv,
    this.idHoSo,
    this.password,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.hoSo,
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
      hoSo: json['ho_so'] != null ? HoSo.fromJson(json['ho_so']) : null,
    );
  }
}

class HoSo {
  final int? id;
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
    this.id,
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
      id: json['id'] as int?,
      hoTen: json['ho_ten'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      soDienThoai: json['so_dien_thoai'] as String?,
      ngaySinh: json['ngay_sinh'] as String?,
      gioiTinh: json['gioi_tinh'] as String?,
      cccd: json['cccd'] as String?,
      diaChi: json['dia_chi'] as String?,
      anh: json['anh'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

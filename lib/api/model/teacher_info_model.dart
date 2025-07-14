class GiaoVienResponse {
  final String? status;
  final List<GiaoVien>? data;

  GiaoVienResponse({this.status, this.data});

  factory GiaoVienResponse.fromJson(Map<String, dynamic> json) {
    return GiaoVienResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => GiaoVien.fromJson(e))
          .toList(),
    );
  }
}

class GiaoVien {
  final int? id;
  final int? idHoSo;
  final int? idBoMon;
  final String? taiKhoan;
  final String? trangThai;
  final String? createdAt;
  final String? updatedAt;
  final HoSo? hoSo;

  GiaoVien({
    this.id,
    this.idHoSo,
    this.idBoMon,
    this.taiKhoan,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.hoSo,
  });

  factory GiaoVien.fromJson(Map<String, dynamic> json) {
    return GiaoVien(
      id: json['id'] as int?,
      idHoSo: json['id_ho_so'] as int?,
      idBoMon: json['id_bo_mon'] as int?,
      taiKhoan: json['tai_khoan'] as String?,
      trangThai: json['trang_thai'] as String?,
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

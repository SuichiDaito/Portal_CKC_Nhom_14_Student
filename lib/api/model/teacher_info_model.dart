class GiangVienResponse {
  final String status;
  final List<GiangVien> data;

  GiangVienResponse({required this.status, required this.data});

  factory GiangVienResponse.fromJson(Map<String, dynamic> json) {
    return GiangVienResponse(
      status: json['status'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => GiangVien.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class GiangVien {
  final int id;
  final int idHoSo;
  final int idBoMon;
  final String taiKhoan;
  final int trangThai;
  final HoSo hoSo;

  GiangVien({
    required this.id,
    required this.idHoSo,
    required this.idBoMon,
    required this.taiKhoan,
    required this.trangThai,
    required this.hoSo,
  });

  factory GiangVien.fromJson(Map<String, dynamic> json) {
    return GiangVien(
      id: json['id'],
      idHoSo: json['id_ho_so'],
      idBoMon: json['id_bo_mon'],
      taiKhoan: json['tai_khoan'],
      trangThai: json['trang_thai'],
      hoSo: HoSo.fromJson(json['ho_so']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_ho_so': idHoSo,
    'id_bo_mon': idBoMon,
    'tai_khoan': taiKhoan,
    'trang_thai': trangThai,
    'ho_so': hoSo.toJson(),
  };
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
    );
  }

  Map<String, dynamic> toJson() => {
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
  };
}

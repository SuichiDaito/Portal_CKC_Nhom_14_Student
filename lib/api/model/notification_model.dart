class ThongBaoResponse {
  final String status;
  final List<ThongBao> data;

  ThongBaoResponse({required this.status, required this.data});

  factory ThongBaoResponse.fromJson(Map<String, dynamic> json) {
    return ThongBaoResponse(
      status: json['status'],
      data: List<ThongBao>.from(json['data'].map((x) => ThongBao.fromJson(x))),
    );
  }
}

class ThongBao {
  final int id;
  final int idGv;
  final String tuAi;
  final DateTime ngayGui;
  final String tieuDe;
  final String noiDung;
  final int trangThai;
  final GiangVien giangVien;
  final List<ChiTietThongBao> chiTietThongBao;
  final List<BinhLuan> binhLuans;

  ThongBao({
    required this.id,
    required this.idGv,
    required this.tuAi,
    required this.ngayGui,
    required this.tieuDe,
    required this.noiDung,
    required this.trangThai,
    required this.giangVien,
    required this.chiTietThongBao,
    required this.binhLuans,
  });

  factory ThongBao.fromJson(Map<String, dynamic> json) => ThongBao(
    id: json['id'],
    idGv: json['id_gv'],
    tuAi: json['tu_ai'],
    ngayGui: DateTime.parse(json['ngay_gui']),
    tieuDe: json['tieu_de'],
    noiDung: json['noi_dung'],
    trangThai: json['trang_thai'],
    giangVien: GiangVien.fromJson(json['giang_vien']),
    chiTietThongBao: List<ChiTietThongBao>.from(
      json['chi_tiet_thong_bao'].map((x) => ChiTietThongBao.fromJson(x)),
    ),
    binhLuans: List<BinhLuan>.from(
      json['binh_luans'].map((x) => BinhLuan.fromJson(x)),
    ),
  );
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

  factory GiangVien.fromJson(Map<String, dynamic> json) => GiangVien(
    id: json['id'],
    idHoSo: json['id_ho_so'],
    idBoMon: json['id_bo_mon'],
    taiKhoan: json['tai_khoan'],
    trangThai: json['trang_thai'],
    hoSo: HoSo.fromJson(json['ho_so']),
  );
}

class ChiTietThongBao {
  final int id;
  final int idThongBao;
  final int idSinhVien;
  final int trangThai;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChiTietThongBao({
    required this.id,
    required this.idThongBao,
    required this.idSinhVien,
    required this.trangThai,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChiTietThongBao.fromJson(Map<String, dynamic> json) =>
      ChiTietThongBao(
        id: json['id'],
        idThongBao: json['id_thong_bao'],
        idSinhVien: json['id_sinh_vien'],
        trangThai: json['trang_thai'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );
}

class BinhLuan {
  final int id;
  final String nguoiBinhLuanType;
  final int nguoiBinhLuanId;
  final int idThongBao;
  final String noiDung;
  final int? idBinhLuanCha;
  final int trangThai;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic nguoiBinhLuan;

  BinhLuan({
    required this.id,
    required this.nguoiBinhLuanType,
    required this.nguoiBinhLuanId,
    required this.idThongBao,
    required this.noiDung,
    this.idBinhLuanCha,
    required this.trangThai,
    required this.createdAt,
    required this.updatedAt,
    required this.nguoiBinhLuan,
  });

  factory BinhLuan.fromJson(Map<String, dynamic> json) => BinhLuan(
    id: json['id'],
    nguoiBinhLuanType: json['nguoi_binh_luan_type'],
    nguoiBinhLuanId: json['nguoi_binh_luan_id'],
    idThongBao: json['id_thong_bao'],
    noiDung: json['noi_dung'],
    idBinhLuanCha: json['id_binh_luan_cha'],
    trangThai: json['trang_thai'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
    nguoiBinhLuan: json['nguoi_binh_luan'],
  );
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

  factory HoSo.fromJson(Map<String, dynamic> json) => HoSo(
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

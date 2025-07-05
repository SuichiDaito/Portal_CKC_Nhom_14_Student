class ThongBaoResponse {
  final String status;
  final List<ThongBao> data;

  ThongBaoResponse({required this.status, required this.data});

  factory ThongBaoResponse.fromJson(Map<String, dynamic> json) {
    return ThongBaoResponse(
      status: json['status'],
      data: (json['data'] as List).map((e) => ThongBao.fromJson(e)).toList(),
    );
  }
}

class ThongBao {
  final int id;
  final int idGv;
  final String tuAi;
  final String ngayGui;
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

  factory ThongBao.fromJson(Map<String, dynamic> json) {
    return ThongBao(
      id: json['id'],
      idGv: json['id_gv'],
      tuAi: json['tu_ai'],
      ngayGui: json['ngay_gui'],
      tieuDe: json['tieu_de'],
      noiDung: json['noi_dung'],
      trangThai: json['trang_thai'],
      giangVien: GiangVien.fromJson(json['giang_vien']),
      chiTietThongBao: (json['chi_tiet_thong_bao'] as List)
          .map((e) => ChiTietThongBao.fromJson(e))
          .toList(),
      binhLuans: (json['binh_luans'] as List)
          .map((e) => BinhLuan.fromJson(e))
          .toList(),
    );
  }
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
}

class ChiTietThongBao {
  final int id;
  final int idThongBao;
  final int idSinhVien;
  final int trangThai;

  ChiTietThongBao({
    required this.id,
    required this.idThongBao,
    required this.idSinhVien,
    required this.trangThai,
  });

  factory ChiTietThongBao.fromJson(Map<String, dynamic> json) {
    return ChiTietThongBao(
      id: json['id'],
      idThongBao: json['id_thong_bao'],
      idSinhVien: json['id_sinh_vien'],
      trangThai: json['trang_thai'],
    );
  }
}

class BinhLuan {
  final int id;
  final String nguoiBinhLuanType;
  final int nguoiBinhLuanId;
  final int idThongBao;
  final String noiDung;
  final int? idBinhLuanCha;
  final int trangThai;

  final dynamic nguoiBinhLuan; // Có thể là GiangVien hoặc SinhVien

  BinhLuan({
    required this.id,
    required this.nguoiBinhLuanType,
    required this.nguoiBinhLuanId,
    required this.idThongBao,
    required this.noiDung,
    this.idBinhLuanCha,
    required this.trangThai,

    required this.nguoiBinhLuan,
  });

  factory BinhLuan.fromJson(Map<String, dynamic> json) {
    final type = json['nguoi_binh_luan_type'];
    final dynamic nguoi;

    if (type.contains('User')) {
      nguoi = GiangVien.fromJson(json['nguoi_binh_luan']);
    } else {
      nguoi = SinhVien.fromJson(json['nguoi_binh_luan']);
    }

    return BinhLuan(
      id: json['id'],
      nguoiBinhLuanType: json['nguoi_binh_luan_type'],
      nguoiBinhLuanId: json['nguoi_binh_luan_id'],
      idThongBao: json['id_thong_bao'],
      noiDung: json['noi_dung'],
      idBinhLuanCha: json['id_binh_luan_cha'],
      trangThai: json['trang_thai'],

      nguoiBinhLuan: nguoi,
    );
  }
}

class SinhVien {
  final int id;
  final String maSv;
  final int idLop;
  final int idHoSo;
  final int? idLopChuyenNganh;
  final int chucVu;
  final String password;
  final int trangThai;

  final HoSo hoSo;

  SinhVien({
    required this.id,
    required this.maSv,
    required this.idLop,
    required this.idHoSo,
    this.idLopChuyenNganh,
    required this.chucVu,
    required this.password,
    required this.trangThai,

    required this.hoSo,
  });

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json['id'],
      maSv: json['ma_sv'],
      idLop: json['id_lop'],
      idHoSo: json['id_ho_so'],
      idLopChuyenNganh: json['id_lop_chuyen_nganh'],
      chucVu: json['chuc_vu'],
      password: json['password'],
      trangThai: json['trang_thai'],

      hoSo: HoSo.fromJson(json['ho_so']),
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
}

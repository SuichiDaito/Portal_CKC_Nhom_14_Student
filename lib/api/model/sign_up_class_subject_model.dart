class DangKyHocPhanResponse {
  final bool status;
  final List<LopHocPhan> lopHocPhanDangMo;
  final MonHoc monHoc;
  final bool checkDKHG;
  final List<ThoiKhoaBieu> dsThoiKhoaBieuDauTien;

  DangKyHocPhanResponse({
    required this.status,
    required this.lopHocPhanDangMo,
    required this.monHoc,
    required this.checkDKHG,
    required this.dsThoiKhoaBieuDauTien,
  });

  factory DangKyHocPhanResponse.fromJson(Map<String, dynamic> json) {
    return DangKyHocPhanResponse(
      status: json['status'] ?? false,
      lopHocPhanDangMo:
          (json['lopHocPhanDangMo'] as List?)
              ?.map((e) => LopHocPhan.fromJson(e))
              .toList() ??
          [],
      monHoc: MonHoc.fromJson(json['monHoc'] ?? {}),
      checkDKHG: json['checkDKHG'] ?? false,
      dsThoiKhoaBieuDauTien:
          (json['dsThoiKhoaBieuDauTien'] as List?)
              ?.map((e) => ThoiKhoaBieu.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class LopHocPhan {
  final int id;
  final String tenHocPhan;
  final int idGiangVien;
  final int idChuongTrinhDaoTao;
  final int idLop;
  final int loaiLopHocPhan;
  final int soLuongSinhVien;
  final int gioiHanDangKy;
  final int loaiMon;
  final int trangThai;
  final int trangThaiNopBangDiem;
  final Lop lop;
  final GiangVien giangVien;
  final List<ThoiKhoaBieu> thoiKhoaBieu;

  LopHocPhan({
    required this.id,
    required this.tenHocPhan,
    required this.idGiangVien,
    required this.idChuongTrinhDaoTao,
    required this.idLop,
    required this.loaiLopHocPhan,
    required this.soLuongSinhVien,
    required this.gioiHanDangKy,
    required this.loaiMon,
    required this.trangThai,
    required this.trangThaiNopBangDiem,
    required this.lop,
    required this.giangVien,
    required this.thoiKhoaBieu,
  });

  factory LopHocPhan.fromJson(Map<String, dynamic> json) {
    return LopHocPhan(
      id: json['id'],
      tenHocPhan: json['ten_hoc_phan'],
      idGiangVien: json['id_giang_vien'],
      idChuongTrinhDaoTao: json['id_chuong_trinh_dao_tao'],
      idLop: json['id_lop'],
      loaiLopHocPhan: json['loai_lop_hoc_phan'],
      soLuongSinhVien: json['so_luong_sinh_vien'],
      gioiHanDangKy: json['gioi_han_dang_ky'],
      loaiMon: json['loai_mon'],
      trangThai: json['trang_thai'],
      trangThaiNopBangDiem: json['trang_thai_nop_bang_diem'],
      lop: Lop.fromJson(json['lop'] ?? {}),
      giangVien: GiangVien.fromJson(json['giang_vien'] ?? {}),
      thoiKhoaBieu:
          (json['thoi_khoa_bieu'] as List?)
              ?.map((e) => ThoiKhoaBieu.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Lop {
  final int id;
  final String tenLop;
  final int idNienKhoa;
  final int idGvcn;
  final int idChuyenNganh;
  final int siSo;

  Lop({
    required this.id,
    required this.tenLop,
    required this.idNienKhoa,
    required this.idGvcn,
    required this.idChuyenNganh,
    required this.siSo,
  });

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(
      id: json['id'],
      tenLop: json['ten_lop'] ?? '',
      idNienKhoa: json['id_nien_khoa'] ?? 0,
      idGvcn: json['id_gvcn'] ?? 0,
      idChuyenNganh: json['id_chuyen_nganh'] ?? 0,
      siSo: json['si_so'] ?? 0,
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
      taiKhoan: json['tai_khoan'] ?? '',
      trangThai: json['trang_thai'] ?? 0,
      hoSo: HoSo.fromJson(json['ho_so'] ?? {}),
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

class ThoiKhoaBieu {
  final int id;
  final int idTuan;
  final int idLopHocPhan;
  final int idPhong;
  final int tietBatDau;
  final int tietKetThuc;
  final String ngay;
  final Phong phong;

  ThoiKhoaBieu({
    required this.id,
    required this.idTuan,
    required this.idLopHocPhan,
    required this.idPhong,
    required this.tietBatDau,
    required this.tietKetThuc,
    required this.ngay,
    required this.phong,
  });

  factory ThoiKhoaBieu.fromJson(Map<String, dynamic> json) {
    return ThoiKhoaBieu(
      id: json['id'],
      idTuan: json['id_tuan'],
      idLopHocPhan: json['id_lop_hoc_phan'],
      idPhong: json['id_phong'],
      tietBatDau: json['tiet_bat_dau'],
      tietKetThuc: json['tiet_ket_thuc'],
      ngay: json['ngay'] ?? '',
      phong: Phong.fromJson(json['phong'] ?? {}),
    );
  }
}

class Phong {
  final int id;
  final String ten;
  final int soLuong;
  final int loaiPhong;

  Phong({
    required this.id,
    required this.ten,
    required this.soLuong,
    required this.loaiPhong,
  });

  factory Phong.fromJson(Map<String, dynamic> json) {
    return Phong(
      id: json['id'],
      ten: json['ten'] ?? '',
      soLuong: json['so_luong'] ?? 0,
      loaiPhong: json['loai_phong'] ?? 0,
    );
  }
}

class MonHoc {
  final int id;
  final String tenMon;
  final int loaiMonHoc;

  MonHoc({required this.id, required this.tenMon, required this.loaiMonHoc});

  factory MonHoc.fromJson(Map<String, dynamic> json) {
    return MonHoc(
      id: json['id'],
      tenMon: json['ten_mon'] ?? '',
      loaiMonHoc: json['loai_mon_hoc'] ?? 0,
    );
  }
}

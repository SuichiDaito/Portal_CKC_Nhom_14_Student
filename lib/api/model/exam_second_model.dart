// GENERATED MODEL WITH NULL-SAFE MAPPING

class LichThiResponse {
  final bool status;
  final List<LichThi> data;

  LichThiResponse({required this.status, required this.data});

  factory LichThiResponse.fromJson(Map<String, dynamic> json) {
    return LichThiResponse(
      status: json['status'] ?? false,
      data: json['data'] != null
          ? List<LichThi>.from(json['data'].map((x) => LichThi.fromJson(x)))
          : [],
    );
  }
}

class LichThi {
  final int id;
  final int idLopHocPhan;
  final int idGiamThi1;
  final int idGiamThi2;
  final int idTuan;
  final String ngayThi;
  final String gioBatDau;
  final int thoiGianThi;
  final int idPhongThi;
  final int lanThi;
  final int trangThai;
  final GiamThi giamThi1;
  final GiamThi giamThi2;
  final Phong phong;
  final LopHocPhan lopHocPhan;

  LichThi({
    required this.id,
    required this.idLopHocPhan,
    required this.idGiamThi1,
    required this.idGiamThi2,
    required this.idTuan,
    required this.ngayThi,
    required this.gioBatDau,
    required this.thoiGianThi,
    required this.idPhongThi,
    required this.lanThi,
    required this.trangThai,
    required this.giamThi1,
    required this.giamThi2,
    required this.phong,
    required this.lopHocPhan,
  });

  factory LichThi.fromJson(Map<String, dynamic> json) {
    return LichThi(
      id: json['id'] ?? 0,
      idLopHocPhan: json['id_lop_hoc_phan'] ?? 0,
      idGiamThi1: json['id_giam_thi_1'] ?? 0,
      idGiamThi2: json['id_giam_thi_2'] ?? 0,
      idTuan: json['id_tuan'] ?? 0,
      ngayThi: json['ngay_thi'] ?? '',
      gioBatDau: json['gio_bat_dau'] ?? '',
      thoiGianThi: json['thoi_gian_thi'] ?? 0,
      idPhongThi: json['id_phong_thi'] ?? 0,
      lanThi: json['lan_thi'] ?? 0,
      trangThai: json['trang_thai'] ?? 0,
      giamThi1: json['giam_thi1'] != null
          ? GiamThi.fromJson(json['giam_thi1'])
          : GiamThi.empty(),
      giamThi2: json['giam_thi2'] != null
          ? GiamThi.fromJson(json['giam_thi2'])
          : GiamThi.empty(),
      phong: json['phong'] != null
          ? Phong.fromJson(json['phong'])
          : Phong.empty(),
      lopHocPhan: json['lop_hoc_phan'] != null
          ? LopHocPhan.fromJson(json['lop_hoc_phan'])
          : LopHocPhan.empty(),
    );
  }
}

class GiamThi {
  final int id;
  final int idHoSo;
  final int idBoMon;
  final String taiKhoan;
  final int trangThai;
  final HoSo hoSo;

  GiamThi({
    required this.id,
    required this.idHoSo,
    required this.idBoMon,
    required this.taiKhoan,
    required this.trangThai,
    required this.hoSo,
  });

  factory GiamThi.fromJson(Map<String, dynamic> json) {
    return GiamThi(
      id: json['id'] ?? 0,
      idHoSo: json['id_ho_so'] ?? 0,
      idBoMon: json['id_bo_mon'] ?? 0,
      taiKhoan: json['tai_khoan'] ?? '',
      trangThai: json['trang_thai'] ?? 0,
      hoSo: json['ho_so'] != null ? HoSo.fromJson(json['ho_so']) : HoSo.empty(),
    );
  }

  factory GiamThi.empty() {
    return GiamThi(
      id: 0,
      idHoSo: 0,
      idBoMon: 0,
      taiKhoan: '',
      trangThai: 0,
      hoSo: HoSo.empty(),
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
      id: json['id'] ?? 0,
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

  factory HoSo.empty() {
    return HoSo(
      id: 0,
      hoTen: '',
      email: '',
      password: '',
      soDienThoai: '',
      ngaySinh: '',
      gioiTinh: '',
      cccd: '',
      diaChi: '',
      anh: '',
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
      id: json['id'] ?? 0,
      ten: json['ten'] ?? '',
      soLuong: json['so_luong'] ?? 0,
      loaiPhong: json['loai_phong'] ?? 0,
    );
  }

  factory Phong.empty() {
    return Phong(id: 0, ten: '', soLuong: 0, loaiPhong: 0);
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
  final List<DangKyHocPhan> danhSachHocPhan;

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
    required this.danhSachHocPhan,
  });

  factory LopHocPhan.fromJson(Map<String, dynamic> json) {
    return LopHocPhan(
      id: json['id'] ?? 0,
      tenHocPhan: json['ten_hoc_phan'] ?? '',
      idGiangVien: json['id_giang_vien'] ?? 0,
      idChuongTrinhDaoTao: json['id_chuong_trinh_dao_tao'] ?? 0,
      idLop: json['id_lop'] ?? 0,
      loaiLopHocPhan: json['loai_lop_hoc_phan'] ?? 0,
      soLuongSinhVien: json['so_luong_sinh_vien'] ?? 0,
      gioiHanDangKy: json['gioi_han_dang_ky'] ?? 0,
      loaiMon: json['loai_mon'] ?? 0,
      trangThai: json['trang_thai'] ?? 0,
      trangThaiNopBangDiem: json['trang_thai_nop_bang_diem'] ?? 0,
      danhSachHocPhan: json['danh_sach_hoc_phan'] != null
          ? List<DangKyHocPhan>.from(
              json['danh_sach_hoc_phan'].map((x) => DangKyHocPhan.fromJson(x)),
            )
          : [],
    );
  }

  factory LopHocPhan.empty() {
    return LopHocPhan(
      id: 0,
      tenHocPhan: '',
      idGiangVien: 0,
      idChuongTrinhDaoTao: 0,
      idLop: 0,
      loaiLopHocPhan: 0,
      soLuongSinhVien: 0,
      gioiHanDangKy: 0,
      loaiMon: 0,
      trangThai: 0,
      trangThaiNopBangDiem: 0,
      danhSachHocPhan: [],
    );
  }
}

class DangKyHocPhan {
  final int idSinhVien;
  final int idLopHocPhan;
  final double? diemMdThucHanh;
  final double? diemMdLyThuyet;
  final double? diemChuyenCan;
  final double? diemQuaTrinh;
  final double? diemThiLan1;
  final double? diemThiLan2;
  final double? diemTongKet;
  final int loaiHoc;

  DangKyHocPhan({
    required this.idSinhVien,
    required this.idLopHocPhan,
    this.diemMdThucHanh,
    this.diemMdLyThuyet,
    this.diemChuyenCan,
    this.diemQuaTrinh,
    this.diemThiLan1,
    this.diemThiLan2,
    this.diemTongKet,
    required this.loaiHoc,
  });

  factory DangKyHocPhan.fromJson(Map<String, dynamic> json) {
    return DangKyHocPhan(
      idSinhVien: json['id_sinh_vien'] ?? 0,
      idLopHocPhan: json['id_lop_hoc_phan'] ?? 0,
      diemMdThucHanh: (json['diem_md_thuc_hanh'] as num?)?.toDouble(),
      diemMdLyThuyet: (json['diem_md_ly_thuyet'] as num?)?.toDouble(),
      diemChuyenCan: (json['diem_chuyen_can'] as num?)?.toDouble(),
      diemQuaTrinh: (json['diem_qua_trinh'] as num?)?.toDouble(),
      diemThiLan1: (json['diem_thi_lan_1'] as num?)?.toDouble(),
      diemThiLan2: (json['diem_thi_lan_2'] as num?)?.toDouble(),
      diemTongKet: (json['diem_tong_ket'] as num?)?.toDouble(),
      loaiHoc: json['loai_hoc'] ?? 0,
    );
  }
}

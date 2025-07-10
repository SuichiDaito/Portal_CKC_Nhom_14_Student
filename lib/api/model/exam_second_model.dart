class ThiModel {
  final bool status;
  final List<ThiData> data;

  ThiModel({required this.status, required this.data});

  factory ThiModel.fromJson(Map<String, dynamic> json) {
    return ThiModel(
      status: json['status'],
      data: List<ThiData>.from(json['data'].map((x) => ThiData.fromJson(x))),
    );
  }
}

class ThiData {
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

  ThiData({
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

  factory ThiData.fromJson(Map<String, dynamic> json) {
    return ThiData(
      id: json['id'],
      idLopHocPhan: json['id_lop_hoc_phan'],
      idGiamThi1: json['id_giam_thi_1'],
      idGiamThi2: json['id_giam_thi_2'],
      idTuan: json['id_tuan'],
      ngayThi: json['ngay_thi'],
      gioBatDau: json['gio_bat_dau'],
      thoiGianThi: json['thoi_gian_thi'],
      idPhongThi: json['id_phong_thi'],
      lanThi: json['lan_thi'],
      trangThai: json['trang_thai'],
      giamThi1: GiamThi.fromJson(json['giam_thi1']),
      giamThi2: GiamThi.fromJson(json['giam_thi2']),
      phong: Phong.fromJson(json['phong']),
      lopHocPhan: LopHocPhan.fromJson(json['lop_hoc_phan']),
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
      id: json['id'],
      idHoSo: json['id_ho_so'],
      idBoMon: json['id_bo_mon'],
      taiKhoan: json['tai_khoan'],
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
      ten: json['ten'],
      soLuong: json['so_luong'],
      loaiPhong: json['loai_phong'],
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
  final DangKyHocGhepThiLai? dangKyHocGhepThiLai;
  final List<DanhSachHocPhan> danhSachHocPhan;

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
    this.dangKyHocGhepThiLai,
    required this.danhSachHocPhan,
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
      dangKyHocGhepThiLai: json['dang_ky_hoc_ghep_thi_lai'] != null
          ? DangKyHocGhepThiLai.fromJson(json['dang_ky_hoc_ghep_thi_lai'])
          : null,
      danhSachHocPhan: List<DanhSachHocPhan>.from(
        json['danh_sach_hoc_phan'].map((x) => DanhSachHocPhan.fromJson(x)),
      ),
    );
  }
}

class DangKyHocGhepThiLai {
  final int idSinhVien;
  final int idLopHocPhan;
  final int soTien;
  final int loaiDong;
  final int trangThai;

  DangKyHocGhepThiLai({
    required this.idSinhVien,
    required this.idLopHocPhan,
    required this.soTien,
    required this.loaiDong,
    required this.trangThai,
  });

  factory DangKyHocGhepThiLai.fromJson(Map<String, dynamic> json) {
    return DangKyHocGhepThiLai(
      idSinhVien: json['id_sinh_vien'],
      idLopHocPhan: json['id_lop_hoc_phan'],
      soTien: json['so_tien'],
      loaiDong: json['loai_dong'],
      trangThai: json['trang_thai'],
    );
  }
}

class DanhSachHocPhan {
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

  DanhSachHocPhan({
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

  factory DanhSachHocPhan.fromJson(Map<String, dynamic> json) {
    return DanhSachHocPhan(
      idSinhVien: json['id_sinh_vien'],
      idLopHocPhan: json['id_lop_hoc_phan'],
      diemMdThucHanh: (json['diem_md_thuc_hanh'] != null)
          ? (json['diem_md_thuc_hanh'] as num).toDouble()
          : null,
      diemMdLyThuyet: (json['diem_md_ly_thuyet'] != null)
          ? (json['diem_md_ly_thuyet'] as num).toDouble()
          : null,
      diemChuyenCan: (json['diem_chuyen_can'] != null)
          ? (json['diem_chuyen_can'] as num).toDouble()
          : null,
      diemQuaTrinh: (json['diem_qua_trinh'] != null)
          ? (json['diem_qua_trinh'] as num).toDouble()
          : null,
      diemThiLan1: (json['diem_thi_lan_1'] != null)
          ? (json['diem_thi_lan_1'] as num).toDouble()
          : null,
      diemThiLan2: (json['diem_thi_lan_2'] != null)
          ? (json['diem_thi_lan_2'] as num).toDouble()
          : null,
      diemTongKet: (json['diem_tong_ket'] != null)
          ? (json['diem_tong_ket'] as num).toDouble()
          : null,
      loaiHoc: json['loai_hoc'],
    );
  }
}

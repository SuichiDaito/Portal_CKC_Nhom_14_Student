class ExamScheduleResponse {
  final bool status;
  final List<ExamSchedule> data;

  ExamScheduleResponse({required this.status, required this.data});

  factory ExamScheduleResponse.fromJson(Map<String, dynamic> json) {
    return ExamScheduleResponse(
      status: json['status'] ?? false,
      data:
          (json['data'] as List?)
              ?.map((e) => ExamSchedule.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ExamSchedule {
  final int id;
  final int idLopHocPhan;
  final int idGiamThi1;
  final int idGiamThi2;
  final int idTuan;
  final String? ngayThi;
  final String? gioBatDau;
  final String? thoiGianThi;
  final int idPhongThi;
  final String? lanThi;
  final String? trangThai;
  final String? createdAt;
  final String? updatedAt;
  final GiamThi? giamThi1;
  final GiamThi? giamThi2;
  final Phong? phong;
  final LopHocPhan? lopHocPhan;

  ExamSchedule({
    required this.id,
    required this.idLopHocPhan,
    required this.idGiamThi1,
    required this.idGiamThi2,
    required this.idTuan,
    this.ngayThi,
    this.gioBatDau,
    this.thoiGianThi,
    required this.idPhongThi,
    this.lanThi,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.giamThi1,
    this.giamThi2,
    this.phong,
    this.lopHocPhan,
  });

  factory ExamSchedule.fromJson(Map<String, dynamic> json) {
    return ExamSchedule(
      id: json['id'] ?? 0,
      idLopHocPhan: json['id_lop_hoc_phan'] ?? 0,
      idGiamThi1: json['id_giam_thi_1'] ?? 0,
      idGiamThi2: json['id_giam_thi_2'] ?? 0,
      idTuan: json['id_tuan'] ?? 0,
      ngayThi: json['ngay_thi'],
      gioBatDau: json['gio_bat_dau'],
      thoiGianThi: json['thoi_gian_thi'],
      idPhongThi: json['id_phong_thi'] ?? 0,
      lanThi: json['lan_thi'],
      trangThai: json['trang_thai'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      giamThi1: json['giam_thi1'] != null
          ? GiamThi.fromJson(json['giam_thi1'])
          : null,
      giamThi2: json['giam_thi2'] != null
          ? GiamThi.fromJson(json['giam_thi2'])
          : null,
      phong: json['phong'] != null ? Phong.fromJson(json['phong']) : null,
      lopHocPhan: json['lop_hoc_phan'] != null
          ? LopHocPhan.fromJson(json['lop_hoc_phan'])
          : null,
    );
  }
}

class GiamThi {
  final int id;
  final int idHoSo;
  final int idBoMon;
  final String? taiKhoan;
  final String? trangThai;
  final String? createdAt;
  final String? updatedAt;
  final HoSo? hoSo;

  GiamThi({
    required this.id,
    required this.idHoSo,
    required this.idBoMon,
    this.taiKhoan,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.hoSo,
  });

  factory GiamThi.fromJson(Map<String, dynamic> json) {
    return GiamThi(
      id: json['id'] ?? 0,
      idHoSo: json['id_ho_so'] ?? 0,
      idBoMon: json['id_bo_mon'] ?? 0,
      taiKhoan: json['tai_khoan'],
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

class Phong {
  final int id;
  final String? ten;
  final String? soLuong;
  final int? loaiPhong;
  final String? createdAt;
  final String? updatedAt;

  Phong({
    required this.id,
    this.ten,
    this.soLuong,
    this.loaiPhong,
    this.createdAt,
    this.updatedAt,
  });

  factory Phong.fromJson(Map<String, dynamic> json) {
    return Phong(
      id: json['id'] ?? 0,
      ten: json['ten'],
      soLuong: json['so_luong'],
      loaiPhong: json['loai_phong'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class LopHocPhan {
  final int id;
  final String? tenHocPhan;
  final int? idGiangVien;
  final int? idChuongTrinhDaoTao;
  final int? idLop;
  final String? loaiLopHocPhan;
  final String? soLuongSinhVien;
  final String? gioiHanDangKy;
  final int? loaiMon;
  final String? trangThai;
  final int? trangThaiNopBangDiem;
  final String? createdAt;
  final String? updatedAt;

  LopHocPhan({
    required this.id,
    this.tenHocPhan,
    this.idGiangVien,
    this.idChuongTrinhDaoTao,
    this.idLop,
    this.loaiLopHocPhan,
    this.soLuongSinhVien,
    this.gioiHanDangKy,
    this.loaiMon,
    this.trangThai,
    this.trangThaiNopBangDiem,
    this.createdAt,
    this.updatedAt,
  });

  factory LopHocPhan.fromJson(Map<String, dynamic> json) {
    return LopHocPhan(
      id: json['id'] ?? 0,
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

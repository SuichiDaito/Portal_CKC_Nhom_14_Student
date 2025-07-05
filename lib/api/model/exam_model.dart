class ExamScheduleResponse {
  final bool status;
  final List<ExamSchedule> data;

  ExamScheduleResponse({required this.status, required this.data});

  factory ExamScheduleResponse.fromJson(Map<String, dynamic> json) {
    return ExamScheduleResponse(
      status: json['status'],
      data: (json['data'] as List)
          .map((e) => ExamSchedule.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class ExamSchedule {
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

  ExamSchedule({
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

  factory ExamSchedule.fromJson(Map<String, dynamic> json) => ExamSchedule(
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_lop_hoc_phan': idLopHocPhan,
    'id_giam_thi_1': idGiamThi1,
    'id_giam_thi_2': idGiamThi2,
    'id_tuan': idTuan,
    'ngay_thi': ngayThi,
    'gio_bat_dau': gioBatDau,
    'thoi_gian_thi': thoiGianThi,
    'id_phong_thi': idPhongThi,
    'lan_thi': lanThi,
    'trang_thai': trangThai,
    'giam_thi1': giamThi1.toJson(),
    'giam_thi2': giamThi2.toJson(),
    'phong': phong.toJson(),
    'lop_hoc_phan': lopHocPhan.toJson(),
  };
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

  factory GiamThi.fromJson(Map<String, dynamic> json) => GiamThi(
    id: json['id'],
    idHoSo: json['id_ho_so'],
    idBoMon: json['id_bo_mon'],
    taiKhoan: json['tai_khoan'],
    trangThai: json['trang_thai'],

    hoSo: HoSo.fromJson(json['ho_so']),
  );

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

  factory Phong.fromJson(Map<String, dynamic> json) => Phong(
    id: json['id'],
    ten: json['ten'],
    soLuong: json['so_luong'],
    loaiPhong: json['loai_phong'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'ten': ten,
    'so_luong': soLuong,
    'loai_phong': loaiPhong,
  };
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
  });

  factory LopHocPhan.fromJson(Map<String, dynamic> json) => LopHocPhan(
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
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'ten_hoc_phan': tenHocPhan,
    'id_giang_vien': idGiangVien,
    'id_chuong_trinh_dao_tao': idChuongTrinhDaoTao,
    'id_lop': idLop,
    'loai_lop_hoc_phan': loaiLopHocPhan,
    'so_luong_sinh_vien': soLuongSinhVien,
    'gioi_han_dang_ky': gioiHanDangKy,
    'loai_mon': loaiMon,
    'trang_thai': trangThai,
    'trang_thai_nop_bang_diem': trangThaiNopBangDiem,
  };
}

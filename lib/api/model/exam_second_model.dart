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

// exam_duty_model.dart

class ThiData {
  final int? id;
  final int? idLopHocPhan;
  final int? idGiamThi1;
  final int? idGiamThi2;
  final int? idTuan;
  final String? ngayThi;
  final String? gioBatDau;
  final String? thoiGianThi;
  final String? lanThi;
  final String? trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final GiamThi? giamThi1;
  final GiamThi? giamThi2;
  final Phong? phong;
  final LopHocPhan? lopHocPhan;

  ThiData({
    this.id,
    this.idLopHocPhan,
    this.idGiamThi1,
    this.idGiamThi2,
    this.idTuan,
    this.ngayThi,
    this.gioBatDau,
    this.thoiGianThi,
    this.lanThi,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.giamThi1,
    this.giamThi2,
    this.phong,
    this.lopHocPhan,
  });

  factory ThiData.fromJson(Map<String, dynamic> json) => ThiData(
    id: json['id'],
    idLopHocPhan: json['id_lop_hoc_phan'],
    idGiamThi1: json['id_giam_thi_1'],
    idGiamThi2: json['id_giam_thi_2'],
    idTuan: json['id_tuan'],
    ngayThi: json['ngay_thi'],
    gioBatDau: json['gio_bat_dau'],
    thoiGianThi: json['thoi_gian_thi'],
    lanThi: json['lan_thi'],
    trangThai: json['trang_thai'],
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null,
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

class GiamThi {
  final int? id;
  final int? idHoSo;
  final int? idBoMon;
  final String? taiKhoan;
  final String? trangThai;
  final HoSo? hoSo;

  GiamThi({
    this.id,
    this.idHoSo,
    this.idBoMon,
    this.taiKhoan,
    this.trangThai,
    this.hoSo,
  });

  factory GiamThi.fromJson(Map<String, dynamic> json) => GiamThi(
    id: json['id'],
    idHoSo: json['id_ho_so'],
    idBoMon: json['id_bo_mon'],
    taiKhoan: json['tai_khoan'],
    trangThai: json['trang_thai'],
    hoSo: json['ho_so'] != null ? HoSo.fromJson(json['ho_so']) : null,
  );
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

class Phong {
  final int? id;
  final String? ten;
  final String? soLuong;
  final int? loaiPhong;

  Phong({this.id, this.ten, this.soLuong, this.loaiPhong});

  factory Phong.fromJson(Map<String, dynamic> json) => Phong(
    id: json['id'],
    ten: json['ten'],
    soLuong: json['so_luong'],
    loaiPhong: json['loai_phong'],
  );
}

class LopHocPhan {
  final int? id;
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
  final DangKyHocGhepThiLai? dangKyHocGhepThiLai;
  final List<DanhSachHocPhan>? danhSachHocPhan;

  LopHocPhan({
    this.id,
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
    this.dangKyHocGhepThiLai,
    this.danhSachHocPhan,
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
    dangKyHocGhepThiLai: json['dang_ky_hoc_ghep_thi_lai'] != null
        ? DangKyHocGhepThiLai.fromJson(json['dang_ky_hoc_ghep_thi_lai'])
        : null,
    danhSachHocPhan: json['danh_sach_hoc_phan'] != null
        ? List<DanhSachHocPhan>.from(
            json['danh_sach_hoc_phan'].map((x) => DanhSachHocPhan.fromJson(x)),
          )
        : null,
  );
}

class DangKyHocGhepThiLai {
  final int? idSinhVien;
  final int? idLopHocPhan;
  final String? soTien;
  final int? loaiDong;
  final int? trangThai;

  DangKyHocGhepThiLai({
    this.idSinhVien,
    this.idLopHocPhan,
    this.soTien,
    this.loaiDong,
    this.trangThai,
  });

  factory DangKyHocGhepThiLai.fromJson(Map<String, dynamic> json) =>
      DangKyHocGhepThiLai(
        idSinhVien: json['id_sinh_vien'],
        idLopHocPhan: json['id_lop_hoc_phan'],
        soTien: json['so_tien'],
        loaiDong: json['loai_dong'],
        trangThai: json['trang_thai'],
      );
}

class DanhSachHocPhan {
  final int? idSinhVien;
  final int? idLopHocPhan;
  final String? diemMdThucHanh;
  final String? diemMdLyThuyet;
  final String? diemChuyenCan;
  final String? diemQuaTrinh;
  final String? diemThiLan1;
  final String? diemThiLan2;
  final String? diemTongKet;
  final String? loaiHoc;

  DanhSachHocPhan({
    this.idSinhVien,
    this.idLopHocPhan,
    this.diemMdThucHanh,
    this.diemMdLyThuyet,
    this.diemChuyenCan,
    this.diemQuaTrinh,
    this.diemThiLan1,
    this.diemThiLan2,
    this.diemTongKet,
    this.loaiHoc,
  });

  factory DanhSachHocPhan.fromJson(Map<String, dynamic> json) =>
      DanhSachHocPhan(
        idSinhVien: json['id_sinh_vien'],
        idLopHocPhan: json['id_lop_hoc_phan'],
        diemMdThucHanh: json['diem_md_thuc_hanh'],
        diemMdLyThuyet: json['diem_md_ly_thuyet'],
        diemChuyenCan: json['diem_chuyen_can'],
        diemQuaTrinh: json['diem_qua_trinh'],
        diemThiLan1: json['diem_thi_lan_1'],
        diemThiLan2: json['diem_thi_lan_2'],
        diemTongKet: json['diem_tong_ket'],
        loaiHoc: json['loai_hoc'],
      );
}

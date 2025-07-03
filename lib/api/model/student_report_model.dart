class ReportResponse {
  final String status;
  final List<BienBanSHCN> bienBanSHCN;

  ReportResponse({required this.status, required this.bienBanSHCN});

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      status: json['status'],
      bienBanSHCN: (json['bienBanSHCN'] as List)
          .map((e) => BienBanSHCN.fromJson(e))
          .toList(),
    );
  }
}

class BienBanSHCN {
  final int id;
  final int idLop;
  final int idSv;
  final int idGvcn;
  final int idTuan;
  final String tieuDe;
  final String noiDung;
  final DateTime thoiGianBatDau;
  final DateTime thoiGianKetThuc;
  final int soLuongSinhVien;
  final int vangMat;
  final int trangThai;
  final Lop lop;
  final ThuKy thuky;
  final Tuan tuan;
  final Gvcn gvcn;

  BienBanSHCN({
    required this.id,
    required this.idLop,
    required this.idSv,
    required this.idGvcn,
    required this.idTuan,
    required this.tieuDe,
    required this.noiDung,
    required this.thoiGianBatDau,
    required this.thoiGianKetThuc,
    required this.soLuongSinhVien,
    required this.vangMat,
    required this.trangThai,

    required this.lop,
    required this.thuky,
    required this.tuan,
    required this.gvcn,
  });

  factory BienBanSHCN.fromJson(Map<String, dynamic> json) {
    return BienBanSHCN(
      id: json['id'],
      idLop: json['id_lop'],
      idSv: json['id_sv'],
      idGvcn: json['id_gvcn'],
      idTuan: json['id_tuan'],
      tieuDe: json['tieu_de'],
      noiDung: json['noi_dung'],
      thoiGianBatDau: DateTime.parse(json['thoi_gian_bat_dau']),
      thoiGianKetThuc: DateTime.parse(json['thoi_gian_ket_thuc']),
      soLuongSinhVien: json['so_luong_sinh_vien'],
      vangMat: json['vang_mat'],
      trangThai: json['trang_thai'],
      lop: Lop.fromJson(json['lop']),
      thuky: ThuKy.fromJson(json['thuky']),
      tuan: Tuan.fromJson(json['tuan']),
      gvcn: Gvcn.fromJson(json['gvcn']),
    );
  }
}

class Lop {
  final int id;
  final String tenLop;
  final int idNienKhoa;
  final int idGvcn;
  final int idNganhHoc;
  final int siSo;

  Lop({
    required this.id,
    required this.tenLop,
    required this.idNienKhoa,
    required this.idGvcn,
    required this.idNganhHoc,
    required this.siSo,
  });

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(
      id: json['id'],
      tenLop: json['ten_lop'],
      idNienKhoa: json['id_nien_khoa'],
      idGvcn: json['id_gvcn'],
      idNganhHoc: json['id_nganh_hoc'],
      siSo: json['si_so'],
    );
  }
}

class ThuKy {
  final int id;
  final String maSv;
  final int idLop;
  final int idHoSo;
  final int? idLopChuyenNganh;
  final int chucVu;
  final String password;
  final int trangThai;
  final HoSo hoSo;

  ThuKy({
    required this.id,
    required this.maSv,
    required this.idLop,
    required this.idHoSo,
    required this.idLopChuyenNganh,
    required this.chucVu,
    required this.password,
    required this.trangThai,
    required this.hoSo,
  });

  factory ThuKy.fromJson(Map<String, dynamic> json) {
    return ThuKy(
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

class Tuan {
  final int id;
  final int idNam;
  final int tuan;
  final String ngayBatDau;
  final String ngayKetThuc;

  Tuan({
    required this.id,
    required this.idNam,
    required this.tuan,
    required this.ngayBatDau,
    required this.ngayKetThuc,
  });

  factory Tuan.fromJson(Map<String, dynamic> json) {
    return Tuan(
      id: json['id'],
      idNam: json['id_nam'],
      tuan: json['tuan'],
      ngayBatDau: json['ngay_bat_dau'],
      ngayKetThuc: json['ngay_ket_thuc'],
    );
  }
}

class Gvcn {
  final int id;
  final int idHoSo;
  final int idBoMon;
  final String taiKhoan;
  final int trangThai;

  Gvcn({
    required this.id,
    required this.idHoSo,
    required this.idBoMon,
    required this.taiKhoan,
    required this.trangThai,
  });

  factory Gvcn.fromJson(Map<String, dynamic> json) {
    return Gvcn(
      id: json['id'],
      idHoSo: json['id_ho_so'],
      idBoMon: json['id_bo_mon'],
      taiKhoan: json['tai_khoan'],
      trangThai: json['trang_thai'],
    );
  }
}

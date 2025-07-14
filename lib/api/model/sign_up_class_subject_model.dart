class DangKyHocPhanResponse {
  final bool? status;
  final List<LopHocPhanDangMo>? lopHocPhanDangMo;
  final MonHoc? monHoc;
  final bool? checkDKHG;
  final List<ThoiKhoaBieu>? dsThoiKhoaBieuDauTien;

  DangKyHocPhanResponse({
    this.status,
    this.lopHocPhanDangMo,
    this.monHoc,
    this.checkDKHG,
    this.dsThoiKhoaBieuDauTien,
  });

  factory DangKyHocPhanResponse.fromJson(Map<String, dynamic> json) {
    return DangKyHocPhanResponse(
      status: json['status'] as bool?,
      lopHocPhanDangMo: (json['lopHocPhanDangMo'] as List?)
          ?.map((e) => LopHocPhanDangMo.fromJson(e))
          .toList(),
      monHoc: json['monHoc'] != null ? MonHoc.fromJson(json['monHoc']) : null,
      checkDKHG: json['checkDKHG'] as bool?,
      dsThoiKhoaBieuDauTien: (json['dsThoiKhoaBieuDauTien'] as List?)
          ?.map((e) => ThoiKhoaBieu.fromJson(e))
          .toList(),
    );
  }
}

class LopHocPhanDangMo {
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Lop? lop;
  final GiangVien? giangVien;
  final List<ThoiKhoaBieu>? thoiKhoaBieu;

  LopHocPhanDangMo({
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
    this.createdAt,
    this.updatedAt,
    this.lop,
    this.giangVien,
    this.thoiKhoaBieu,
  });

  factory LopHocPhanDangMo.fromJson(Map<String, dynamic> json) {
    return LopHocPhanDangMo(
      id: json['id'] as int?,
      tenHocPhan: json['ten_hoc_phan'] as String?,
      idGiangVien: json['id_giang_vien'] as int?,
      idChuongTrinhDaoTao: json['id_chuong_trinh_dao_tao'] as int?,
      idLop: json['id_lop'] as int?,
      loaiLopHocPhan: json['loai_lop_hoc_phan'] as String?,
      soLuongSinhVien: json['so_luong_sinh_vien'] as String?,
      gioiHanDangKy: json['gioi_han_dang_ky'] as String?,
      loaiMon: json['loai_mon'] as int?,
      trangThai: json['trang_thai'] as String?,
      trangThaiNopBangDiem: json['trang_thai_nop_bang_diem'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      lop: json['lop'] != null ? Lop.fromJson(json['lop']) : null,
      giangVien: json['giang_vien'] != null
          ? GiangVien.fromJson(json['giang_vien'])
          : null,
      thoiKhoaBieu: (json['thoi_khoa_bieu'] as List?)
          ?.map((e) => ThoiKhoaBieu.fromJson(e))
          .toList(),
    );
  }
}

class Lop {
  final int? id;
  final String? tenLop;
  final int? idNienKhoa;
  final int? idGvcn;
  final int? idChuyenNganh;
  final String? siSo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Lop({
    this.id,
    this.tenLop,
    this.idNienKhoa,
    this.idGvcn,
    this.idChuyenNganh,
    this.siSo,
    this.createdAt,
    this.updatedAt,
  });

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(
      id: json['id'] as int?,
      tenLop: json['ten_lop'] as String?,
      idNienKhoa: json['id_nien_khoa'] as int?,
      idGvcn: json['id_gvcn'] as int?,
      idChuyenNganh: json['id_chuyen_nganh'] as int?,
      siSo: json['si_so'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}

class GiangVien {
  final int? id;
  final int? idHoSo;
  final int? idBoMon;
  final String? taiKhoan;
  final String? trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final HoSo? hoSo;

  GiangVien({
    this.id,
    this.idHoSo,
    this.idBoMon,
    this.taiKhoan,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.hoSo,
  });

  factory GiangVien.fromJson(Map<String, dynamic> json) {
    return GiangVien(
      id: json['id'] as int?,
      idHoSo: json['id_ho_so'] as int?,
      idBoMon: json['id_bo_mon'] as int?,
      taiKhoan: json['tai_khoan'] as String?,
      trangThai: json['trang_thai'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      hoSo: json['ho_so'] != null ? HoSo.fromJson(json['ho_so']) : null,
    );
  }
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
    this.createdAt,
    this.updatedAt,
  });

  factory HoSo.fromJson(Map<String, dynamic> json) {
    return HoSo(
      id: json['id'] as int?,
      hoTen: json['ho_ten'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      soDienThoai: json['so_dien_thoai'] as String?,
      ngaySinh: json['ngay_sinh'] as String?,
      gioiTinh: json['gioi_tinh'] as String?,
      cccd: json['cccd'] as String?,
      diaChi: json['dia_chi'] as String?,
      anh: json['anh'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}

class ThoiKhoaBieu {
  final int? id;
  final int? idTuan;
  final int? idLopHocPhan;
  final int? idPhong;
  final String? tietBatDau;
  final String? tietKetThuc;
  final String? ngay;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Phong? phong;

  ThoiKhoaBieu({
    this.id,
    this.idTuan,
    this.idLopHocPhan,
    this.idPhong,
    this.tietBatDau,
    this.tietKetThuc,
    this.ngay,
    this.createdAt,
    this.updatedAt,
    this.phong,
  });

  factory ThoiKhoaBieu.fromJson(Map<String, dynamic> json) {
    return ThoiKhoaBieu(
      id: json['id'] as int?,
      idTuan: json['id_tuan'] as int?,
      idLopHocPhan: json['id_lop_hoc_phan'] as int?,
      idPhong: json['id_phong'] as int?,
      tietBatDau: json['tiet_bat_dau'] as String?,
      tietKetThuc: json['tiet_ket_thuc'] as String?,
      ngay: json['ngay'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      phong: json['phong'] != null ? Phong.fromJson(json['phong']) : null,
    );
  }
}

class Phong {
  final int? id;
  final String? ten;
  final String? soLuong;
  final int? loaiPhong;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Phong({
    this.id,
    this.ten,
    this.soLuong,
    this.loaiPhong,
    this.createdAt,
    this.updatedAt,
  });

  factory Phong.fromJson(Map<String, dynamic> json) {
    return Phong(
      id: json['id'] as int?,
      ten: json['ten'] as String?,
      soLuong: json['so_luong'] as String?,
      loaiPhong: json['loai_phong'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}

class MonHoc {
  final int? id;
  final String? tenMon;
  final String? loaiMonHoc;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MonHoc({
    this.id,
    this.tenMon,
    this.loaiMonHoc,
    this.createdAt,
    this.updatedAt,
  });

  factory MonHoc.fromJson(Map<String, dynamic> json) {
    return MonHoc(
      id: json['id'] as int?,
      tenMon: json['ten_mon'] as String?,
      loaiMonHoc: json['loai_mon_hoc'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}

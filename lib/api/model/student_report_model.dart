class BienBanResponse {
  final String? status;
  final BienBanSHCN? bienBanSHCN;

  BienBanResponse({this.status, this.bienBanSHCN});

  factory BienBanResponse.fromJson(Map<String, dynamic> json) {
    return BienBanResponse(
      status: json['status'] as String?,
      bienBanSHCN: json['bienBanSHCN'] != null
          ? BienBanSHCN.fromJson(json['bienBanSHCN'])
          : null,
    );
  }
}

class BienBanSHCN {
  final int? currentPage;
  final List<BienBanItem>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<LinkItem>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  BienBanSHCN({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory BienBanSHCN.fromJson(Map<String, dynamic> json) {
    return BienBanSHCN(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BienBanItem.fromJson(e))
          .toList(),
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => LinkItem.fromJson(e))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      prevPageUrl: json['prev_page_url'] as String?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );
  }
}

class BienBanItem {
  final int? id;
  final int? idLop;
  final int? idSv;
  final int? idGvcn;
  final int? idTuan;
  final String? tieuDe;
  final String? noiDung;
  final String? thoiGianBatDau;
  final String? thoiGianKetThuc;
  final String? soLuongSinhVien;
  final String? vangMat;
  final int? trangThai;
  final String? createdAt;
  final String? updatedAt;
  final Lop? lop;
  final ThuKy? thuky;
  final Tuan? tuan;
  final Gvcn? gvcn;
  final List<ChiTietBienBanSHCN>? chiTietBienBanSHCN;

  BienBanItem({
    this.id,
    this.idLop,
    this.idSv,
    this.idGvcn,
    this.idTuan,
    this.tieuDe,
    this.noiDung,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.soLuongSinhVien,
    this.vangMat,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.lop,
    this.thuky,
    this.tuan,
    this.gvcn,
    this.chiTietBienBanSHCN,
  });

  factory BienBanItem.fromJson(Map<String, dynamic> json) {
    return BienBanItem(
      id: json['id'] as int?,
      idLop: json['id_lop'] as int?,
      idSv: json['id_sv'] as int?,
      idGvcn: json['id_gvcn'] as int?,
      idTuan: json['id_tuan'] as int?,
      tieuDe: json['tieu_de'] as String?,
      noiDung: json['noi_dung'] as String?,
      thoiGianBatDau: json['thoi_gian_bat_dau'] as String?,
      thoiGianKetThuc: json['thoi_gian_ket_thuc'] as String?,
      soLuongSinhVien: json['so_luong_sinh_vien'] as String?,
      vangMat: json['vang_mat'] as String?,
      trangThai: json['trang_thai'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      lop: json['lop'] != null ? Lop.fromJson(json['lop']) : null,
      thuky: json['thuky'] != null ? ThuKy.fromJson(json['thuky']) : null,
      tuan: json['tuan'] != null ? Tuan.fromJson(json['tuan']) : null,
      gvcn: json['gvcn'] != null ? Gvcn.fromJson(json['gvcn']) : null,
      chiTietBienBanSHCN: (json['chi_tiet_bien_ban_s_h_c_n'] as List<dynamic>?)
          ?.map((e) => ChiTietBienBanSHCN.fromJson(e))
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
  final String? createdAt;
  final String? updatedAt;

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
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class ThuKy {
  final int? id;
  final String? maSv;
  final int? idHoSo;
  final String? password;
  final int? trangThai;
  final String? createdAt;
  final String? updatedAt;
  final HoSo? hoSo;

  ThuKy({
    this.id,
    this.maSv,
    this.idHoSo,
    this.password,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.hoSo,
  });

  factory ThuKy.fromJson(Map<String, dynamic> json) {
    return ThuKy(
      id: json['id'] as int?,
      maSv: json['ma_sv'] as String?,
      idHoSo: json['id_ho_so'] as int?,
      password: json['password'] as String?,
      trangThai: json['trang_thai'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
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
  final String? createdAt;
  final String? updatedAt;

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
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class Tuan {
  final int? id;
  final int? idNam;
  final String? tuan;
  final String? ngayBatDau;
  final String? ngayKetThuc;
  final String? createdAt;
  final String? updatedAt;

  Tuan({
    this.id,
    this.idNam,
    this.tuan,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.createdAt,
    this.updatedAt,
  });

  factory Tuan.fromJson(Map<String, dynamic> json) {
    return Tuan(
      id: json['id'] as int?,
      idNam: json['id_nam'] as int?,
      tuan: json['tuan'] as String?,
      ngayBatDau: json['ngay_bat_dau'] as String?,
      ngayKetThuc: json['ngay_ket_thuc'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class Gvcn {
  final int? id;
  final int? idHoSo;
  final int? idBoMon;
  final String? taiKhoan;
  final String? trangThai;
  final String? createdAt;
  final String? updatedAt;
  final HoSo? hoSo;

  Gvcn({
    this.id,
    this.idHoSo,
    this.idBoMon,
    this.taiKhoan,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.hoSo,
  });

  factory Gvcn.fromJson(Map<String, dynamic> json) {
    return Gvcn(
      id: json['id'] as int?,
      idHoSo: json['id_ho_so'] as int?,
      idBoMon: json['id_bo_mon'] as int?,
      taiKhoan: json['tai_khoan'] as String?,
      trangThai: json['trang_thai'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      hoSo: json['ho_so'] != null ? HoSo.fromJson(json['ho_so']) : null,
    );
  }
}

class ChiTietBienBanSHCN {
  final int? id;
  final int? idBienBanShcn;
  final int? idSinhVien;
  final String? lyDo;
  final int? loai;
  final String? createdAt;
  final String? updatedAt;
  final SinhVien? sinhVien;

  ChiTietBienBanSHCN({
    this.id,
    this.idBienBanShcn,
    this.idSinhVien,
    this.lyDo,
    this.loai,
    this.createdAt,
    this.updatedAt,
    this.sinhVien,
  });

  factory ChiTietBienBanSHCN.fromJson(Map<String, dynamic> json) {
    return ChiTietBienBanSHCN(
      id: json['id'] as int?,
      idBienBanShcn: json['id_bien_ban_shcn'] as int?,
      idSinhVien: json['id_sinh_vien'] as int?,
      lyDo: json['ly_do'] as String?,
      loai: json['loai'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      sinhVien: json['sinh_vien'] != null
          ? SinhVien.fromJson(json['sinh_vien'])
          : null,
    );
  }
}

class SinhVien {
  final int? id;
  final String? maSv;
  final int? idHoSo;
  final String? password;
  final int? trangThai;
  final String? createdAt;
  final String? updatedAt;
  final HoSo? hoSo;

  SinhVien({
    this.id,
    this.maSv,
    this.idHoSo,
    this.password,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
    this.hoSo,
  });

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json['id'] as int?,
      maSv: json['ma_sv'] as String?,
      idHoSo: json['id_ho_so'] as int?,
      password: json['password'] as String?,
      trangThai: json['trang_thai'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      hoSo: json['ho_so'] != null ? HoSo.fromJson(json['ho_so']) : null,
    );
  }
}

class LinkItem {
  final String? url;
  final String? label;
  final bool? active;

  LinkItem({this.url, this.label, this.active});

  factory LinkItem.fromJson(Map<String, dynamic> json) {
    return LinkItem(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );
  }
}

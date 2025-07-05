class BienBanShcnResponse {
  final String status;
  final BienBanShcnPagination bienBanSHCN;

  BienBanShcnResponse({required this.status, required this.bienBanSHCN});

  factory BienBanShcnResponse.fromJson(Map<String, dynamic> json) {
    return BienBanShcnResponse(
      status: json['status'],
      bienBanSHCN: BienBanShcnPagination.fromJson(json['bienBanSHCN']),
    );
  }
}

class BienBanShcnPagination {
  final int currentPage;
  final List<BienBanShcn> data;
  final int from;
  final int lastPage;
  final String firstPageUrl;
  final String lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  BienBanShcnPagination({
    required this.currentPage,
    required this.data,
    required this.from,
    required this.lastPage,
    required this.firstPageUrl,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory BienBanShcnPagination.fromJson(Map<String, dynamic> json) {
    return BienBanShcnPagination(
      currentPage: json['current_page'],
      data: (json['data'] as List).map((e) => BienBanShcn.fromJson(e)).toList(),
      from: json['from'],
      lastPage: json['last_page'],
      firstPageUrl: json['first_page_url'],
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List).map((e) => Link.fromJson(e)).toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class BienBanShcn {
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
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Lop lop;
  final SinhVien thuky;
  final GiaoVien gvcn;
  final Tuan tuan;
  final List<dynamic> chiTietBienBanShcn;

  BienBanShcn({
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
    required this.createdAt,
    this.updatedAt,
    required this.lop,
    required this.thuky,
    required this.gvcn,
    required this.tuan,
    required this.chiTietBienBanShcn,
  });

  factory BienBanShcn.fromJson(Map<String, dynamic> json) {
    return BienBanShcn(
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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      lop: Lop.fromJson(json['lop']),
      thuky: SinhVien.fromJson(json['thuky']),
      gvcn: GiaoVien.fromJson(json['gvcn']),
      tuan: Tuan.fromJson(json['tuan']),
      chiTietBienBanShcn: json['chi_tiet_bien_ban_s_h_c_n'],
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
      tenLop: json['ten_lop'],
      idNienKhoa: json['id_nien_khoa'],
      idGvcn: json['id_gvcn'],
      idChuyenNganh: json['id_chuyen_nganh'],
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
  final DateTime ngayBatDau;
  final DateTime ngayKetThuc;
  final DateTime createdAt;
  final DateTime updatedAt;

  Tuan({
    required this.id,
    required this.idNam,
    required this.tuan,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tuan.fromJson(Map<String, dynamic> json) {
    return Tuan(
      id: json['id'],
      idNam: json['id_nam'],
      tuan: json['tuan'],
      ngayBatDau: DateTime.parse(json['ngay_bat_dau']),
      ngayKetThuc: DateTime.parse(json['ngay_ket_thuc']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Gvcn {
  final int id;
  final int idHoSo;
  final int idBoMon;
  final String taiKhoan;
  final int trangThai;
  final HoSo hoSo;

  Gvcn({
    required this.id,
    required this.idHoSo,
    required this.idBoMon,
    required this.taiKhoan,
    required this.trangThai,
    required this.hoSo,
  });

  factory Gvcn.fromJson(Map<String, dynamic> json) {
    return Gvcn(
      id: json['id'],
      idHoSo: json['id_ho_so'],
      idBoMon: json['id_bo_mon'],
      taiKhoan: json['tai_khoan'],
      trangThai: json['trang_thai'],
      hoSo: HoSo.fromJson(json['ho_so']),
    );
  }
}

class SinhVien {
  final int id;
  final String maSv;
  final int idHoSo;
  final String password;
  final int trangThai;
  final HoSo hoSo;

  SinhVien({
    required this.id,
    required this.maSv,
    required this.idHoSo,
    required this.password,
    required this.trangThai,
    required this.hoSo,
  });

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json['id'],
      maSv: json['ma_sv'],
      idHoSo: json['id_ho_so'],
      password: json['password'],
      trangThai: json['trang_thai'],
      hoSo: HoSo.fromJson(json['ho_so']),
    );
  }
}

class GiaoVien {
  final int id;
  final int idHoSo;
  final int idBoMon;
  final String taiKhoan;
  final int trangThai;
  final HoSo hoSo;

  GiaoVien({
    required this.id,
    required this.idHoSo,
    required this.idBoMon,
    required this.taiKhoan,
    required this.trangThai,
    required this.hoSo,
  });

  factory GiaoVien.fromJson(Map<String, dynamic> json) {
    return GiaoVien(
      id: json['id'],
      idHoSo: json['id_ho_so'],
      idBoMon: json['id_bo_mon'],
      taiKhoan: json['tai_khoan'],
      trangThai: json['trang_thai'],
      hoSo: HoSo.fromJson(json['ho_so']),
    );
  }
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({this.url, required this.label, required this.active});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(url: json['url'], label: json['label'], active: json['active']);
  }
}

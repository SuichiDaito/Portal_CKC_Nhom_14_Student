class ScheduleResponse {
  final bool? status;
  final List<ScheduleData>? data;

  ScheduleResponse({this.status, this.data});

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleResponse(
      status: json['status'],
      data: (json['data'] as List?)
          ?.map((e) => ScheduleData.fromJson(e))
          .toList(),
    );
  }
}

class ScheduleData {
  final int? id;
  final String? idTuan;
  final String? idLopHocPhan;
  final String? idPhong;
  final String? tietBatDau;
  final String? tietKetThuc;
  final String? ngay;
  final Phong? phong;
  final Tuan? tuan;
  final LopHocPhan? lopHocPhan;

  ScheduleData({
    this.id,
    this.idTuan,
    this.idLopHocPhan,
    this.idPhong,
    this.tietBatDau,
    this.tietKetThuc,
    this.ngay,
    this.phong,
    this.tuan,
    this.lopHocPhan,
  });

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    return ScheduleData(
      id: json['id'],
      idTuan: json['id_tuan'],
      idLopHocPhan: json['id_lop_hoc_phan'],
      idPhong: json['id_phong'],
      tietBatDau: json['tiet_bat_dau'],
      tietKetThuc: json['tiet_ket_thuc'],
      ngay: json['ngay'],
      phong: json['phong'] != null ? Phong.fromJson(json['phong']) : null,
      tuan: json['tuan'] != null ? Tuan.fromJson(json['tuan']) : null,
      lopHocPhan: json['lop_hoc_phan'] != null
          ? LopHocPhan.fromJson(json['lop_hoc_phan'])
          : null,
    );
  }
}

class Phong {
  final int? id;
  final String? ten;
  final String? soLuong;
  final int? loaiPhong;

  Phong({this.id, this.ten, this.soLuong, this.loaiPhong});

  factory Phong.fromJson(Map<String, dynamic> json) {
    return Phong(
      id: json['id'],
      ten: json['ten'],
      soLuong: json['so_luong'],
      loaiPhong: json['loai_phong'],
    );
  }
}

class Tuan {
  final int? id;
  final String? tuan;
  final String? idNam;
  final String? ngayBatDau;
  final String? ngayKetThuc;

  Tuan({this.id, this.tuan, this.idNam, this.ngayBatDau, this.ngayKetThuc});

  factory Tuan.fromJson(Map<String, dynamic> json) {
    return Tuan(
      id: json['id'],
      tuan: json['tuan'],
      idNam: json['id_nam'],
      ngayBatDau: json['ngay_bat_dau'],
      ngayKetThuc: json['ngay_ket_thuc'],
    );
  }
}

class LopHocPhan {
  final int? id;
  final String? tenHocPhan;
  final String? idGiangVien;
  final String? idLop;
  final String? loaiLopHocPhan;
  final String? loaiMon;
  final Lop? lop;
  final GiangVien? giangVien;

  LopHocPhan({
    this.id,
    this.tenHocPhan,
    this.idGiangVien,
    this.idLop,
    this.loaiLopHocPhan,
    this.loaiMon,
    this.lop,
    this.giangVien,
  });

  factory LopHocPhan.fromJson(Map<String, dynamic> json) {
    return LopHocPhan(
      id: json['id'],
      tenHocPhan: json['ten_hoc_phan'],
      idGiangVien: json['id_giang_vien'],
      idLop: json['id_lop'],
      loaiLopHocPhan: json['loai_lop_hoc_phan'],
      loaiMon: json['loai_mon'],
      lop: json['lop'] != null ? Lop.fromJson(json['lop']) : null,
      giangVien: json['giang_vien'] != null
          ? GiangVien.fromJson(json['giang_vien'])
          : null,
    );
  }
}

class Lop {
  final int? id;
  final String? ten;

  Lop({this.id, this.ten});

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(id: json['id'], ten: json['ten']);
  }
}

class GiangVien {
  final int? id;
  final String? hoTen;

  GiangVien({this.id, this.hoTen});

  factory GiangVien.fromJson(Map<String, dynamic> json) {
    return GiangVien(id: json['id'], hoTen: json['ho_ten']);
  }
}

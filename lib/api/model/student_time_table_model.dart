class ScheduleResponse {
  final bool status;
  final List<ScheduleData> data;

  ScheduleResponse({required this.status, required this.data});

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleResponse(
      status: json['status'],
      data: List<ScheduleData>.from(
        json['data'].map((x) => ScheduleData.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.map((x) => x.toJson()).toList(),
  };
}

class ScheduleData {
  final int id;
  final int idTuan;
  final int idLopHocPhan;
  final int idPhong;
  final int tietBatDau;
  final int tietKetThuc;
  final String ngay;
  final Phong phong;
  final Tuan tuan;
  final LopHocPhan lopHocPhan;

  ScheduleData({
    required this.id,
    required this.idTuan,
    required this.idLopHocPhan,
    required this.idPhong,
    required this.tietBatDau,
    required this.tietKetThuc,
    required this.ngay,
    required this.phong,
    required this.tuan,
    required this.lopHocPhan,
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
      phong: Phong.fromJson(json['phong']),
      tuan: Tuan.fromJson(json['tuan']),
      lopHocPhan: LopHocPhan.fromJson(json['lop_hoc_phan']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_tuan': idTuan,
    'id_lop_hoc_phan': idLopHocPhan,
    'id_phong': idPhong,
    'tiet_bat_dau': tietBatDau,
    'tiet_ket_thuc': tietKetThuc,
    'ngay': ngay,
    'phong': phong.toJson(),
    'tuan': tuan.toJson(),
    'lop_hoc_phan': lopHocPhan.toJson(),
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

  factory Phong.fromJson(Map<String, dynamic> json) {
    return Phong(
      id: json['id'],
      ten: json['ten'],
      soLuong: json['so_luong'],
      loaiPhong: json['loai_phong'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'ten': ten,
    'so_luong': soLuong,
    'loai_phong': loaiPhong,
  };
}

class Tuan {
  final int id;
  final int tuan;
  final int idNam;
  final String ngayBatDau;
  final String ngayKetThuc;

  Tuan({
    required this.id,
    required this.tuan,
    required this.idNam,
    required this.ngayBatDau,
    required this.ngayKetThuc,
  });

  factory Tuan.fromJson(Map<String, dynamic> json) {
    return Tuan(
      id: json['id'],
      tuan: json['tuan'],
      idNam: json['id_nam'],
      ngayBatDau: json['ngay_bat_dau'],
      ngayKetThuc: json['ngay_ket_thuc'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'tuan': tuan,
    'id_nam': idNam,
    'ngay_bat_dau': ngayBatDau,
    'ngay_ket_thuc': ngayKetThuc,
  };
}

class LopHocPhan {
  final int id;
  final String tenHocPhan;
  final int idGiangVien;
  final int idLop;
  final int loaiLopHocPhan;
  final String loaiMon;
  final Lop lop;
  final GiangVien giangVien;

  LopHocPhan({
    required this.id,
    required this.tenHocPhan,
    required this.idGiangVien,
    required this.idLop,
    required this.loaiLopHocPhan,
    required this.loaiMon,
    required this.lop,
    required this.giangVien,
  });

  factory LopHocPhan.fromJson(Map<String, dynamic> json) {
    return LopHocPhan(
      id: json['id'],
      tenHocPhan: json['ten_hoc_phan'],
      idGiangVien: json['id_giang_vien'],
      idLop: json['id_lop'],
      loaiLopHocPhan: json['loai_lop_hoc_phan'],
      loaiMon: json['loai_mon'],
      lop: Lop.fromJson(json['lop']),
      giangVien: GiangVien.fromJson(json['giang_vien']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'ten_hoc_phan': tenHocPhan,
    'id_giang_vien': idGiangVien,
    'id_lop': idLop,
    'loai_lop_hoc_phan': loaiLopHocPhan,
    'loai_mon': loaiMon,
    'lop': lop.toJson(),
    'giang_vien': giangVien.toJson(),
  };
}

class Lop {
  final int id;
  final String ten;

  Lop({required this.id, required this.ten});

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(id: json['id'], ten: json['ten']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'ten': ten};
}

class GiangVien {
  final int id;
  final String hoTen;

  GiangVien({required this.id, required this.hoTen});

  factory GiangVien.fromJson(Map<String, dynamic> json) {
    return GiangVien(id: json['id'], hoTen: json['ho_ten']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'ho_ten': hoTen};
}

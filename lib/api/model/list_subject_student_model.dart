class DiemHocPhanResponse {
  final bool status;
  final List<DiemHocPhan> data;

  DiemHocPhanResponse({required this.status, required this.data});

  factory DiemHocPhanResponse.fromJson(Map<String, dynamic> json) {
    return DiemHocPhanResponse(
      status: json['status'] ?? false,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => DiemHocPhan.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class DiemHocPhan {
  final String tenLop;
  final int idLopHocPhan;
  final String loaiMon;
  final String tenHocPhan;
  final String tenMon;
  final int idMonHoc;
  final double diemTongKet;
  final int soTinChi;
  final int loaiMonEnum;

  DiemHocPhan({
    required this.tenLop,
    required this.idLopHocPhan,
    required this.loaiMon,
    required this.tenHocPhan,
    required this.tenMon,
    required this.idMonHoc,
    required this.diemTongKet,
    required this.soTinChi,
    required this.loaiMonEnum,
  });

  factory DiemHocPhan.fromJson(Map<String, dynamic> json) {
    return DiemHocPhan(
      tenLop: json['ten_lop'] ?? '',
      idLopHocPhan: json['id_lop_hoc_phan'] ?? 0,
      loaiMon: json['loai_mon'] ?? '',
      tenHocPhan: json['ten_hoc_phan'] ?? '',
      tenMon: json['ten_mon'] ?? '',
      idMonHoc: json['id_mon_hoc'] ?? 0,
      diemTongKet: (json['diem_tong_ket'] as num?)?.toDouble() ?? 0.0,
      soTinChi: json['so_tin_chi'] ?? 0,
      loaiMonEnum: json['loai_mon_enum'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'ten_lop': tenLop,
    'id_lop_hoc_phan': idLopHocPhan,
    'loai_mon': loaiMon,
    'ten_hoc_phan': tenHocPhan,
    'ten_mon': tenMon,
    'id_mon_hoc': idMonHoc,
    'diem_tong_ket': diemTongKet,
    'so_tin_chi': soTinChi,
    'loai_mon_enum': loaiMonEnum,
  };
}

class DiemHocPhanResponse {
  final bool? status;
  final List<DiemHocPhan>? data;

  DiemHocPhanResponse({this.status, this.data});

  factory DiemHocPhanResponse.fromJson(Map<String, dynamic> json) {
    return DiemHocPhanResponse(
      status: json['status'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DiemHocPhan.fromJson(e))
          .toList(),
    );
  }
}

class DiemHocPhan {
  final String? tenLop;
  final String? idLopHocPhan;
  final String? loaiMon;
  final String? tenHocPhan;
  final String? tenMon;
  final String? idMonHoc;
  final String? diemTongKet;
  final String? soTinChi;
  final int? loaiMonEnum;

  DiemHocPhan({
    this.tenLop,
    this.idLopHocPhan,
    this.loaiMon,
    this.tenHocPhan,
    this.tenMon,
    this.idMonHoc,
    this.diemTongKet,
    this.soTinChi,
    this.loaiMonEnum,
  });

  factory DiemHocPhan.fromJson(Map<String, dynamic> json) {
    return DiemHocPhan(
      tenLop: json['ten_lop'] as String?,
      idLopHocPhan: json['id_lop_hoc_phan'] as String?,
      loaiMon: json['loai_mon'] as String?,
      tenHocPhan: json['ten_hoc_phan'] as String?,
      tenMon: json['ten_mon'] as String?,
      idMonHoc: json['id_mon_hoc'] as String?,
      diemTongKet: json['diem_tong_ket'] as String?,
      soTinChi: json['so_tin_chi'] as String?,
      loaiMonEnum: json['loai_mon_enum'] as int?,
    );
  }
}

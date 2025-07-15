class LoaiGiay {
  final int id;
  final String tenGiay;
  final int trangThai;

  LoaiGiay({required this.id, required this.tenGiay, required this.trangThai});

  factory LoaiGiay.fromJson(Map<String, dynamic> json) {
    return LoaiGiay(
      id: json['id'],
      tenGiay: json['ten_giay'],
      trangThai: json['trang_thai'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'ten_giay': tenGiay, 'trang_thai': trangThai};
  }
}

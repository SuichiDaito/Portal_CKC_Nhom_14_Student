import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BienBanModel {
  final String tenLop;
  final String tenGVCN;
  final String tenThuKy;
  final int tuan;
  final String ngayThang;
  final String trangThai;

  BienBanModel({
    required this.tenLop,
    required this.tenGVCN,
    required this.tenThuKy,
    required this.tuan,
    required this.ngayThang,
    required this.trangThai,
  });
}

//TRANG DANH SÁCH BIÊN BẢNG CHỦ NHIỆM
class PageMeetingMinutesAdmin extends StatefulWidget {
  const PageMeetingMinutesAdmin({super.key});

  @override
  State<PageMeetingMinutesAdmin> createState() =>
      _PageMeetingMinutesAdminState();
}

class _PageMeetingMinutesAdminState extends State<PageMeetingMinutesAdmin> {
  List<BienBanModel> bienBans = [
    BienBanModel(
      tenLop: 'CTK45A',
      tenGVCN: 'Nguyễn Văn A',
      tenThuKy: 'Trần Thị B',
      tuan: 1,
      ngayThang: '03/06/2025',
      trangThai: 'Chờ duyệt',
    ),
    BienBanModel(
      tenLop: 'CTK45A',
      tenGVCN: 'Nguyễn Văn A',
      tenThuKy: 'Trần Thị B',
      tuan: 2,
      ngayThang: '10/06/2025',
      trangThai: 'Đã duyệt',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin sinh hoạt chủ nhiệm'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF4F6F9),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: bienBans.length,
              itemBuilder: (context, index) {
                final bienBan = bienBans[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      '${bienBan.tenLop} - Tuần ${bienBan.tuan}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('GVCN: ${bienBan.tenGVCN}'),
                        Text('Thư ký: ${bienBan.tenThuKy}'),
                        Text('Ngày: ${bienBan.ngayThang}'),
                        Text(
                          'Trạng thái: ${bienBan.trangThai}',
                          style: TextStyle(
                            color: bienBan.trangThai == 'Đã duyệt'
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Xử lý xem chi tiết
                        context.push(
                          '/admin/report_detail_admin',
                          extra: {'isApproved': false},
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Chi tiết',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

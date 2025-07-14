// import 'package:flutter/material.dart';
// import 'package:portal_ckc/api/model/exam_model.dart';
// import 'package:portal_ckc/presentation/pages/page_exam_schedule_admin.dart';

// class ExamDutyCard extends StatelessWidget {
//   final String nameSubject;
//   final String nameLecture1;
//   final String nameLecture2;
//   final String dateExam;
//   final String beginTime;
//   final int distanceTime;
//   final String nameRoom;
//   final int examTimes;
//   const ExamDutyCard({
//     required this.nameSubject,
//     required this.nameLecture1,
//     required this.nameLecture2,
//     required this.dateExam,
//     required this.beginTime,
//     required this.distanceTime,
//     required this.nameRoom,
//     required this.examTimes, required ExamSchedule duty,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.blue.withOpacity(0.05),
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade50,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.blue),
//             ),
//             child: Text(
//               nameSubject,
//               style: TextStyle(
//                 color: Colors.blue,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               Icon(Icons.supervisor_account, color: Colors.blue[700], size: 18),
//               SizedBox(width: 6),
//               Text(
//                 '${nameLecture1} & ${nameLecture2}',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue[800],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 6),
//           Row(
//             children: [
//               Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
//               SizedBox(width: 6),
//               Text('Ngày thi: ${dateExam}'),
//             ],
//           ),
//           SizedBox(height: 4),
//           Row(
//             children: [
//               Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
//               SizedBox(width: 6),
//               Text('Bắt đầu: ${beginTime} | ${distanceTime} phút'),
//             ],
//           ),
//           SizedBox(height: 4),
//           Row(
//             children: [
//               Icon(Icons.meeting_room, size: 16, color: Colors.grey[600]),
//               SizedBox(width: 6),
//               Text('Phòng: ${nameRoom}'),
//             ],
//           ),
//           SizedBox(height: 4),
//           Row(
//             children: [
//               Icon(
//                 Icons.add_circle_outlined,
//                 size: 16,
//                 color: Colors.grey[600],
//               ),
//               SizedBox(width: 6),
//               Text('Lần thi: ${examTimes}'),
//             ],
//           ),
//           SizedBox(height: 4),
//           Row(
//             children: [
//               Icon(Icons.check_circle, size: 16, color: Colors.grey[600]),
//               SizedBox(width: 6),
//               Text('Trạng thái: ${checkDate(dateExam)}'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// String checkDate(String dateString) {
//   // Chuyển đổi chuỗi sang DateTime
//   final inputDate = DateTime.tryParse(dateString);

//   // Nếu không chuyển được thì có thể xử lý tùy ý (ở đây return -1)
//   if (inputDate == null) {
//     return 'Lỗi';
//   }

//   // Lấy thời điểm hiện tại
//   final now = DateTime.now();

//   // So sánh ngày (không tính giờ phút giây)
//   if (inputDate.isBefore(now)) {
//     return 'Đã thi xong'; // Đã vượt qua ngày hiện tại
//   } else {
//     return 'Chưa thi'; // Vẫn còn sau hoặc bằng ngày hiện tại
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/exam_model.dart';
import 'package:portal_ckc/presentation/sections/button/button_login.dart';
import 'package:portal_ckc/presentation/sections/button/button_navigation.dart';

class ExamDutyCard extends StatelessWidget {
  final ExamSchedule duty;

  ExamDutyCard({required this.duty});
  String _getRealStatus(String ngayThi, String gioBatDau) {
    try {
      final now = DateTime.now();
      final ngayGioThi = DateTime.parse('$ngayThi $gioBatDau');
      final thiStart = DateTime(
        ngayGioThi.year,
        ngayGioThi.month,
        ngayGioThi.day,
      );
      final today = DateTime(now.year, now.month, now.day);

      if (thiStart.isBefore(today)) return 'Đã hoàn thành';
      if (thiStart.isAfter(today)) return 'Chưa diễn ra';
      return 'Đang diễn ra';
    } catch (e) {
      return 'Không xác định';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue),
            ),
            child: Text(
              '${duty.lopHocPhan?.tenHocPhan}',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Icon(Icons.supervisor_account, color: Colors.blue[700], size: 18),
              SizedBox(width: 6),
              Text(
                '${duty.giamThi1?.hoSo?.hoTen} & ${duty.giamThi2?.hoSo?.hoTen}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Ngày thi: ${formatDate(duty.ngayThi ?? '')}'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Bắt đầu: ${duty.gioBatDau} | ${duty.thoiGianThi} phút'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.meeting_room, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Phòng: ${duty.phong?.ten}'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.check_circle, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text(
                'Trạng thái: ${_getRealStatus(duty.ngayThi ?? '', duty.gioBatDau ?? '')}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String formatDate(String dateStr) {
  try {
    DateTime date = DateTime.parse(dateStr); // Chuyển String thành DateTime
    return DateFormat('dd/MM/yyyy').format(date); // Format lại theo ý muốn
  } catch (e) {
    return dateStr; // Nếu lỗi (ví dụ sai format), trả lại chuỗi gốc
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:portal_ckc/api/model/student_report_model.dart';

class ReportDetailReadonlySummaryCard extends StatefulWidget {
  final int week;
  final String beginDate;
  final String endDate;
  final String startHour;
  final String endHour;
  final String roomNumber;
  final String teacher;
  final String secretary;
  final int totalStudent;
  final int absentStudent;
  final String content;
  final List<ChiTietBienBanSHCN> absentStudentIds;
  final List<Map<String, String>> studentList;

  ReportDetailReadonlySummaryCard({
    super.key,
    required this.week,
    required this.beginDate,
    required this.endDate,
    required this.startHour,
    required this.endHour,
    required this.roomNumber,
    required this.teacher,
    required this.secretary,
    required this.totalStudent,
    required this.absentStudent,
    required this.content,
    required this.absentStudentIds,
    required this.studentList,
  });

  State<ReportDetailReadonlySummaryCard> createState() => ReportDetail();
}

int caculatedNumberStudent(int totalStudent, int absentStudent) {
  int number = totalStudent - absentStudent;
  return number.abs();
}

class ReportDetail extends State<ReportDetailReadonlySummaryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const Text(
                    'TRƯỜNG CĐ KỸ THUẬT CAO THẮNG',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'PHÒNG CÔNG TÁC CHÍNH TRỊ-HSSV',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text('Độc lập - Tự do - Hạnh phúc'),
                  const Text('*****'),
                  const SizedBox(height: 16),
                  const Text(
                    'BIÊN BẢN SINH HOẠT CHỦ NHIỆM',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'TUẦN THỨ: ${widget.week} (${widget.beginDate} – ${widget.endDate})',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'Thời gian bắt đầu sinh hoạt lớp: ${widget.startHour} ngày ${widget.beginDate}',
            ),
            Text('Địa điểm sinh hoạt: ${widget.roomNumber}'),
            const SizedBox(height: 8),

            const Text(
              'Thành phần tham dự gồm có:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(' - Giáo viên chủ nhiệm (ghi họ và tên): ${widget.teacher}'),
            Text(' - Thư ký (ghi họ và tên): ${widget.secretary}'),
            Text(
              ' - Sĩ số: ${widget.totalStudent}       Hiện diện: ${caculatedNumberStudent(widget.totalStudent, widget.absentStudent)}        Vắng mặt: ${widget.absentStudent}',
            ),

            if (widget.absentStudentIds.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text('Họ và tên HSSV vắng, lý do:'),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.absentStudentIds.length,
                itemBuilder: (context, index) {
                  final student = widget.absentStudentIds[index];
                  return ListTile(
                    dense: true,
                    leading: Text('${index + 1}.'),
                    title: Text(
                      'Họ tên sinh viên: ${student.sinhVien?.hoSo?.hoTen}-(${student.sinhVien?.maSv})',
                    ),
                    subtitle: Text('Lý do: ${student.lyDo}'),
                  );
                },
              ),
            ],
            const SizedBox(height: 16),
            const Text(
              'NỘI DUNG (Ghi tóm tắt nội dung sinh hoạt):',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(widget.content),

            const SizedBox(height: 16),
            const Text(
              'CÁC ĐỀ XUẤT, KIẾN NGHỊ:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const Text(
              '..........................................................................................',
            ),
            const Text(
              '..........................................................................................',
            ),

            const SizedBox(height: 16),
            Text('Buổi sinh hoạt kết thúc lúc: ${widget.endHour} cùng ngày.'),

            const SizedBox(height: 24),
            Wrap(
              spacing: 24,
              runSpacing: 16,
              alignment: WrapAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('GVCN (Ký, ghi rõ họ tên)'),
                      SizedBox(height: 40),
                      Text(widget.teacher),
                    ],
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Thư ký (Ký, ghi rõ họ tên)'),
                      SizedBox(height: 40),
                      Text(widget.secretary),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

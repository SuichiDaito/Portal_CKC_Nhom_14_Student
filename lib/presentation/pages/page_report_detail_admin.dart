import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_absent_student_manager.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_build_content_input.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_fixed_info_card.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_readonly_summary_card.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_editable_section.dart';

class PageReportDetailAdmin extends StatefulWidget {
  const PageReportDetailAdmin({super.key});
  @override
  State<PageReportDetailAdmin> createState() => _PageReportDetailAdminState();
}

String formatTime(DateTime date) {
  String formatted = DateFormat('h:mm a').format(date);
  return formatted;
}

String formatDate(DateTime date) {
  String formatted = DateFormat('dd-MM-yyyy').format(date);
  return formatted;
}

class _PageReportDetailAdminState extends State<PageReportDetailAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo biên bản sinh hoạt'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white, // Làm trắng cả chữ và icon
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Mũi tên back trắng
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _buildApprovedView(),
    );
  }

  Widget _buildApprovedView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReportDetailReadonlySummaryCard(
            week: 1,
            beginDate: formatDate(DateTime.now()),
            endDate: formatDate(DateTime.now()),
            roomNumber: 'CDTH22DDE',
            startHour: formatTime(DateTime.now()),
            endHour: formatTime(DateTime.now()),
            teacher: 'Nguyễn Văn A',
            totalStudent: 40,
            absentStudent: 2,
            content: 'content',
            absentStudentIds: [],
            studentList: [],
          ),
        ],
      ),
    );
  }
}


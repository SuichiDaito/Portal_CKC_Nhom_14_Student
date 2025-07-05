import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_report_response_bloc.dart';
import 'package:portal_ckc/bloc/event/certificates_event.dart';
import 'package:portal_ckc/bloc/event/student_report_response_event.dart';
import 'package:portal_ckc/bloc/state/student_report_response.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_absent_student_manager.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_build_content_input.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_fixed_info_card.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_readonly_summary_card.dart';
import 'package:portal_ckc/presentation/sections/card/report_detail_editable_section.dart';
import 'package:portal_ckc/utils/formatter_datetime.dart';

class PageReportDetailAdmin extends StatefulWidget {
  const PageReportDetailAdmin({super.key});

  @override
  State<PageReportDetailAdmin> createState() => _PageReportDetailAdminState();
}

class _PageReportDetailAdminState extends State<PageReportDetailAdmin> {
  void initState() {
    super.initState();
    context.read<StudentReportResponseBloc>().add(FetchReportResponseEvent());
  }

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
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<StudentReportResponseBloc, StudentReportResponseState>(
        builder: (context, state) {
          if (state is StudentReportResponseLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is StudentReportResponseLoaded) {
            final reports = state.reportResponseList;
            if (reports.isEmpty) {
              return Center(
                child: Text(
                  'Không có biên bản nào.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReportDetailReadonlySummaryCard(
                      week: reports[index].tuan.tuan,
                      beginDate: DateFormatter.formatDate(
                        reports[index].thoiGianBatDau,
                      ),
                      endDate: DateFormatter.formatDate(
                        reports[index].thoiGianKetThuc,
                      ),
                      roomNumber: reports[index].lop.tenLop,
                      startHour: DateFormatter.formatTime(
                        reports[index].thoiGianBatDau,
                      ),
                      endHour: DateFormatter.formatTime(
                        reports[index].thoiGianKetThuc,
                      ),
                      teacher: reports[index].gvcn.hoSo.hoTen,
                      secretary: reports[index].thuky.hoSo.hoTen,
                      totalStudent: reports[index].soLuongSinhVien,
                      absentStudent: reports[index].vangMat,
                      content: reports[index].noiDung,
                      absentStudentIds: [],
                      studentList: [],
                    ),
                  ],
                );
              },
            );
          } else if (state is StudentReportResponseError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('NOT FOUND | 404'));
          }
        },
      ),
    );
  }
}

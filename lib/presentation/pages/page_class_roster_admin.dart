import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/class_subject_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/exam_second_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_exam_second_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/subject_fail_bloc.dart';
import 'package:portal_ckc/bloc/event/class_subject_event.dart';
import 'package:portal_ckc/bloc/event/exam_second_event.dart';
import 'package:portal_ckc/bloc/event/list_subject_event.dart';
import 'package:portal_ckc/bloc/event/payment_exam_second.dart';
import 'package:portal_ckc/bloc/state/exam_second_state.dart';
import 'package:portal_ckc/bloc/state/list_subject_fail.dart';
import 'package:portal_ckc/bloc/state/payment_exam_second_state.dart';
import 'package:portal_ckc/presentation/pages/page_show_detail_class_subject.dart';
import 'package:portal_ckc/presentation/sections/empty_section.dart';
import 'package:url_launcher/url_launcher.dart';

class ClassListScreen extends StatefulWidget {
  @override
  State<ClassListScreen> createState() => ListScreen();
}

class ListScreen extends State<ClassListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SubjectFailBloc>().add(FetchListSubjectEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E3A8A),
      appBar: AppBar(
        backgroundColor: Color(0xFF3B82F6),
        title: Text(
          'Danh sách các môn sinh viên rớt',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: BlocConsumer<SubjectFailBloc, ListSubjectFailState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ListSubjectFailStateLoading ||
              state is ListSubjectFailInitial) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is ListSubjectFailStateLoaded) {
            final subject = state.subject;
            if (subject.isEmpty) {
              return EmptySection(message: 'Chúc mừng sinh viên không rớt môn');
            }
            return Container(
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: subject.length,
                itemBuilder: (context, index) {
                  return FailedSubjectCard(
                    idSubject: int.parse(subject[index].idMonHoc ?? '0'),
                    nameSubject: subject[index].tenMon ?? '',
                    nameSectionClass: subject[index].tenHocPhan ?? '',
                    numberCredit: int.parse(subject[index].soTinChi ?? '0'),
                    totalPoint: double.parse(
                      subject[index].diemTongKet ?? '0.0',
                    ),
                    typeSubject: subject[index].loaiMon ?? '0',
                  );
                },
              ),
            );
          } else if (state is ListSubjectFailStateError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('NOT FOUND | 404'));
        },
      ),
    );
  }
}

class FailedSubjectCard extends StatelessWidget {
  final int idSubject;
  final String nameSubject;
  final String nameSectionClass;
  final String typeSubject;
  final int numberCredit;
  final double totalPoint;
  final VoidCallback? onTap;

  const FailedSubjectCard({
    super.key,
    required this.idSubject,
    required this.nameSubject,
    required this.nameSectionClass,
    required this.numberCredit,
    required this.totalPoint,
    required this.typeSubject,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header với tên môn học
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A90E2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.school,
                        color: const Color(0xFF4A90E2),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        nameSubject,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Thông tin chi tiết
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.category,
                        label: 'Học phần',
                        value: nameSectionClass,
                        color: const Color(0xFF27AE60),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.library_books,
                        label: 'Loại môn',
                        value: typeSubject,
                        color: const Color(0xFFE67E22),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.credit_card,
                        label: 'Số tín chỉ',
                        value: numberCredit.toString(),
                        color: const Color(0xFF9B59B6),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.star,
                        label: 'Điểm tổng kết',
                        value: totalPoint.toString(),
                        color: totalPoint >= 8.0
                            ? const Color(0xFF27AE60)
                            : totalPoint >= 6.5
                            ? const Color(0xFFF39C12)
                            : const Color(0xFFE74C3C),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                // Nút bấm
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ClassSubjectBloc>().add(
                        RequestClassSubjectEvent(id_mon_hoc: idSubject),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageShowDetailClassSubject(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A90E2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Xem chi tiết lớp học phần',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoItem({
  required IconData icon,
  required String label,
  required String value,
  required Color color,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2C3E50),
        ),
      ),
    ],
  );
}

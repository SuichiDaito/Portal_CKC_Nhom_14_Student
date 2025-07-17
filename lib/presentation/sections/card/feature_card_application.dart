import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/class_subject_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/class_subject_event.dart';
import 'package:portal_ckc/bloc/event/student_event.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';

class FeatureCardApplication extends StatefulWidget {
  final BuildContext context;
  final FeatureItem feature;

  FeatureCardApplication({
    super.key,
    required this.context,
    required this.feature,
  });
  @override
  State<FeatureCardApplication> createState() => FeatureCard();
}

class FeatureCard extends State<FeatureCardApplication> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentLoaded) {
          final student = state.student.danhSachSinhVien.last.chucVu;
          if (student == 1) {
            return GestureDetector(
              onTap: () {
                print(
                  'Tapped on id: ${widget.feature.id} title: ${widget.feature.title}',
                );

                if (widget.feature.id == 0) {
                  // Điểm học tập
                  context.push('/student/show/point');
                } else if (widget.feature.id == 1) {
                  // Điểm rèn luyện
                  context.push('/admin/conduct_evaluation_admin');
                } else if (widget.feature.id == 2) {
                  // Lịch thi
                  context.push('/admin/exam_schedule_admin');
                } else if (widget.feature.id == 3) {
                  // Thời khóa biểu
                  context.push('/admin/teaching_schedule_admin');
                } else if (widget.feature.id == 4) {
                  // Đăng ký học phần
                  context.push('/admin/class_roster_admin');
                } else if (widget.feature.id == 5) {
                  // Đăng ký thi lại
                  GoRouter.of(context).push('/student/exam/second');
                } else if (widget.feature.id == 6) {
                  // Sinh hoạt chủ nhiệm
                  GoRouter.of(context).push('/admin/report_detail_admin');
                } else if (widget.feature.id == 7) {
                  // Xin cấp giấy tờ
                  context.push('/student/signup/certificates');
                } else if (widget.feature.id == 8) {
                  // Viết biên bản sinh hoạt (Thư ký)
                  GoRouter.of(context).push('/student/show/report/list');
                } else if (widget.feature.id == 9) {
                  // Chương trình đào tạo
                  GoRouter.of(context).push('/student/training/program');
                } else if (widget.feature.id == 10) {
                  // Tra cứu thông tin giảng viên
                  GoRouter.of(context).push('/student/info/teacher');
                } else if (widget.feature.id == 11) {
                  // Xem danh sách giấy xác nhận đã đăng ký
                  GoRouter.of(context).push('/student/list/certificates');
                } else if (widget.feature.id == 12) {
                  // Xem danh sách giấy xác nhận đã đăng ký
                  GoRouter.of(context).push('/student/payment');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon Container
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: widget.feature.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.feature.icon,
                        color: widget.feature.color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        widget.feature.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                print(
                  'Tapped on id: ${widget.feature.id} title: ${widget.feature.title}',
                );

                if (widget.feature.id == 0) {
                  // Điểm học tập
                  context.push('/student/show/point');
                } else if (widget.feature.id == 1) {
                  // Điểm rèn luyện
                  context.push('/admin/conduct_evaluation_admin');
                } else if (widget.feature.id == 2) {
                  // Lịch thi
                  context.push('/admin/exam_schedule_admin');
                } else if (widget.feature.id == 3) {
                  // Thời khóa biểu
                  context.push('/admin/teaching_schedule_admin');
                } else if (widget.feature.id == 4) {
                  // Đăng ký học phần
                  context.push('/admin/class_roster_admin');
                } else if (widget.feature.id == 5) {
                  // Đăng ký thi lại
                  GoRouter.of(context).push('/student/exam/second');
                } else if (widget.feature.id == 6) {
                  // Sinh hoạt chủ nhiệm
                  GoRouter.of(context).push('/admin/report_detail_admin');
                } else if (widget.feature.id == 7) {
                  // Xin cấp giấy tờ
                  context.push('/student/signup/certificates');
                } else if (widget.feature.id == 8) {
                  // Viết biên bản sinh hoạt (Thư ký)
                  GoRouter.of(context).push('/student/show/error');
                } else if (widget.feature.id == 9) {
                  // Chương trình đào tạo
                  GoRouter.of(context).push('/student/training/program');
                } else if (widget.feature.id == 10) {
                  // Tra cứu thông tin giảng viên
                  GoRouter.of(context).push('/student/info/teacher');
                } else if (widget.feature.id == 11) {
                  // Xem danh sách giấy xác nhận đã đăng ký
                  GoRouter.of(context).push('/student/list/certificates');
                } else if (widget.feature.id == 12) {
                  // Xem danh sách giấy xác nhận đã đăng ký
                  GoRouter.of(context).push('/student/payment');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon Container
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: widget.feature.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.feature.icon,
                        color: widget.feature.color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        widget.feature.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return Center(child: Text('NOT FOUND | 404'));
      },
    );
  }
}

class FeatureItem {
  final id;
  final IconData icon;
  final String title;
  final Color color;
  final value;
  FeatureItem({
    required this.id,
    required this.icon,
    required this.title,
    required this.color,
    required this.value,
  });
}

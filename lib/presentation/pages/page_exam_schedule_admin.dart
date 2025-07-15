import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/exam_model.dart';
import 'package:portal_ckc/bloc/bloc_event_state/exam_bloc.dart';
import 'package:portal_ckc/bloc/event/exam_event.dart';
import 'package:portal_ckc/bloc/state/exam_state.dart';
import 'package:portal_ckc/presentation/sections/button/button_navigation.dart';
import 'package:portal_ckc/presentation/sections/card/class_management_teacher_info_card.dart';
import 'package:portal_ckc/presentation/sections/card/exam_schedule_view.dart';
import 'package:portal_ckc/presentation/sections/card/student_card_info.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_print_schedule_dialog.dart';
import 'package:portal_ckc/presentation/sections/empty_section.dart';

class PageExamScheduleAdmin extends StatefulWidget {
  @override
  _PageExamScheduleAdminState createState() => _PageExamScheduleAdminState();
}

class _PageExamScheduleAdminState extends State<PageExamScheduleAdmin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExamBloc>().add(FetchExamEvent());
  }

  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lịch thi sinh viên',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<ExamBloc, ExamState>(
        builder: (context, state) {
          if (state is ExamStateLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is ExamStateLoaded) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1E517B), Color(0xFF384CD0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StudentCardInfo(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Wrap(
                      spacing: 8,
                      children: ['Tất cả', 'Chưa diễn ra', 'Đã hoàn thành']
                          .map(
                            (status) => ChoiceChip(
                              label: Text(status),
                              selected: (selectedStatus ?? 'Tất cả') == status,
                              selectedColor: Colors.blue,
                              backgroundColor: Colors.grey[200],
                              labelStyle: TextStyle(
                                color: (selectedStatus ?? 'Tất cả') == status
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              onSelected: (_) {
                                setState(() {
                                  selectedStatus = status == 'Tất cả'
                                      ? null
                                      : status;
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  Expanded(
                    child: BlocBuilder<ExamBloc, ExamState>(
                      builder: (context, state) {
                        if (state is ExamStateLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          );
                        } else if (state is ExamStateLoaded) {
                          if (state.exams.isEmpty) {
                            return EmptySection(
                              message: "Không có lịch thi trong thời gian này",
                            );
                          }
                          final now = DateTime.now();
                          final filteredList = state.exams.where((lich) {
                            final ngayThi = DateTime.tryParse(
                              lich.ngayThi ?? '',
                            );
                            if (ngayThi == null) return false;

                            if (selectedStatus == null ||
                                selectedStatus == 'Tất cả')
                              return true;

                            if (selectedStatus == 'Chưa diễn ra') {
                              return ngayThi.isAfter(
                                DateTime(now.year, now.month, now.day),
                              );
                            } else if (selectedStatus == 'Đã hoàn thành') {
                              return ngayThi.isBefore(
                                DateTime(now.year, now.month, now.day),
                              );
                            } else if (selectedStatus == 'Đang diễn ra') {
                              return ngayThi.year == now.year &&
                                  ngayThi.month == now.month &&
                                  ngayThi.day == now.day;
                            }

                            return true;
                          }).toList();
                          final Map<String, List<ExamSchedule>> grouped = {};
                          for (final lich in filteredList) {
                            final key = lich.ngayThi ?? '';
                            if (!grouped.containsKey(key)) grouped[key] = [];
                            grouped[key]!.add(lich);
                          }

                          return Column(
                            children: [
                              ExamScheduleView(
                                selectedDay: null,
                                scheduleData: grouped,
                                onDayTap: (day) {},
                              ),
                              ButtonNavigation(
                                nameButton: "Xem lịch thi lần hai",
                                onPressed: () {
                                  context.push('/student/exam/second');
                                },
                              ),
                            ],
                          );
                        } else if (state is ExamStateError) {
                          return Center(
                            child: Text(
                              "Bạn không chưa được phân công chức năng này",
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ExamStateError) {
            return EmptySection(message: state.message);
          }
          return EmptySection(message: 'NOT FOUND | 404');
        },
      ),
    );
  }
}

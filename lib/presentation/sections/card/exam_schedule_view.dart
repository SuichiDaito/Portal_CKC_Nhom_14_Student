import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/exam_bloc.dart';
import 'package:portal_ckc/bloc/event/exam_event.dart';
import 'package:portal_ckc/bloc/state/exam_state.dart';
import 'package:portal_ckc/presentation/pages/page_exam_schedule_admin.dart';
import 'package:portal_ckc/presentation/sections/card/exam_duty_card.dart';

class ExamScheduleView extends StatefulWidget {
  final String? selectedDay;
  final Map<String, List<ExamDuty>> scheduleData;
  final void Function(String) onDayTap;

  const ExamScheduleView({
    required this.selectedDay,
    required this.scheduleData,
    required this.onDayTap,
  });

  @override
  State<ExamScheduleView> createState() => ExamCard();
}

class ExamCard extends State<ExamScheduleView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExamBloc>().add(FetchExamEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ExamBloc, ExamState>(
        builder: (context, state) {
          if (state is ExamStateLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is ExamStateLoaded) {
            final exams = state.exams;
            return SizedBox(
              height: 430,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: exams.length,
                      itemBuilder: (context, index) {
                        return ExamDutyCard(
                          nameSubject: '${exams[index].lopHocPhan.tenHocPhan}',
                          nameLecture1: '${exams[index].giamThi1.hoSo.hoTen}',
                          nameLecture2: '${exams[index].giamThi2.hoSo.hoTen}',
                          dateExam: '${exams[index].ngayThi}',
                          beginTime: '${exams[index].gioBatDau}',
                          distanceTime: exams[index].thoiGianThi,
                          nameRoom: '${exams[index].phong.ten}',
                          examTimes: exams[index].lanThi,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ExamStateError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('NOT FOUND | 404'));
        },
      ),
    );
  }
}

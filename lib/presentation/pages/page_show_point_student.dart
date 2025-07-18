import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/student_point_result.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_point_result_bloc.dart';
import 'package:portal_ckc/bloc/event/student_point_event.dart';
import 'package:portal_ckc/bloc/state/student_point_state.dart';

class StudentGradeScreen extends StatefulWidget {
  @override
  State<StudentGradeScreen> createState() => GradeScreen();
}

class GradeScreen extends State<StudentGradeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<StudentPointResultBloc>().add(FetchPointResultEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Bảng điểm sinh viên',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: BlocBuilder<StudentPointResultBloc, StudentResultPointState>(
        builder: (context, state) {
          if (state is StudentPointStateLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is StudentPointStateLoaded) {
            final result = state.subjects;
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: result.length,
              itemBuilder: (context, index) {
                final key = result.keys.elementAt(index);

                final subjects = result[key] ?? [];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tiêu đề học kì
                        Text(
                          'Học kì ${index + 1}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                        SizedBox(height: 8),

                        // Thông tin tổng kết
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tổng tín chỉ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      '${totalCredit(subjects)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'GPA học kì',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      '${totalAvergrade(subjects)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        // Header bảng điểm
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Môn học',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Tín chỉ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Điểm',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),

                        // Danh sách môn học
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: subjects.length,
                          itemBuilder: (context, subjectIndex) {
                            final subject = subjects?[subjectIndex];
                            return Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              margin: EdgeInsets.only(bottom: 4),
                              decoration: BoxDecoration(
                                color: subjectIndex % 2 == 0
                                    ? Colors.white
                                    : Colors.grey[50],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${subject?.tenMon}' ?? '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      checkCredit(subject?.soTinChi),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${subject!.diemTongKet}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[600],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is StudentPointStateError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('NOT FOUND | 404'));
        },
      ),
    );
  }
}

int totalCredit(List<Subject> subject) {
  int total = 0;
  for (int i = 0; i < subject.length; i++) {
    if (subject[i].soTinChi != null && subject[i].soTinChi != "null") {
      total += int.parse(subject[i].soTinChi!);
    }
  }
  return total;
}

double totalAvergrade(List<Subject> subject) {
  double total = 0.0;
  double result = 0.0;
  double kq = 0.0;
  int count = 0;
  for (int i = 0; i < subject.length; i++) {
    if (subject[i].diemTongKet != null &&
        subject[i].diemTongKet != "-" &&
        subject[i].diemTongKet != "null") {
      total += double.parse(subject[i].diemTongKet!);
      count++;
    }
  }

  if (total > 0) {
    result = total / count;
    String roundedString = result.toStringAsFixed(2);
  } else {}
  kq = double.parse(result.toStringAsFixed(2));
  return kq;
}

String checkCredit(String? credit) {
  if (credit == "null" || credit == null) {
    return "-";
  } else {
    return credit;
  }
}

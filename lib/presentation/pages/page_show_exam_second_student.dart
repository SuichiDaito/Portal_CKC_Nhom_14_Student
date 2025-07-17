import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/exam_second_model.dart';
import 'package:portal_ckc/bloc/bloc_event_state/exam_second_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_exam_second_bloc.dart';
import 'package:portal_ckc/bloc/event/exam_second_event.dart';
import 'package:portal_ckc/bloc/event/payment_exam_second.dart';
import 'package:portal_ckc/bloc/state/exam_second_state.dart';
import 'package:portal_ckc/bloc/state/payment_exam_second_state.dart';
import 'package:portal_ckc/presentation/pages/page_detail_payment_exam.dart';
import 'package:portal_ckc/presentation/sections/empty_section.dart';
import 'package:url_launcher/url_launcher.dart';

class ExamSchedulePage extends StatefulWidget {
  @override
  _ExamSchedulePageState createState() => _ExamSchedulePageState();
}

class _ExamSchedulePageState extends State<ExamSchedulePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExamSecondBloc>().add(FetchExamSecondEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E3A8A),
      appBar: AppBar(
        backgroundColor: Color(0xFF3B82F6),
        title: Text(
          'Lịch thi sinh viên',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/apps'),
        ),
        elevation: 0,
      ),
      body: BlocConsumer<ExamSecondBloc, ExamSecondState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ExamSecondStateLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is ExamSecondStateLoaded) {
            final point = state.exams;
            if (point.isEmpty) {
              return EmptySection(
                message: "Không có lịch thi trong thời gian này",
              );
            }
            return Container(
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: point.length,
                itemBuilder: (context, index) {
                  if (int.parse(point[index].lanThi ?? "0") == 2 &&
                      point[index]
                              .lopHocPhan
                              ?.danhSachHocPhan
                              ?.last
                              .diemThiLan2 ==
                          null) {
                    return ExamCard(
                      nameSubject: point[index].lopHocPhan?.tenHocPhan,
                      flag: true,
                      lecture1: point[index].giamThi1?.hoSo?.hoTen ?? '',
                      lecture2: point[index].giamThi2?.hoSo?.hoTen ?? '',
                      date: point[index].ngayThi ?? '',
                      distanceTime: int.parse(point[index].thoiGianThi ?? '0'),
                      room: point[index].phong?.ten ?? '',
                      listSignup:
                          point[index].lopHocPhan?.dangKyHocGhepThiLai ??
                          DangKyHocGhepThiLai(),
                      timeExams: int.parse(point[index].lanThi ?? '0'),
                      pointExam1:
                          double.parse(
                            point[index]
                                    .lopHocPhan!
                                    .danhSachHocPhan!
                                    .last
                                    .diemThiLan1 ??
                                '0.0',
                          ) ??
                          0.0,
                      pointExam2:
                          double.parse(
                            point[index]
                                    .lopHocPhan!
                                    .danhSachHocPhan!
                                    .last
                                    .diemThiLan2 ??
                                '0.0',
                          ) ??
                          0.0,
                      onRegister: () {
                        context.read<PaymentExamSecondBloc>().add(
                          RequestPaymentExamSecond(
                            id: point[index].lopHocPhan?.id ?? 0,
                          ),
                        );
                        _showPaymentDialog(
                          context,
                          point[index].lopHocPhan?.tenHocPhan ?? '',
                          point[index].id ?? 0,
                          point[index].phong?.ten ?? '',
                          point[index].lopHocPhan?.dangKyHocGhepThiLai ??
                              DangKyHocGhepThiLai(),
                        );
                      },
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            );
          } else if (state is ExamSecondStateError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('NOT FOUND | 404'));
        },
      ),
    );
  }

  void _showPaymentDialog(
    BuildContext context,
    String nameSubject,
    int idExam,
    String room,
    DangKyHocGhepThiLai checkDKHG,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Phương thức thanh toán',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          content: BlocBuilder<PaymentExamSecondBloc, PaymentExamSecondState>(
            builder: (context, state) {
              if (state is PaymentExamSecondStateLoading) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              } else if (state is PaymentExamSecondStateLoaded) {
                String url = state.url;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Môn thi: ${nameSubject}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Phí thi: 50.000 VNĐ',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentDetailExamStudent(
                                nameSubject: nameSubject,
                                checkDKHG: checkDKHG,
                                idExam: idExam,
                                room: room,
                              ),
                            ),
                          );

                          print(url);
                          _processVNPayPayment(url);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0066CC),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.payment, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Thanh toán VNPay',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is PaymentExamSecondStateError) {
                return Center(child: Text(state.message));
              }
              return Center(child: Text('NOT FOUND | 404'));
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Hủy', style: TextStyle(color: Colors.grey[600])),
            ),
          ],
        );
      },
    );
  }

  void _processVNPayPayment(String url) async {
    // Tạo URL thanh toán VNPay (demo)
    String vnpayUrl = url;
    try {
      if (await canLaunch(vnpayUrl)) {
        await launch(vnpayUrl);
      } else {
        _showErrorDialog('Không thể mở liên kết thanh toán');
      }
    } catch (e) {
      _showErrorDialog('Lỗi khi mở thanh toán: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lỗi'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class ExamCard extends StatelessWidget {
  bool flag;
  final nameSubject;
  final String lecture1;
  final String lecture2;
  final String date;
  final int distanceTime;
  final String room;
  final int timeExams;
  final double pointExam1;
  final double pointExam2;
  final DangKyHocGhepThiLai listSignup;
  final VoidCallback onRegister;

  ExamCard({
    Key? key,
    required this.nameSubject,
    required this.flag,
    required this.lecture1,
    required this.lecture2,
    required this.date,
    required this.distanceTime,
    required this.room,
    required this.timeExams,
    required this.pointExam1,
    required this.pointExam2,
    required this.listSignup,
    required this.onRegister,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool checkButton(
      double pointExam1,
      DangKyHocGhepThiLai list,
      double pointExam2,
    ) {
      if (pointExam1 != null && list.idLopHocPhan == null) {
        return true;
      }
      return false;
    }

    flag = checkButton(pointExam1, listSignup, pointExam2);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header với tên môn
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF3B82F6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Text(
              nameSubject,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Thông tin chi tiết
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoRow(
                  Icons.people,
                  'Giám thị',
                  '${lecture1} & ${lecture2}',
                ),
                SizedBox(height: 12),
                _buildInfoRow(Icons.calendar_today, 'Ngày thi', date),
                SizedBox(height: 12),
                _buildInfoRow(
                  Icons.access_time,
                  'Bắt đầu',
                  '${date} | ${distanceTime} phút',
                ),
                SizedBox(height: 12),
                _buildInfoRow(Icons.room, 'Phòng', room),
                SizedBox(height: 12),
                _buildInfoRow(
                  Icons.add_circle,
                  'Lần thi',
                  timeExams.toString(),
                ),
                SizedBox(height: 12),
                _buildInfoRow(
                  Icons.check_circle,
                  'Điểm lần 1',
                  pointExam1.toString() ?? 'Chưa có',
                ),
                SizedBox(height: 16),

                // Nút đăng ký
                flag
                    ? Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF10B981),
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Đăng ký thi lần hai',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFDC3C22),
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Bạn đã đăng ký thi môn học này',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Color(0xFF3B82F6)),
        SizedBox(width: 12),
        Expanded(
          child: Row(
            children: [
              Text(
                '$label: ',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

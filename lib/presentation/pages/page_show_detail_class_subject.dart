import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/class_subject_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/exam_second_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_class_subject_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_exam_second_bloc.dart';
import 'package:portal_ckc/bloc/event/class_subject_event.dart';
import 'package:portal_ckc/bloc/event/exam_second_event.dart';
import 'package:portal_ckc/bloc/event/payment_class_subject_event.dart';
import 'package:portal_ckc/bloc/event/payment_exam_second.dart';
import 'package:portal_ckc/bloc/state/class_subject_state.dart';
import 'package:portal_ckc/bloc/state/exam_second_state.dart';
import 'package:portal_ckc/bloc/state/payment_class_subject.dart';
import 'package:portal_ckc/bloc/state/payment_exam_second_state.dart';
import 'package:portal_ckc/presentation/pages/page_detail_study_fee.dart';
import 'package:portal_ckc/presentation/sections/empty_section.dart';
import 'package:url_launcher/url_launcher.dart';

class PageShowDetailClassSubject extends StatefulWidget {
  @override
  State<PageShowDetailClassSubject> createState() => DetailClassSubject();
}

class DetailClassSubject extends State<PageShowDetailClassSubject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E3A8A),
      appBar: AppBar(
        backgroundColor: Color(0xFF3B82F6),
        title: Text(
          'Danh sách các lớp học phần đang mở ',
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
      body: BlocConsumer<ClassSubjectBloc, ClassSubjectState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ClassSubjectStateLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is ClassSubjectStateLoaded) {
            final subjects = state.classSubject;
            if (subjects.dsThoiKhoaBieuDauTien!.isEmpty ||
                subjects.lopHocPhanDangMo!.isEmpty) {
              return EmptySection(message: "Không có lớp học phần nào được mở");
            }
            return Container(
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: subjects.lopHocPhanDangMo!.length,
                itemBuilder: (context, index) {
                  final subject = subjects.lopHocPhanDangMo;
                  if (subject == null) {
                    return SizedBox.shrink();
                  }
                  if ((subjects.checkDKHG == false) &&
                      (int.parse(
                            subjects.lopHocPhanDangMo?[index].trangThai ?? "0",
                          ) ==
                          1)) {
                    return ExamCard(
                      nameSubject: subject[index]?.tenHocPhan ?? '',
                      flag: true,
                      lecture1: subject[index]?.giangVien?.hoSo?.hoTen ?? '',
                      quanlity: subject[index].gioiHanDangKy ?? "0",
                      date: subject[index]?.thoiKhoaBieu?[index].ngay ?? '',
                      room:
                          subject[index]?.thoiKhoaBieu?[index].phong?.ten ?? '',
                      idClass:
                          subject[index]?.thoiKhoaBieu?[index].idLopHocPhan ??
                          0,
                      idSubject: subjects.monHoc?.id ?? 0,
                      onRegister: () {
                        setState(() {
                          context.read<PaymentClassSubjectBloc>().add(
                            RequestPaymentClassSubjectEvent(
                              id_lop_hoc:
                                  subject[index]
                                      ?.thoiKhoaBieu?[index]
                                      .idLopHocPhan ??
                                  0,
                              id_mon_hoc: subjects.monHoc?.id ?? 0,
                            ),
                          );
                        });
                        _showPaymentDialog(
                          context,
                          subject[index]?.tenHocPhan ?? '',
                          subject[index]?.lop?.tenLop ?? '',
                        );
                      },
                      className: subject[index]?.lop?.tenLop ?? '',
                      beginLesson: int.parse(
                        subject[index].thoiKhoaBieu?[index].tietBatDau ?? "0",
                      ),
                      endLesson: int.parse(
                        subject[index]?.thoiKhoaBieu?[index].tietKetThuc ?? "0",
                      ),
                    );
                  } else {
                    return ExamCard(
                      nameSubject: subject[index]?.tenHocPhan ?? '',
                      flag: false,
                      lecture1: subject[index]?.giangVien?.hoSo?.hoTen ?? '',
                      date: subject[index]?.thoiKhoaBieu?[index].ngay ?? '',
                      quanlity: subject[index].gioiHanDangKy ?? "0",
                      room:
                          subject[index]?.thoiKhoaBieu?[index].phong?.ten ?? '',
                      idClass:
                          subject[index]?.thoiKhoaBieu?[index].idLopHocPhan ??
                          0,
                      idSubject: subjects.monHoc?.id ?? 0,
                      onRegister: () {},
                      className: subject[index]?.lop?.tenLop ?? '',
                      beginLesson: int.parse(
                        subject[index]?.thoiKhoaBieu?[index].tietBatDau ?? "0",
                      ),
                      endLesson: int.parse(
                        subject[index]?.thoiKhoaBieu?[index].tietKetThuc ?? "0",
                      ),
                    );
                  }
                },
              ),
            );
          } else if (state is ClassSubjectStateError) {
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
    String className,
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
          content:
              BlocBuilder<PaymentClassSubjectBloc, PaymentClassSubjectState>(
                builder: (context, state) {
                  if (state is PaymentClassSubjectStateLoading ||
                      state is PaymentClassSubjectStateInitial) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  } else if (state is PaymentClassSubjectStateLoaded) {
                    String url = state.url;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Bạn muốn đăng ký môn học:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        // Course info card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blue.shade100,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.school,
                                color: Colors.blue.shade600,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Môn: ${nameSubject} tại lớp ${className}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _processVNPayPayment(url);
                              print(url);
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
                  } else if (state is PaymentClassSubjectStateError) {
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
  final bool flag;
  final String nameSubject;
  final int idClass;
  final int idSubject;
  final String lecture1;
  final String className;
  final String date;
  final String quanlity;
  final String room;
  final int beginLesson;
  final int endLesson;
  final VoidCallback onRegister;

  const ExamCard({
    Key? key,
    required this.nameSubject,
    required this.idClass,
    required this.idSubject,
    required this.flag,
    required this.lecture1,
    required this.className,
    required this.quanlity,
    required this.date,
    required this.room,
    required this.beginLesson,
    required this.endLesson,
    required this.onRegister,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              'Môn: ${nameSubject} - Lớp ${className}',
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
                _buildInfoRow(Icons.people, 'Giảng Viên', '${lecture1}'),
                SizedBox(height: 12),
                _buildInfoRow(Icons.calendar_today, 'Ngày bắt đầu:', '${date}'),
                SizedBox(height: 12),
                _buildInfoRow(
                  Icons.access_time,
                  'Số lượng đăng ký:',
                  '${quanlity}',
                ),
                SizedBox(height: 12),
                _buildInfoRow(Icons.room, 'Phòng', room),
                SizedBox(height: 12),
                _buildInfoRow(
                  Icons.add_circle,
                  'Từ tiết: ',
                  '${beginLesson} - ${endLesson}',
                ),

                SizedBox(height: 16),

                // Nút đăng ký
                _checkStatusPayTuition(onRegister, flag),
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

  Widget _checkStatusPayTuition(Function onRegister, bool flag) {
    return flag
        ? Container(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onRegister(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF10B981),
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Đăng ký học ghép',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : SizedBox.shrink();
  }
}

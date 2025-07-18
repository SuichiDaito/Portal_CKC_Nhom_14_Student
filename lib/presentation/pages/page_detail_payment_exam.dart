import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/exam_second_model.dart';
import 'package:portal_ckc/bloc/bloc_event_state/class_subject_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/exam_second_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/class_subject_event.dart';
import 'package:portal_ckc/bloc/event/exam_second_event.dart';
import 'package:portal_ckc/bloc/event/payment_event.dart';
import 'package:portal_ckc/bloc/state/class_subject_state.dart';
import 'package:portal_ckc/bloc/state/exam_second_state.dart';
import 'package:portal_ckc/bloc/state/payment_state.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/constant/token.dart';
import 'package:portal_ckc/presentation/sections/card/student_card_info.dart';
import 'package:portal_ckc/presentation/sections/dialogs/snack_bar_scaffold.dart';

class PaymentDetailExamStudent extends StatefulWidget {
  final int idExam;
  final DangKyHocGhepThiLai checkDKHG;
  final String room;
  final String nameSubject;

  PaymentDetailExamStudent({
    super.key,
    required this.nameSubject,
    required this.checkDKHG,
    required this.idExam,
    required this.room,
  });

  State<PaymentDetailExamStudent> createState() => DetailScreen();
}

class DetailScreen extends State<PaymentDetailExamStudent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExamSecondBloc>().add(FetchExamSecondEvent());
  }

  @override
  Widget build(BuildContext context) {
    bool? flag;
    return Scaffold(
      backgroundColor: const Color(0xFF1E88E5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/apps'),
        ),
        title: Text(
          'Chi tiết thanh toán',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ExamSecondBloc, ExamSecondState>(
        listener: (context, state) {
          if (state is ExamSecondStateLoaded) {
            final subjects = state.exams;
            for (var item in subjects) {
              if (item.id == widget.idExam) {
                if (item.lopHocPhan?.dangKyHocGhepThiLai?.idLopHocPhan !=
                    null) {
                  flag = true;
                  break;
                }
              } else {
                flag = false;
              }
            }
          }
        },
        builder: (context, state) {
          if (state is ExamSecondStateLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is ExamSecondStateLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Card hiển thị thông tin
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tiêu đề
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF1E88E5,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.receipt_long,
                                      size: 40,
                                      color: const Color(0xFF1E88E5),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Thông tin thanh toán',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2E3A59),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Thông tin chi tiết
                            BlocBuilder<StudentBloc, StudentState>(
                              builder: (context, state) {
                                if (state is StudentInitial &&
                                    state is StudentLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                  );
                                } else if (state is StudentLoaded) {
                                  return Column(
                                    children: [
                                      _buildDetailRow(
                                        'Họ và tên: ',
                                        "${state.student.hoSo.hoTen}",
                                      ),
                                      _buildDetailRow(
                                        'MSSV',
                                        "${state.student.maSv}",
                                      ),
                                    ],
                                  );
                                } else if (state is StudentError) {
                                  return Center(child: Text(state.message));
                                }
                                return Center(child: Text('NOT FOUND | 404'));
                              },
                            ),
                            _buildDetailRow(
                              'Tên môn thi',
                              "${widget.nameSubject}",
                            ),
                            _buildDetailRow('Lần thi', "2"),
                            _buildDetailRow('Phòng thi', "${widget.room}"),
                            _buildDetailRow(
                              'Thời gian thanh toán',
                              '${_formatDate(DateTime.now())}',
                            ),

                            const SizedBox(height: 16),
                            const Divider(
                              thickness: 1,
                              color: Color(0xFFE0E0E0),
                            ),
                            const SizedBox(height: 16),

                            // Tổng tiền
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF1E88E5,
                                ).withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Tổng tiền:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2E3A59),
                                    ),
                                  ),
                                  Text(
                                    '${formatCurrency('50000')}',
                                    // _formatCurrency(paymentDetail.tongTien),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E88E5),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Trạng thái thanh toán
                            _buildStatusRow(flag ?? false),

                            const SizedBox(height: 8),

                            // Thông tin thêm
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Ngày tạo: ${_formatDate(DateTime.now())}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Nút kiểm tra thanh toán
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ExamSecondBloc>().add(
                          FetchExamSecondEvent(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1E88E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Kiểm tra thanh toán',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2E3A59),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(bool flag) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    if (flag) {
      statusColor = Colors.green;
      statusText = 'Đã thanh toán';
      statusIcon = Icons.pending;
    } else {
      statusColor = Colors.orange;
      statusText = 'Chưa thanh toán';
      statusIcon = Icons.check_circle;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              'Trạng thái',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(statusIcon, color: Colors.white, size: 16),
                const SizedBox(width: 6),
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(String amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(double.parse(amount));
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String _formatNienKhoa(DateTime ngayBatDau) {
    int year = ngayBatDau.year;
    return 'Niên khóa $year-${year + 1}';
  }

  String formatCurrency(String amount) {
    final format = int.parse(amount);
    final formatter = NumberFormat('#,###');
    return formatter.format(format);
  }
}

// Model classes

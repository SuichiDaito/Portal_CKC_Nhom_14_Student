import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_fee_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/payment_event.dart';
import 'package:portal_ckc/bloc/event/payment_fee_event.dart';
import 'package:portal_ckc/bloc/state/payment_fee_request_state.dart';
import 'package:portal_ckc/bloc/state/payment_state.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/presentation/pages/page_detail_study_fee.dart';
import 'package:portal_ckc/presentation/sections/card/student_card_info.dart';
import 'package:portal_ckc/presentation/sections/empty_section.dart';
import 'package:portal_ckc/presentation/sections/student_info_section.dart';
import 'package:url_launcher/url_launcher.dart';

class TuitionFeeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PaymentScreen();
}

class PaymentScreen extends State<StatefulWidget> {
  var id = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PaymentBloc>().add(FetchPaymentEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Đóng học phí',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            if (state is PaymentStateLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            } else if (state is PaymentStateLoaded) {
              final student = state.students;
              final listStudent = student.hocPhi;
              if (listStudent!.isEmpty) {
                return EmptySection(message: "Sinh viên không có nợ học phí ");
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StudentCardInfo(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: Text(
                      'Thông tin học phí',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listStudent!.length,
                      itemBuilder: (context, index) {
                        return TuitionFeeCard(
                          id_order: student?.hocPhi?[index].id ?? 0,
                          id_status: student?.hocPhi?[index].trangThai ?? 0,
                          id_student: student?.hocPhi?[index].idSinhVien ?? 0,
                          semester:
                              student?.hocPhi?[index].hocKy?.tenHocKy ?? '',
                          amount:
                              '${formatCurrencyString('${student?.hocPhi?[index].tongTien}')} VNĐ' ??
                              '',
                          startDate:
                              '${student?.hocPhi?[index].hocKy?.ngayBatDau}' ??
                              '',
                          endDate:
                              '${student?.hocPhi?[index].hocKy?.ngayKetThuc}' ??
                              '',
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is PaymentStateError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('NOT FOUND | 404'));
          },
        ),
      ),
    );
  }
}

class TuitionFeeCard extends StatelessWidget {
  final String semester;
  final String amount;
  final String startDate;
  final String endDate;
  final int id_order;
  final int id_status;
  final int id_student;
  bool isPaid = false;

  TuitionFeeCard({
    Key? key,
    required this.semester,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.id_order,
    required this.id_status,
    required this.id_student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.blue));
        } else if (state is StudentLoaded) {
          final student = state.student;
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.school,
                          color: Colors.blue[600],
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thông tin học phí',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              semester,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildInfoRow('Số tiền:', amount),
                  SizedBox(height: 8),
                  _buildInfoRow('Ngày bắt đầu:', FormatterDate(startDate)),
                  SizedBox(height: 8),
                  _buildInfoRow('Ngày kết thúc:', FormatterDate(endDate)),
                  SizedBox(height: 16),
                  Column(
                    children: _buildPaymentStatusWidgets(
                      context,
                      id_status,
                      startDate,
                      endDate,
                      id_order,
                      semester,
                      id_student,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is StudentError) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text('NOT FOUND | 404'));
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _launchPaymentUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Không thể mở URL: $url');
    }
  }
}

class PaymentOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const PaymentOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

int checkInput(int status, String startStr, String endStr) {
  final now = DateTime.now();
  final start = DateTime.parse(startStr);
  final end = DateTime.parse(endStr);

  if (status == 1) {
    // đã đóng rồi
    return 1;
  } else if (status == 0) {
    // chưa đóng
    // kiểm tra hạn đóng
    final isStillOpen = now.isAfter(start) && now.isBefore(end);

    if (isStillOpen) {
      // còn hạn đóng => hiển thị nút thanh toán.
      return 2;
    } else {
      return 3; // không còn hạn đóng => hiển thị vui lòng liên hệ kế toán
    }
  }
  return 0;
}

String formatCurrencyString(String amountStr) {
  // Parse thành double để xử lý cả trường hợp có phần thập phân
  final amount = double.tryParse(amountStr) ?? 0;

  // Lấy phần nguyên
  final intAmount = amount.toInt();

  // Format phần nguyên
  final formatter = NumberFormat('#,###');
  return formatter.format(intAmount);
}

void _launchPaymentUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    print('Không thể mở URL: $url');
  }
}

List<Widget> _buildPaymentStatusWidgets(
  BuildContext context,
  int id_status,
  String startDate,
  String endDate,
  int id_order,
  String semester,
  int id_student,
) {
  final status = checkInput(id_status, startDate, endDate);
  if (status == 1) {
    return [
      SizedBox(height: 16),
      Text(
        "Đã đóng học phí",
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ];
  } else if (status == 2) {
    return [
      SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            context.read<RequestPaymenFee>().add(
              RequestPaymentFee(32, 7700000),
            );
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => Container(
                padding: EdgeInsets.all(20),
                child: BlocBuilder<RequestPaymenFee, PaymentFeeRequestState>(
                  builder: (context, state) {
                    if (state is PaymentFeeRequestStateLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      );
                    } else if (state is PaymentFeeRequestStateLoaded) {
                      final url = state.url;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Chọn phương thức thanh toán',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          PaymentOption(
                            icon: Icons.credit_card,
                            title: 'VNPay',
                            subtitle: 'Thanh toán qua VNPay',
                            color: Colors.blue,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentDetailScreen(
                                    id_order: id_order,
                                    id_status: id_status,
                                    semester: semester,
                                    idStudent: id_student,
                                  ),
                                ),
                              );
                              _launchPaymentUrl(url);
                            },
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Hủy'),
                          ),
                        ],
                      );
                    } else if (state is PaymentFeeRequestStateError) {
                      return Center(child: Text(state.message));
                    }
                    return Center(child: Text('Thanh toán không thành công'));
                  },
                ),
              ),
            );
          },
          icon: Icon(Icons.payment, size: 20),
          label: Text(
            'Thanh toán học phí',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    ];
  } else if (status == 3) {
    return [
      SizedBox(height: 16),
      Text(
        "Thanh toán quá hạn. Vui lòng liên hệ phòng kế toán để được hỗ trợ",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ];
  }
  return [];
}

String FormatterDate(String? dateStr) {
  DateTime date = DateTime.parse(dateStr ?? "");

  // Format lại để chỉ hiển thị yyyy-MM-dd
  String formatted = DateFormat('dd-MM-yyyy').format(date);
  return formatted;
}

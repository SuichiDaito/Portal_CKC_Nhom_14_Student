import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/payment_event.dart';
import 'package:portal_ckc/bloc/state/payment_state.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/constant/token.dart';
import 'package:portal_ckc/presentation/sections/card/student_card_info.dart';
import 'package:portal_ckc/presentation/sections/dialogs/snack_bar_scaffold.dart';

class PaymentDetailScreen extends StatefulWidget {
  final int id_order;
  final int id_status;
  final String semester;
  final int idStudent;

  const PaymentDetailScreen({
    super.key,
    required this.id_order,
    required this.id_status,
    required this.semester,
    required this.idStudent,
  });

  State<PaymentDetailScreen> createState() => DetailScreen();
}

class DetailScreen extends State<PaymentDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PaymentBloc>().add(FetchPaymentEvent());
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
          onPressed: () => Navigator.of(context).pop(),
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
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentStateLoaded) {
            final students = state.students.hocPhi;
            if (students != null) {
              for (var item in students) {
                if (item.id == widget.id_order &&
                    (item.trangThai == 1 || item.ngayDong == null)) {
                  flag = false;
                  // SnackBarScaffold.showToast(
                  //   'Bạn thanh toán thất bại',
                  //   true,
                  //   context,
                  // );
                } else if (item.id == widget.id_order &&
                    (item.trangThai == 0 || item.ngayDong == null)) {
                  flag = false;
                  // SnackBarScaffold.showToast(
                  //   'Bạn thanh toán thất bại',
                  //   true,
                  //   context,
                  // );
                } else {
                  flag = true;
                  // SnackBarScaffold.showToast(
                  //   'Bạn thanh toán thành công',
                  //   false,
                  //   context,
                  // );
                }
              }
            }
          }
        },
        builder: (context, state) {
          if (state is PaymentStateLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is PaymentStateLoaded) {
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
                            _buildDetailRow(
                              'Mã thanh toán',
                              "HD000${widget.id_order}",
                            ),
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
                                  if (state.student.id == widget.idStudent) {
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
                                        _buildDetailRow(
                                          'Lớp',
                                          "${state.student.danhSachSinhVien.last.lop.tenLop}",
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                } else if (state is StudentError) {
                                  return Center(child: Text(state.message));
                                }
                                return Center(child: Text('NOT FOUND | 404'));
                              },
                            ),
                            _buildDetailRow('Học kỳ', "${widget.semester}"),
                            _buildDetailRow(
                              'Thời gian',
                              _formatHocKyPeriod(
                                DateTime.now(),
                                DateTime.now(),
                              ),
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
                                    '${formatCurrency('7700000')}',
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
                                      'Ngày tạo: 09/10/2009',
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
                        context.read<PaymentBloc>().add(FetchPaymentEvent());
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
          } else if (state is PaymentStateError) {
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
      statusColor = Colors.orange;
      statusText = 'Chưa thanh toán';
      statusIcon = Icons.pending;
    } else {
      statusColor = Colors.green;
      statusText = 'Đã thanh toán';
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

  String _formatHocKyPeriod(DateTime batDau, DateTime ketThuc) {
    return '${_formatDate(batDau)} - ${_formatDate(ketThuc)}';
  }

  String formatCurrency(String amount) {
    final format = int.parse(amount);
    final formatter = NumberFormat('#,###');
    return formatter.format(format);
  }
}

// Model classes

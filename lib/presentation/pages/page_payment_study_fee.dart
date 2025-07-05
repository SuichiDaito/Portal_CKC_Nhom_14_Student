import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/payment_event.dart';
import 'package:portal_ckc/bloc/state/payment_state.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:url_launcher/url_launcher.dart';

class TuitionFeeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PaymentScreen();
}

class PaymentScreen extends State<StatefulWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PaymentBloc>().add(FetchPaymentEvent(lop: 7));
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
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentStateLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is PaymentStateLoaded) {
            final student = state.students;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      TuitionFeeCard(
                        studentName: '${student!.sinhVien!.maSv}',
                        className:
                            '${student!.sinhVien!.danhSachSinhVien!.last.lop!.tenLop}',
                        semester:
                            '${student!.hocPhi!.hocKy!.tenHocKy} - Năm học 2025',
                        amount: '${student!.hocPhi!.tongTien} VNĐ',
                        startDate: '${student!.hocPhi!.hocKy!.ngayBatDau}',
                        endDate: '${student!.hocPhi!.hocKy!.ngayKetThuc}',
                        isPaid: false,
                      ),
                    ],
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
    );
  }
}

class TuitionFeeCard extends StatelessWidget {
  final String studentName;
  final String className;
  final String semester;
  final String amount;
  final String startDate;
  final String endDate;
  final bool isPaid;

  const TuitionFeeCard({
    Key? key,
    required this.studentName,
    required this.className,
    required this.semester,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.isPaid,
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
                  _buildInfoRow('Họ và tên:', student.hoSo!.hoTen),

                  SizedBox(height: 8),
                  _buildInfoRow('Lớp:', className),
                  SizedBox(height: 8),
                  _buildInfoRow('Số tiền:', amount),
                  SizedBox(height: 8),
                  _buildInfoRow('Ngày bắt đầu:', startDate),
                  SizedBox(height: 8),
                  _buildInfoRow('Ngày kết thúc:', endDate),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trạng thái: ',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isPaid ? Colors.green[100] : Colors.red[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          isPaid ? 'Đã thanh toán' : 'Chưa thanh toán',
                          style: TextStyle(
                            fontSize: 12,
                            color: isPaid ? Colors.green[700] : Colors.red[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!isPaid) ...[
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _showPaymentOptions(context),
                        icon: Icon(Icons.payment, size: 20),
                        label: Text(
                          'Thanh toán học phí',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
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
                  ],
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

  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chọn phương thức thanh toán',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            PaymentOption(
              icon: Icons.credit_card,
              title: 'VNPay',
              subtitle: 'Thanh toán qua VNPay',
              color: Colors.blue,
              onTap: () {
                Navigator.pop(context);
                _launchPaymentUrl(
                  'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Amount=770000000&vnp_Command=pay&vnp_CreateDate=20250704094804&vnp_CurrCode=VND&vnp_IpAddr=192.168.32.107&vnp_Locale=vn&vnp_OrderInfo=%7B%22message%22%3A%22Thanh+to%5Cu00e1n+h%5Cu1ecdc+ph%5Cu00ed%22%2C%22type%22%3A%22hoc_phi%22%7D&vnp_OrderType=billpayment&vnp_ReturnUrl=http%3A%2F%2F192.168.32.107%3A8000%2Fapi%2Fsinhvien%2Fvnpay-return&vnp_TmnCode=U4PG4M2O&vnp_TxnRef=2300&vnp_Version=2.1.0&vnp_SecureHash=de15dd41bb7953296fc2bee8611bcf104de08dc933ce0293b6d02a6e57f413b6607c952ed873afa75e63e509407cbc0bb483296e128678d87f731c9a900ee249',
                );
              },
            ),

            SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Hủy'),
            ),
          ],
        ),
      ),
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

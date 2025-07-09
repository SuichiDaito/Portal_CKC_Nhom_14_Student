import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExamSchedulePage extends StatefulWidget {
  @override
  _ExamSchedulePageState createState() => _ExamSchedulePageState();
}

class _ExamSchedulePageState extends State<ExamSchedulePage> {
  List<ExamSubject> examSubjects = [
    ExamSubject(
      id: 1,
      name: "Nhập môn lập trình",
      date: "2025-07-29",
      startTime: "12:00:50",
      duration: "90 phút",
      room: "F7.1",
      supervisor1: "Phạm Minh Đức",
      supervisor2: "Lê Văn Khánh Thinh",
      attempt: 2,
      score: null,
      status: "Chưa có",
    ),
    ExamSubject(
      id: 2,
      name: "Pháp luật",
      date: "2025-07-29",
      startTime: "12:00:50",
      duration: "90 phút",
      room: "F7.1",
      supervisor1: "Phạm Minh Đức",
      supervisor2: "Lê Văn Khánh Thinh",
      attempt: 2,
      score: null,
      status: "Chưa có",
    ),
    ExamSubject(
      id: 3,
      name: "Toán cao cấp",
      date: "2025-08-05",
      startTime: "14:30:00",
      duration: "120 phút",
      room: "A2.3",
      supervisor1: "Nguyễn Thị Lan",
      supervisor2: "Trần Văn Minh",
      attempt: 1,
      score: 8.5,
      status: "Đã có",
    ),
    ExamSubject(
      id: 4,
      name: "Tiếng Anh",
      date: "2025-08-10",
      startTime: "08:00:00",
      duration: "90 phút",
      room: "B1.5",
      supervisor1: "Smith John",
      supervisor2: "Lê Thị Hoa",
      attempt: 1,
      score: null,
      status: "Chưa có",
    ),
  ];

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
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: examSubjects.length,
          itemBuilder: (context, index) {
            return ExamCard(
              examSubject: examSubjects[index],
              onRegister: () =>
                  _showPaymentDialog(context, examSubjects[index]),
            );
          },
        ),
      ),
    );
  }

  void _showPaymentDialog(BuildContext context, ExamSubject exam) {
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Môn thi: ${exam.name}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Text(
                'Phí thi: 150.000 VNĐ',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _processVNPayPayment(exam);
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

  void _processVNPayPayment(ExamSubject exam) async {
    // Tạo URL thanh toán VNPay (demo)
    String vnpayUrl =
        'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?'
        'vnp_Version=2.1.0&'
        'vnp_Command=pay&'
        'vnp_TmnCode=DEMO&'
        'vnp_Amount=15000000&'
        'vnp_CurrCode=VND&'
        'vnp_TxnRef=exam_${exam.id}_${DateTime.now().millisecondsSinceEpoch}&'
        'vnp_OrderInfo=Thanh%20toan%20phi%20thi%20${exam.name}&'
        'vnp_Locale=vn&'
        'vnp_ReturnUrl=https://yourapp.com/return';

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
  final ExamSubject examSubject;
  final VoidCallback onRegister;

  const ExamCard({
    Key? key,
    required this.examSubject,
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
              examSubject.name,
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
                  '${examSubject.supervisor1} & ${examSubject.supervisor2}',
                ),
                SizedBox(height: 12),
                _buildInfoRow(
                  Icons.calendar_today,
                  'Ngày thi',
                  examSubject.date,
                ),
                SizedBox(height: 12),
                _buildInfoRow(
                  Icons.access_time,
                  'Bắt đầu',
                  '${examSubject.startTime} | ${examSubject.duration}',
                ),
                SizedBox(height: 12),
                _buildInfoRow(Icons.room, 'Phòng', examSubject.room),
                SizedBox(height: 12),
                _buildInfoRow(
                  Icons.add_circle,
                  'Lần thi',
                  examSubject.attempt.toString(),
                ),
                SizedBox(height: 12),
                _buildInfoRow(
                  Icons.check_circle,
                  'Điểm lần 1',
                  examSubject.score?.toString() ?? examSubject.status,
                ),
                SizedBox(height: 16),

                // Nút đăng ký
                Container(
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
                      'Đăng ký thi',
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

class ExamSubject {
  final int id;
  final String name;
  final String date;
  final String startTime;
  final String duration;
  final String room;
  final String supervisor1;
  final String supervisor2;
  final int attempt;
  final double? score;
  final String status;

  ExamSubject({
    required this.id,
    required this.name,
    required this.date,
    required this.startTime,
    required this.duration,
    required this.room,
    required this.supervisor1,
    required this.supervisor2,
    required this.attempt,
    this.score,
    required this.status,
  });
}

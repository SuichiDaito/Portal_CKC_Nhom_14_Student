import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/student_info_section.dart';

class StudentCardInfo extends StatefulWidget {
  StudentCardInfo({super.key});
  @override
  State<StudentCardInfo> createState() => CardStudent();
}

class CardStudent extends State<StudentCardInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[600]!, Colors.blue[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'Thông tin sinh viên',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          StudentInfoSection(label: 'Họ tên:', value: 'Nguyễn Văn An'),
          SizedBox(height: 12),
          StudentInfoSection(label: 'Ngày sinh:', value: '15/03/2003'),
          SizedBox(height: 12),
          StudentInfoSection(label: 'Mã sinh viên:', value: '56374564'),
          SizedBox(height: 12),
          StudentInfoSection(label: 'Lớp', value: 'Lập trình di động - Lớp 01'),
          SizedBox(height: 12),
          StudentInfoSection(label: 'Giới tính', value: 'Nam'),
        ],
      ),
    );
  }
}

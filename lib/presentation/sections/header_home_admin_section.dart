import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderHomeAdminSection extends StatefulWidget {
  final String nameLogin;
  const HeaderHomeAdminSection({super.key, required this.nameLogin});

  @override
  State<HeaderHomeAdminSection> createState() => _HeaderHomeAdminSection();
}

class _HeaderHomeAdminSection extends State<HeaderHomeAdminSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 8, // khoảng cách giữa các dòng nếu bị xuống hàng
        children: [
          /// Phần văn bản
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width - 100, // chừa chỗ cho icon
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Xin chào, ${widget.nameLogin}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Chào mừng đến với hệ thống thông tin sinh viên',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

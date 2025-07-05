import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';

class AccountInfoSection extends StatelessWidget {
  const AccountInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentBloc, StudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is StudentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is StudentLoaded) {
          final student = state.student;
          return Column(
            children: [
              // Header section with user info
              Container(
                width: double.infinity,
                color: Colors.blue.shade50,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.school, color: Colors.white, size: 30),
                    ),
                    SizedBox(width: 16),
                    // User info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thông tin chi tiết tài khoản sinh viên',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content section
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    // Student information details
                    _buildInfoItem('Mã sinh viên: ${student.maSv}'),
                    _buildInfoItem('Họ và tên: ${student.hoSo!.hoTen}'),
                    _buildInfoItem(
                      'Lớp: ${student.danhSachSinhVien.last.lop.tenLop}',
                    ),
                    _buildInfoItem(
                      'Chức vụ: ${student.danhSachSinhVien.last.chucVu}',
                    ),
                    _buildInfoItem('Ngày sinh: ${student.hoSo!.ngaySinh}'),

                    SizedBox(height: 20),

                    // Additional note
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.blue.shade200,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Lưu ý: Vui lòng bảo mật thông tin tài khoản và liên hệ Phòng Đào tạo nếu có bất kỳ thắc mắc nào.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade800,
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text('NOT FOUND | 404'));
        }
      },
    );
  }

  // Helper method to build info items
  Widget _buildInfoItem(String text) {
    // Tách label và value từ text
    List<String> parts = text.split(': ');
    String label = parts[0].replaceAll('• ', '');
    String value = parts.length > 1 ? parts[1] : '';

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Label
              Expanded(
                flex: 2,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Value
              Expanded(
                flex: 3,
                child: Text(
                  value == "1"
                      ? 'Thư ký'
                      : value == "0"
                      ? 'Sinh Viên'
                      : value,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Divider
        Divider(color: Colors.grey.shade300, thickness: 0.5, height: 1),
      ],
    );
  }
}

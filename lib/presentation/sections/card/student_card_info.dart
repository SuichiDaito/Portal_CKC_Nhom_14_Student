import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/presentation/sections/student_info_section.dart';

class StudentCardInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is StudentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is StudentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is StudentLoaded) {
          final student = state.student;
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
                StudentInfoSection(
                  label: 'Họ tên:',
                  value: student.hoSo!.hoTen,
                ),
                SizedBox(height: 12),
                StudentInfoSection(
                  label: 'Ngày sinh:',
                  value: student.hoSo!.ngaySinh,
                ),
                SizedBox(height: 12),
                StudentInfoSection(label: 'Mã sinh viên:', value: student.maSv),
                SizedBox(height: 12),
                StudentInfoSection(
                  label: 'Lớp',
                  value: student.danhSachSinhVien.last.lop.tenLop,
                ),
                SizedBox(height: 12),
                StudentInfoSection(
                  label: 'Giới tính',
                  value: student.hoSo!.gioiTinh,
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text('Không có dữ liệu sinh viên'));
        }
      },
    );
  }
}

// //student.danhSachSinhVien.last.idLop!.isEven
//                       ? student.danhSachSinhVien.last.idLop!.isOdd
//                       : ,

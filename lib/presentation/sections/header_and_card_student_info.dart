import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/presentation/sections/header_home_admin_section.dart';
import 'package:portal_ckc/presentation/sections/user_profile_card_home_admin.dart';

class HeaderAndCardStudentInfo extends StatefulWidget {
  HeaderAndCardStudentInfo({super.key});
  @override
  State<HeaderAndCardStudentInfo> createState() => CardStudentInfo();
}

class CardStudentInfo extends State<HeaderAndCardStudentInfo> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.blue));
        } else if (state is StudentLoaded) {
          final student = state.student;
          return Column(
            children: [
              SizedBox(height: 20),
              HeaderHomeAdminSection(nameLogin: student.hoSo!.hoTen),
              SizedBox(height: 20),

              // User Profile Card
              UserProfileCardHomeAdmin(
                nameUser: student.hoSo!.hoTen,
                idStudent: student.maSv,
                email: student.hoSo!.email,
                classStudent: '${student.danhSachSinhVien.last!.lop.tenLop}',
              ),
            ],
          );
        } else if (state is StudentError) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text('NOT FOUND | 404'));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/student_event.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/presentation/pages/page_notification_detail_admin.dart';
import 'package:portal_ckc/presentation/sections/grid_app_home_admin.dart';
import 'package:portal_ckc/presentation/sections/header_home_admin_section.dart';
import 'package:portal_ckc/presentation/sections/notifications_home_admin.dart';
import 'package:portal_ckc/presentation/sections/user_profile_card_home_admin.dart';

class MainLayoutHomeAdminPage extends StatefulWidget {
  const MainLayoutHomeAdminPage({super.key});
  State<MainLayoutHomeAdminPage> createState() => _MainLayoutHomeAdminPage();
}

class _MainLayoutHomeAdminPage extends State<MainLayoutHomeAdminPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentBloc, StudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is StudentLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.blue));
        } else if (state is StudentError) {
          return Text(state.message);
        } else if (state is StudentLoaded) {
          final student = state.student;
          return SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  HeaderHomeAdminSection(nameLogin: student.hoSo!.hoTen),
                  SizedBox(height: 20),

                  // User Profile Card
                  UserProfileCardHomeAdmin(
                    nameUser: student.hoSo!.hoTen,
                    idStudent: student.maSv,
                    email: student.hoSo!.email,
                    classStudent: student.lop!.tenLop,
                  ),
                  SizedBox(height: 20),

                  // Function Grid
                  // GridAppHomeAdmin(),
                  SizedBox(height: 20),

                  // Latest Notifications Section
                  NotificationsHomeAdmin(
                    typeNotification: 'Thông báo khoa',
                    contentNotification: 'Thông báo mới nhất',
                    date: '24/06/2025',
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: Text('NOT FOUND | 404'));
        }
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/presentation/sections/dialogs/snack_bar_scaffold.dart';

class AppBarNavigationHomePage extends StatefulWidget {
  final Widget child;
  AppBarNavigationHomePage({super.key, required this.child});
  @override
  State<AppBarNavigationHomePage> createState() => _AppBarNavigationHomePage();
}

class _AppBarNavigationHomePage extends State<AppBarNavigationHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is StudentLoading) {
          SnackBarScaffold.showToast('Đăng nhập thành công!', false, context);
        }
      },
      builder: (context, state) {
        if (state is StudentLoaded) {
          final student = state.student;
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.grey[100],
            appBar: _buildAppBarHomePage(
              student.hoSo!.hoTen,
              student.danhSachSinhVien.last.lop.tenLop,
            ),
            body: widget.child,
          );
        } else if (state is StudentError) {
          return Text('Lỗi load data');
        } else {
          return Text('NOT FOUND');
        }
      },
    );
  }

  PreferredSizeWidget _buildAppBarHomePage(
    String? nameStudent,
    String? classStudent,
  ) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      toolbarHeight: 75,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.blue.shade600],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User info section
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      radius: 20,
                      child: Icon(Icons.person, color: Colors.white, size: 24),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameStudent ?? 'Không tìm thấy',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          classStudent ?? 'Không tìm thấy',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

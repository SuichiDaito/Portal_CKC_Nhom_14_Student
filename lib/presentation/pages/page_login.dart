import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/student_event.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/gen/assets.gen.dart';
import 'package:portal_ckc/main.dart';
import 'package:portal_ckc/presentation/sections/button/button_login.dart';
import 'package:portal_ckc/presentation/sections/dialogs/snack_bar_scaffold.dart';
import 'package:portal_ckc/presentation/sections/textfield/textfield_input_login.dart';
import 'package:portal_ckc/presentation/sections/textfield/textfield_password_login.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _studentAccountController = TextEditingController();
  final _studentAccountChangePasswordController = TextEditingController();
  final _studentPasswordController = TextEditingController();
  final _studentEmailController = TextEditingController();

  bool _isTeacherPasswordVisible = false;

  // Dropdown value cho quên mật khẩu
  String _selectedEmailType = 'Portal';
  final List<String> _emailTypes = ['Portal', 'Gmail'];

  // Biến để kiểm soát việc hiển thị form quên mật khẩu
  static bool _showForgotPasswordForm = false;

  @override
  void dispose() {
    _studentAccountController.dispose();
    _studentPasswordController.dispose();
    _studentEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildFormLogin();
  }

  Widget _buildFormLogin() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is StudentRequestChangePasswordSuccess) {
            SnackBarScaffold.showToast(
              '"Yêu cầu cấp mật khẩu thành công. Mật khẩu sẽ sớm được gửi qua Email của bạn.!',
              false,
              context,
            );
            _showForgotPasswordForm = false;
            Timer(Duration(seconds: 2), () {
              _studentAccountChangePasswordController.text = '';
              _selectedEmailType = 'Portal';
            });
          } else if (state is StudentRequestChangePasswordFail) {
            SnackBarScaffold.showToast(
              '"Yêu cầu cấp mật khẩu thất bại. Vui lòng thử lại!',
              false,
              context,
            );
          }

          if (state is StudentLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/home/admin');
              SnackBarScaffold.showToast(
                'Đăng nhập thành công!',
                false,
                context,
              );
            });
          } else if (state is StudentError) {
            SnackBarScaffold.showToast(
              'Đăng nhập không thành công!',
              true,
              context,
            );
          }
        },
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2196F3),
                  Color(0xFF1976D2),
                  Color(0xFF0D47A1),
                ],
              ),
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      // Header với logo và thông tin trường
                      _buildHeader(),
                      // Phần form đăng nhập
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, -2),
                              ),
                            ],
                          ),
                          child: _showForgotPasswordForm
                              ? _buildForgetPasswordForm()
                              : _buildStudentLoginForm(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Logo
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.logoPng.image(
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          // Tên trường
          Text(
            'TRƯỜNG CAO ĐẲNG KỸ THUẬT CAO THẮNG',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 10),

          // Mô tả
          Text(
            'Cổng thông tin nội bộ\nHệ thống quản lý đào tạo Trường Cao Thắng',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildForgetPasswordForm() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20,
          30,
          20,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Quên Mật Khẩu',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30),

            TextfieldInputLogin(
              controller: _studentAccountChangePasswordController,
              label: 'Tài khoản',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 16),

            // Dropdown cho loại email
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedEmailType,
                decoration: InputDecoration(
                  labelText: 'Loại Tài Khoản',
                  prefixIcon: Icon(Icons.domain, color: Color(0xFF1976D2)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                items: _emailTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedEmailType = newValue!;
                  });
                },
              ),
            ),

            SizedBox(height: 24),

            ButtonLogin(
              nameButton: 'Lấy lại mật khẩu',
              account: _studentAccountChangePasswordController.text.trim(),
              password: '',
              typeAccount: _selectedEmailType == 'Portal' ? 1 : 0,
            ),

            SizedBox(height: 12),

            TextButton(
              onPressed: () {
                setState(() {
                  _showForgotPasswordForm = false;
                });
              },
              child: Text(
                'Quay lại đăng nhập',
                style: TextStyle(color: Color(0xFF1976D2), fontSize: 16),
              ),
            ),

            // Thêm khoảng cách bottom
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentLoginForm() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20,
          30,
          20,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Đăng Nhập Sinh Viên',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30),

            TextfieldInputLogin(
              controller: _studentAccountController,
              label: 'Tài khoản',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 16),

            TextfieldPasswordLogin(
              controller: _studentPasswordController,
              label: 'Mật khẩu',
              isVisible: _isTeacherPasswordVisible,
              onToggleVisibility: () {
                setState(() {
                  _isTeacherPasswordVisible = !_isTeacherPasswordVisible;
                });
              },
            ),

            SizedBox(height: 24),
            ButtonLogin(
              nameButton: 'Đăng nhập sinh viên',
              account: _studentAccountController.text.trim(),
              password: _studentPasswordController.text.trim(),
              typeAccount: 0,
            ),

            SizedBox(height: 12),

            TextButton(
              onPressed: () {
                setState(() {
                  _showForgotPasswordForm = true;
                });
              },
              child: Text(
                'Quên mật khẩu?',
                style: TextStyle(color: Color(0xFF1976D2), fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

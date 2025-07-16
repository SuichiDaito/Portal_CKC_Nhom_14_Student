import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/logoutn_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/response_change_password.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/change_response_event.dart';
import 'package:portal_ckc/bloc/event/logount_event.dart';
import 'package:portal_ckc/bloc/event/student_event.dart';
import 'package:portal_ckc/bloc/state/student_logout.dart';
import 'package:portal_ckc/bloc/state/student_response_change_password.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/constant/token.dart';
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

  // Hàm xử lý đăng nhập nhanh
  void _handleLogin() {
    final account = _studentAccountController.text.trim();
    final password = _studentPasswordController.text.trim();

    // Có thể thêm validation đơn giản nếu cần
    if (account.isEmpty || password.isEmpty) {
      SnackBarScaffold.showToast(
        'Vui lòng nhập đầy đủ thông tin',
        true,
        context,
      );
      return;
    }

    // Gọi BLoC để đăng nhập
    context.read<StudentBloc>().add(
      StudentLoginEvent(ma_sv: account, password: password),
    );
  }

  // Hàm xử lý quên mật khẩu
  void _handleForgotPassword() {
    final account = _studentAccountChangePasswordController.text.trim();

    if (account.isEmpty) {
      SnackBarScaffold.showToast('Vui lòng nhập tài khoản', true, context);
      return;
    }

    context.read<ResponseChangePasswordBloc>().add(
      FetchResponseChangePassword(
        idStudent: account,
        typeAccount: _selectedEmailType == 'Portal' ? 1 : 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutBloc, StudentLogoutState>(
      listener: (BuildContext context, StudentLogoutState state) {
        if (state is StudentLogoutStateLoaded) {
          SnackBarScaffold.showToast('Đăng xuất thành công', false, context);
        }
      },
      builder: (BuildContext context, StudentLogoutState state) {
        return BlocConsumer<
          ResponseChangePasswordBloc,
          StudentResponseChangePasswordStateState
        >(
          listener: (context, state) {
            if (state is StudentRequestChangePasswordSuccess) {
              SnackBarScaffold.showToast(
                'Yêu cầu cấp mật khẩu thành công. Mật khẩu sẽ sớm được gửi qua Email của bạn!',
                false,
                context,
              );
              _showForgotPasswordForm = false;
              Timer(Duration(seconds: 2), () {
                _studentAccountChangePasswordController.clear();
                _selectedEmailType = 'Portal';
              });
            } else if (state is StudentRequestChangePasswordFail) {
              SnackBarScaffold.showToast(
                'Yêu cầu cấp mật khẩu thất bại. Vui lòng thử lại!',
                true,
                context,
              );
            }
          },
          builder: (context, state) {
            return _buildFormLogin();
          },
        );
      },
    );
  }

  Widget _buildFormLogin() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is StudentLoaded) {
            context.go('/home/admin');
            ConstraintToken.setPassword(_studentPasswordController.text);
            SnackBarScaffold.showToast('Đăng nhập thành công!', false, context);
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

            // TextField đơn giản không validation
            TextField(
              controller: _studentAccountChangePasswordController,
              decoration: InputDecoration(
                labelText: 'Tài khoản',
                prefixIcon: Icon(Icons.email, color: Color(0xFF1976D2)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF1976D2)),
                ),
              ),
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

            // Nút bấm nhanh
            ElevatedButton(
              onPressed: _handleForgotPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1976D2),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Lấy lại mật khẩu',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
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

            // TextField tài khoản đơn giản
            TextField(
              controller: _studentAccountController,
              decoration: InputDecoration(
                labelText: 'Tài khoản',
                prefixIcon: Icon(Icons.email, color: Color(0xFF1976D2)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF1976D2)),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 16),

            // TextField mật khẩu đơn giản
            TextField(
              controller: _studentPasswordController,
              obscureText: !_isTeacherPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                prefixIcon: Icon(Icons.lock, color: Color(0xFF1976D2)),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isTeacherPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(0xFF1976D2),
                  ),
                  onPressed: () {
                    setState(() {
                      _isTeacherPasswordVisible = !_isTeacherPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF1976D2)),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Nút đăng nhập nhanh
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1976D2),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Đăng nhập sinh viên',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
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

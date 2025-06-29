import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
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

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _studentAccountController = TextEditingController();
  final _studentPasswordController = TextEditingController();
  final _studentEmailController = TextEditingController();
  final _typeAccountController = TextEditingController();

  bool _isTeacherPasswordVisible = false;
  bool _isAdminPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _studentAccountController.dispose();
    _studentPasswordController.dispose();
    _studentEmailController.dispose();
    _typeAccountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildFormLogin();
  }

  Widget _buildFormLogin() {
    return Scaffold(
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is StudentLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/home/admin');
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
              child: Column(
                children: [
                  const DebugContextWidget(name: 'Main Login Screen'),
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
                      child: Column(
                        children: [
                          // Tab bar
                          _buildTabBar(),

                          // Tab content
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                _buildStudentLoginForm(),
                                _buildForgetPasswordForm(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFF1976D2),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 20),
                SizedBox(width: 8),
                Text('Sinh Viên'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.admin_panel_settings, size: 20),
                SizedBox(width: 8),
                Text('Lấy lại mật khẩu'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgetPasswordForm() {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30),

            TextfieldInputLogin(
              controller: _studentEmailController,
              label: 'Account',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 20),

            TextfieldPasswordLogin(
              controller: _typeAccountController,
              label: 'Mật khẩu',
              isVisible: _isTeacherPasswordVisible,
              onToggleVisibility: () {
                setState(() {
                  _isTeacherPasswordVisible = !_isTeacherPasswordVisible;
                });
              },
            ),

            SizedBox(height: 30),

            // ButtonLogin(
            //   nameButton: 'Lấy lại mật khẩu',
            //   // onPressed: () {
            //   //   // if (state is! StudentLoading) {
            //   //   //   // request information (account, password) api
            //   //   //   _handleResetPasswordLogin();
            //   //   //   Center(child: CircularProgressIndicator());
            //   //   // }
            //   // },
            // ),
            SizedBox(height: 15),

            TextButton(
              onPressed: () {
                // Xử lý quên mật khẩu
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

  Widget _buildStudentLoginForm() {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Đăng Nhập Sinh Viên',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30),

            TextfieldInputLogin(
              controller: _studentAccountController,
              label: 'Account',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 20),

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

            SizedBox(height: 30),
            ButtonLogin(
              nameButton: 'Đăng nhập sinh viên',
              account: _studentAccountController.text.trim(),
              password: _studentPasswordController.text.trim(),
            ),

            SizedBox(height: 15),

            TextButton(
              onPressed: () {
                // Xử lý quên mật khẩu
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

  // void _handleResetPasswordLogin() {
  //   String account = _studentEmailController.text.trim();
  //   String password = _typeAccountController.text.trim();

  //   if (account.isEmpty || password.isEmpty) {
  //     SnackBarScaffold.showToast(
  //       'Vui lòng nhập đầy đủ thông tin!',
  //       true,
  //       context,
  //     );
  //     return;
  //   }

  //   context.read<StudentBloc>().add(
  //     StudentLoginEvent(ma_sv: account, password: password),
  //   );
  // }
}

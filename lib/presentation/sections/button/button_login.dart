import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/student_event.dart';
import 'package:portal_ckc/constant/style_of_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portal_ckc/presentation/sections/dialogs/snack_bar_scaffold.dart';
import 'package:portal_ckc/utils/validate_password.dart';

class ButtonLogin extends StatefulWidget {
  final String account;
  final String password;
  final String nameButton;
  final int typeAccount;

  ButtonLogin({
    super.key,
    required this.nameButton,
    required this.account,
    required this.password,
    required this.typeAccount,
  });

  @override
  State<ButtonLogin> createState() => _ButtonLogin();
}

class _ButtonLogin extends State<ButtonLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1976D2).withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          if (widget.account.isNotEmpty && widget.password.isEmpty) {
            context.read<StudentBloc>().add(
              StudentRequestChangePasswordEvent(
                idStudent: widget.account,
                typeAccount: widget.typeAccount,
              ),
            );
          }
          context.read<StudentBloc>().add(
            StudentLoginEvent(ma_sv: widget.account, password: widget.password),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          widget.nameButton,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

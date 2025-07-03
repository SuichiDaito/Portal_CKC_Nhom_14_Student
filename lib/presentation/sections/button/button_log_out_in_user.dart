import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/student_event.dart';

class ButtonLogOutInUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<StudentBloc>().add(StudentLogout());
        context.go('/login');
      },
      icon: const Icon(Icons.logout),
      label: const Text('Đăng xuất'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff347433),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    );
  }
}

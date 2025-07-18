import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonChangePasswordInUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.push('/student/change/password');
      },
      icon: const Icon(Icons.lock),
      label: const Text('Đổi mật khẩu'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.blueAccent),
        ),
        elevation: 2,
      ),
    );
  }
}

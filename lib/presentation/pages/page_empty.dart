import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/presentation/sections/empty_section.dart';

class EmptyPage extends StatefulWidget {
  EmptyPage({super.key});
  @override
  State<EmptyPage> createState() => EmptyClass();
}

class EmptyClass extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/apps');
          },
        ),
        title: const Text(
          'Viết biên bản sinh hoạt',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          EmptySection(
            message: 'Bạn không có quyền truy cập vào chức năng này',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/conduct_evaluation_student_section.dart';


class PageConductEvaluationAdmin extends StatefulWidget {
  const PageConductEvaluationAdmin({super.key});

  @override
  State<PageConductEvaluationAdmin> createState() =>
      _PageConductEvaluationAdminState();
}

class _PageConductEvaluationAdminState
    extends State<PageConductEvaluationAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Bảng điểm rèn luyện',

          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1976D2),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ConductEvaluationStudentSection(
            studentName: 'Trần Hoài B',
            point: 'A',
          );
        },
      ),
    );
  }
}

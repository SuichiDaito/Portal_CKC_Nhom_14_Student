import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/divider_year_section.dart';

class ConductEvaluationStudentSection extends StatefulWidget {
  final String studentName;
  final String point;
  const ConductEvaluationStudentSection({
    super.key,
    required this.studentName,
    required this.point,
  });

  @override
  State<ConductEvaluationStudentSection> createState() => ConductEvaluation();
}

class ConductEvaluation extends State<ConductEvaluationStudentSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          MonthYearDivider(date: DateTime.now()),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              title: Text(
                widget.studentName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Text('Tháng: ${1} - Năm: 2025'),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Điểm: ${widget.point}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Xếp loại: Giỏi',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.amber,
                      // color: widget.point == 'A'
                      //     ? Colors.green
                      //     : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

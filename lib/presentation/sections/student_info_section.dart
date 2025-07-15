import 'package:flutter/material.dart';

class StudentInfoSection extends StatefulWidget {
  final String label;
  final String value;
  StudentInfoSection({super.key, required this.label, required this.value});
  @override
  State<StudentInfoSection> createState() => InfoSection();
}

class InfoSection extends State<StudentInfoSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            widget.label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

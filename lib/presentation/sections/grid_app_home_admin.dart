import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GridAppHomeAdmin extends StatefulWidget {
  const GridAppHomeAdmin({super.key});
  @override
  State<GridAppHomeAdmin> createState() => _GridAppHomeAdmin();
}

class _GridAppHomeAdmin extends State<GridAppHomeAdmin> {
  final functions = [
    {'icon': Icons.assessment, 'title': 'Điểm rèn luyện', 'color': Colors.blue},
    {'icon': Icons.list_alt, 'title': 'Đăng ký học phần', 'color': Colors.teal},
    {'icon': Icons.school, 'title': 'Điểm học tập', 'color': Colors.lightGreen},
    {
      'icon': Icons.description,
      'title': 'Xin cấp giấy tờ',
      'color': Colors.green,
    },
    {'icon': Icons.calendar_today, 'title': 'Lịch thi', 'color': Colors.blue},
    {
      'icon': Icons.access_time,
      'title': 'Thời khóa biểu',
      'color': Colors.indigo,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: functions.length,
      itemBuilder: (context, index) {
        final function = functions[index];
        return GestureDetector(
          onTap: () {
            // Handle function tap
            print('Tapped: ${function['title']}');
            if (index == 0) {
              // Điểm rèn luyện
              context.push('/admin/conduct_evaluation_admin');
            } else if (index == 1) {
              // Đăng ký học phần
              context.push('/admin/class_roster_admin');
            } else if (index == 3) {
              // Điểm học tập
              context.push('/student/signup/certificates');
            } else if (index == 2) {
              // Xin cấp giấy tờ
              context.push('/student/show/point');
            } else if (index == 4) {
              // Lịch thi
              context.push('/admin/exam_schedule_admin');
            } else if (index == 5) {
              // Thời khóa biểu
              context.push('/admin/teaching_schedule_admin');
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (function['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    function['icon'] as IconData,
                    color: function['color'] as Color,
                    size: 28,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  function['title'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

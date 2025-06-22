import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/presentation/sections/card/feature_card_application.dart';

class ApplicationsAdminPage extends StatefulWidget {
  const ApplicationsAdminPage({super.key});

  State<ApplicationsAdminPage> createState() => Application();
}

class Application extends State<ApplicationsAdminPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section for Students
          _buildSection(
            title: 'Dành cho Sinh viên',
            icon: Icons.school,
            iconColor: Colors.green,
            backgroundColor: Colors.green.withOpacity(0.05),
            borderColor: Colors.green.withOpacity(0.2),
            gridItems: getStudentFeatures(),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required Color borderColor,
    required List<FeatureItem> gridItems,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Grid View
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: gridItems.length,
            itemBuilder: (context, index) {
              final feature = gridItems[index];
              return Builder(
                builder: (innerContext) => FeatureCardApplication(
                  context: innerContext,
                  feature: feature,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

List<FeatureItem> getStudentFeatures() {
  return [
    FeatureItem(
      id: 0,
      icon: Icons.school,
      title: 'Điểm học tập',
      color: Colors.lightGreen,
      value: '',
    ),
    FeatureItem(
      id: 1,
      icon: Icons.assessment,
      title: 'Điểm rèn luyện',
      color: Colors.blue,
      value: '',
    ),
    FeatureItem(
      id: 2,
      icon: Icons.calendar_today,
      title: 'Lịch thi',
      color: Colors.cyan,
      value: '',
    ),
    FeatureItem(
      id: 3,
      icon: Icons.access_time,
      title: 'Thời khóa biểu',
      color: Colors.indigo,
      value: '',
    ),
    FeatureItem(
      id: 4,
      icon: Icons.list_alt,
      title: 'Đăng ký học phần',
      color: Colors.teal,
      value: '',
    ),
    FeatureItem(
      id: 5,
      icon: Icons.alarm,
      title: 'Đăng ký thi lại',
      color: Colors.redAccent,
      value: '',
    ),
    FeatureItem(
      id: 6,
      icon: Icons.description,
      title: 'Sinh hoạt chủ nhiệm',
      color: Colors.purple,
      value: 'SKCH',
    ),
    FeatureItem(
      id: 7,
      icon: Icons.description,
      title: 'Xin cấp giấy tờ',
      color: Colors.green,
      value: '',
    ),
    FeatureItem(
      id: 8,
      icon: Icons.edit,
      title: 'Viết biên bản sinh hoạt',
      color: Colors.brown,
      value: '',
    ),
    FeatureItem(
      id: 9,
      icon: Icons.menu_book,
      title: 'Tra cứu học phí',
      color: Colors.green,
      value: '',
    ),
    FeatureItem(
      id: 10,
      icon: Icons.person_pin,
      title: 'Tra thông tin giảng viên',
      color: Colors.pink,
      value: '',
    ),
    FeatureItem(
      id: 11,
      icon: Icons.folder,
      title: 'Tài liệu',
      color: Colors.teal,
      value: '',
    ),
  ];
}

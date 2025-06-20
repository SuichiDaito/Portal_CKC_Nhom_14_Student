import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApplicationsAdminPage extends StatelessWidget {
  const ApplicationsAdminPage({Key? key}) : super(key: key);

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
            gridItems: _getStudentFeatures(),
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
    required List<_FeatureItem> gridItems,
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
              return _buildFeatureCard(context, feature);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(context, _FeatureItem feature) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push('/admin/${feature.value}');

        print('Tapped on ${feature.title}');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: feature.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(feature.icon, color: feature.color, size: 24),
            ),
            const SizedBox(height: 10),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                feature.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_FeatureItem> _getStudentFeatures() {
    return [
      _FeatureItem(
        icon: Icons.assessment,
        title: 'Điểm rèn luyện',
        color: Colors.blue,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.school,
        title: 'Điểm học tập',
        color: Colors.lightGreen,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.notifications,
        title: 'Thông báo',
        color: Colors.orange,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.description,
        title: 'Xin cấp giấy tờ',
        color: Colors.green,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.description,
        title: 'Sinh hoạt chủ nhiệm',
        color: Colors.purple,
        value: 'SKCH',
      ),
      _FeatureItem(
        icon: Icons.calendar_today,
        title: 'Lịch học',
        color: Colors.red,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.folder,
        title: 'Tài liệu',
        color: Colors.teal,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.access_time,
        title: 'Thời khóa biểu',
        color: Colors.indigo,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.calendar_today,
        title: 'Lịch thi',
        color: Colors.cyan,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.list_alt,
        title: 'Đăng ký học phần',
        color: Colors.teal,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.alarm,
        title: 'Đăng ký thi lại',
        color: Colors.redAccent,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.menu_book,
        title: 'Tra cứu học phí',
        color: Colors.green,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.account_circle,
        title: 'Thông tin giáo viên',
        color: Colors.green,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.edit,
        title: 'Viết biên bản sinh hoạt',
        color: Colors.brown,
        value: '',
      ),
    ];
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final Color color;
  final value;
  _FeatureItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.value,
  });
}

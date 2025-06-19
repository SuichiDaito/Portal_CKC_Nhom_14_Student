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

          // Section for Teachers
          _buildSection(
            title: 'Dành cho Giảng viên',
            icon: Icons.person,
            iconColor: Colors.blue,
            backgroundColor: Colors.blue.withOpacity(0.05),
            borderColor: Colors.blue.withOpacity(0.2),
            gridItems: _getTeacherFeatures(),
          ),
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
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
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
        icon: Icons.notifications,
        title: 'Thông báo',
        color: Colors.orange,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.videocam,
        title: 'KPKP',
        color: Colors.green,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.description,
        title: 'SKCH',
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
        icon: Icons.star,
        title: 'Đánh giá',
        color: Colors.amber,
        value: '',
      ),
      _FeatureItem(
        icon: Icons.assignment,
        title: 'Bài tập',
        color: Colors.deepOrange,
        value: '',
      ),
    ];
  }

  List<_FeatureItem> _getTeacherFeatures() {
    return [
      _FeatureItem(
        icon: Icons.class_,
        title: 'Quản lý lớp chủ nhiệm',
        color: Colors.blueAccent,
        value: 'class_management_admin',
      ),
      _FeatureItem(
        icon: Icons.menu_book,
        title: 'Sổ lên lớp',
        color: Colors.green,
        value: 'class_book_admin',
      ),
      _FeatureItem(
        icon: Icons.list_alt,
        title: 'Danh sách lớp học phần',
        color: Colors.teal,
        value: 'class_roster_admin',
      ),
      _FeatureItem(
        icon: Icons.event_seat,
        title: 'Lịch gác thi',
        color: Colors.deepPurple,
        value: 'exam_schedule_admin',
      ),
      _FeatureItem(
        icon: Icons.schedule,
        title: 'Lịch giảng dạy',
        color: Colors.orange,
        value: 'teaching_schedule_admin',
      ),
      _FeatureItem(
        icon: Icons.calendar_today,
        title: 'Quản lý lịch tuần',
        color: Colors.cyan,
        value: 'lich_tuan',
      ),
      _FeatureItem(
        icon: Icons.school,
        title: 'Quản lý lớp học phần',
        color: Colors.lightGreen,
        value: 'quan_ly_lhp',
      ),
      _FeatureItem(
        icon: Icons.timelapse,
        title: 'Quản lý lịch học',
        color: Colors.pink,
        value: 'lich_hoc',
      ),
      _FeatureItem(
        icon: Icons.alarm,
        title: 'Quản lý lịch thi',
        color: Colors.redAccent,
        value: 'lich_thi',
      ),
      _FeatureItem(
        icon: Icons.meeting_room,
        title: 'Quản lý phòng học',
        color: Colors.deepOrange,
        value: 'management_group_admin',
      ),
      _FeatureItem(
        icon: Icons.person,
        title: 'Quản lý sinh viên',
        color: Colors.indigo,
        value: 'sinh_vien',
      ),
      _FeatureItem(
        icon: Icons.description,
        title: 'Quản lý cấp giấy tờ',
        color: Colors.brown,
        value: 'cap_giay_to',
      ),
      _FeatureItem(
        icon: Icons.settings,
        title: 'Quản lý tham số',
        color: Colors.blueGrey,
        value: 'tham_so',
      ),
      _FeatureItem(
        icon: Icons.security,
        title: 'Quản lý phân quyền',
        color: Colors.grey,
        value: 'phan_quyen',
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

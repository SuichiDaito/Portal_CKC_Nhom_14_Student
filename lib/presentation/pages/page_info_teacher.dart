import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card_info_teacher_section.dart';

class LecturerInfoScreen extends StatefulWidget {
  const LecturerInfoScreen({Key? key}) : super(key: key);

  @override
  _LecturerInfoScreenState createState() => _LecturerInfoScreenState();
}

class _LecturerInfoScreenState extends State<LecturerInfoScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Lecturer> lecturers = [
    Lecturer(
      name: "TS. Nguyễn Văn An",
      email: "nguyenvanan@university.edu.vn",
      phone: "0123456789",
    ),
    Lecturer(
      name: "PGS.TS. Trần Thị Bình",
      email: "tranthibinh@university.edu.vn",
      phone: "0987654321",
    ),
    Lecturer(
      name: "ThS. Lê Văn Cường",
      email: "levancuong@university.edu.vn",
      phone: "0369258147",
    ),
    Lecturer(
      name: "TS. Phạm Thị Dung",
      email: "phamthidung@university.edu.vn",
      phone: "0741852963",
    ),
    Lecturer(
      name: "PGS.TS. Hoàng Văn Em",
      email: "hoangvanem@university.edu.vn",
      phone: "0159753486",
    ),
    Lecturer(
      name: "PGS.TS. Hoàng Văn Êm",
      email: "hoangvanem@university.edu.vn",
      phone: "0159753486",
    ),
    Lecturer(
      name: "PGS.TS. Hoàng Văn Đem",
      email: "hoangvanem@university.edu.vn",
      phone: "0159753486",
    ),
  ];

  List<Lecturer> filteredLecturers = [];

  @override
  void initState() {
    super.initState();
    filteredLecturers = lecturers;
    _searchController.addListener(_filterLecturers);
  }

  void _filterLecturers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredLecturers = lecturers.where((lecturer) {
        return lecturer.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Thông tin giảng viên',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm giảng viên...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 16),
          CardInfoTeacherSection(),

          // Note at bottom
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.orange.shade50,
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.orange.shade700,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Vui lòng chỉ liên hệ giảng viên trong giờ hành chính.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange.shade800,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 19),
        ],
      ),
    );
  }
}

class Lecturer {
  final String name;
  final String email;
  final String phone;

  Lecturer({required this.name, required this.email, required this.phone});
}

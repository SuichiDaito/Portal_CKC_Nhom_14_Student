import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Subject {
  final String code;
  final String name;
  final int credits;
  final double grade;

  Subject({
    required this.code,
    required this.name,
    required this.credits,
    required this.grade,
  });
}

class SemesterData {
  final String semester;
  final List<Subject> subjects;
  final double gpa;

  SemesterData({
    required this.semester,
    required this.subjects,
    required this.gpa,
  });
}

class StudentData {
  final String id;
  final String name;
  final String className;
  final Map<String, List<SemesterData>> academicYears;

  StudentData({
    required this.id,
    required this.name,
    required this.className,
    required this.academicYears,
  });
}

class StudentGradeScreen extends StatefulWidget {
  @override
  _StudentGradeScreenState createState() => _StudentGradeScreenState();
}

class _StudentGradeScreenState extends State<StudentGradeScreen> {
  String selectedAcademicYear = '2023-2024';
  String selectedSemester = 'HK1';

  final StudentData student = StudentData(
    id: 'SV001',
    name: 'Nguyễn Văn An',
    className: 'Công nghệ phần mềm - Lớp 01',
    academicYears: {
      '2022-2023': [
        SemesterData(
          semester: 'HK1',
          subjects: [
            Subject(
              code: 'MATH101',
              name: 'Toán cao cấp 1',
              credits: 3,
              grade: 8.5,
            ),
            Subject(
              code: 'PHYS101',
              name: 'Vật lý đại cương',
              credits: 3,
              grade: 7.8,
            ),
            Subject(
              code: 'CHEM101',
              name: 'Hóa học đại cương',
              credits: 2,
              grade: 8.0,
            ),
            Subject(
              code: 'ENG101',
              name: 'Tiếng Anh 1',
              credits: 2,
              grade: 8.2,
            ),
            Subject(code: 'PE101', name: 'Thể dục 1', credits: 1, grade: 9.0),
          ],
          gpa: 8.2,
        ),
        SemesterData(
          semester: 'HK2',
          subjects: [
            Subject(
              code: 'MATH102',
              name: 'Toán cao cấp 2',
              credits: 3,
              grade: 8.0,
            ),
            Subject(
              code: 'PROG101',
              name: 'Lập trình căn bản',
              credits: 3,
              grade: 8.5,
            ),
            Subject(
              code: 'ENG102',
              name: 'Tiếng Anh 2',
              credits: 2,
              grade: 8.3,
            ),
            Subject(
              code: 'HIST101',
              name: 'Lịch sử Đảng',
              credits: 2,
              grade: 8.8,
            ),
            Subject(code: 'PE102', name: 'Thể dục 2', credits: 1, grade: 9.2),
          ],
          gpa: 8.4,
        ),
      ],
      '2023-2024': [
        SemesterData(
          semester: 'HK1',
          subjects: [
            Subject(
              code: 'CS201',
              name: 'Cấu trúc dữ liệu và giải thuật',
              credits: 3,
              grade: 8.8,
            ),
            Subject(
              code: 'CS202',
              name: 'Lập trình hướng đối tượng',
              credits: 3,
              grade: 9.0,
            ),
            Subject(
              code: 'CS203',
              name: 'Cơ sở dữ liệu',
              credits: 3,
              grade: 8.5,
            ),
            Subject(
              code: 'CS204',
              name: 'Mạng máy tính',
              credits: 3,
              grade: 8.2,
            ),
            Subject(
              code: 'CS205',
              name: 'Hệ điều hành',
              credits: 3,
              grade: 8.6,
            ),
            Subject(
              code: 'MATH201',
              name: 'Toán rời rạc',
              credits: 2,
              grade: 8.4,
            ),
            Subject(
              code: 'ENG201',
              name: 'Tiếng Anh chuyên ngành',
              credits: 2,
              grade: 8.7,
            ),
          ],
          gpa: 8.6,
        ),
        SemesterData(
          semester: 'HK2',
          subjects: [
            Subject(
              code: 'CS301',
              name: 'Công nghệ phần mềm',
              credits: 3,
              grade: 9.2,
            ),
            Subject(
              code: 'CS302',
              name: 'Phát triển ứng dụng Web',
              credits: 3,
              grade: 8.8,
            ),
            Subject(
              code: 'CS303',
              name: 'Lập trình di động',
              credits: 3,
              grade: 9.0,
            ),
            Subject(
              code: 'CS304',
              name: 'Trí tuệ nhân tạo',
              credits: 3,
              grade: 8.5,
            ),
            Subject(
              code: 'CS305',
              name: 'Bảo mật thông tin',
              credits: 3,
              grade: 8.3,
            ),
            Subject(
              code: 'CS306',
              name: 'Kiểm thử phần mềm',
              credits: 2,
              grade: 8.9,
            ),
            Subject(
              code: 'MGMT201',
              name: 'Quản lý dự án',
              credits: 2,
              grade: 8.6,
            ),
            Subject(
              code: 'ENG301',
              name: 'Tiếng Anh kỹ thuật',
              credits: 2,
              grade: 8.4,
            ),
          ],
          gpa: 8.7,
        ),
      ],
      '2024-2025': [
        SemesterData(
          semester: 'HK1',
          subjects: [
            Subject(
              code: 'CS401',
              name: 'Đồ án tốt nghiệp 1',
              credits: 3,
              grade: 9.0,
            ),
            Subject(
              code: 'CS402',
              name: 'Thực tập doanh nghiệp',
              credits: 4,
              grade: 8.8,
            ),
            Subject(
              code: 'CS403',
              name: 'Phân tích dữ liệu lớn',
              credits: 3,
              grade: 8.5,
            ),
            Subject(
              code: 'CS404',
              name: 'Điện toán đám mây',
              credits: 3,
              grade: 8.7,
            ),
            Subject(code: 'CS405', name: 'Blockchain', credits: 2, grade: 8.9),
            Subject(
              code: 'ECON101',
              name: 'Kinh tế học đại cương',
              credits: 2,
              grade: 8.2,
            ),
          ],
          gpa: 8.7,
        ),
        SemesterData(
          semester: 'HK2',
          subjects: [
            Subject(
              code: 'CS501',
              name: 'Đồ án tốt nghiệp 2',
              credits: 6,
              grade: 9.2,
            ),
            Subject(
              code: 'CS502',
              name: 'Seminar chuyên ngành',
              credits: 2,
              grade: 9.0,
            ),
            Subject(
              code: 'CS503',
              name: 'Khởi nghiệp công nghệ',
              credits: 2,
              grade: 8.8,
            ),
            Subject(
              code: 'LAW101',
              name: 'Pháp luật đại cương',
              credits: 2,
              grade: 8.5,
            ),
          ],
          gpa: 8.9,
        ),
      ],
    },
  );

  List<String> get availableAcademicYears =>
      student.academicYears.keys.toList();

  List<String> get availableSemesters {
    return student.academicYears[selectedAcademicYear]
            ?.map((e) => e.semester)
            .toList() ??
        [];
  }

  SemesterData? get currentSemesterData {
    final yearData = student.academicYears[selectedAcademicYear];
    if (yearData == null) return null;
    return yearData.firstWhere(
      (semester) => semester.semester == selectedSemester,
      orElse: () => yearData.first,
    );
  }

  double get yearlyGPA {
    final yearData = student.academicYears[selectedAcademicYear];
    if (yearData == null || yearData.isEmpty) return 0.0;

    double totalWeightedGPA = 0.0;
    int totalCredits = 0;

    for (var semester in yearData) {
      int semesterCredits = semester.subjects.fold(
        0,
        (sum, subject) => sum + subject.credits,
      );
      totalWeightedGPA += semester.gpa * semesterCredits;
      totalCredits += semesterCredits;
    }

    return totalCredits > 0 ? totalWeightedGPA / totalCredits : 0.0;
  }

  Color _getGradeColor(double grade) {
    if (grade >= 9.0) return Colors.green[700]!;
    if (grade >= 8.0) return Colors.green[600]!;
    if (grade >= 7.0) return Colors.blue[600]!;
    if (grade >= 6.0) return Colors.orange[600]!;
    if (grade >= 5.0) return Colors.orange[700]!;
    return Colors.red[600]!;
  }

  String _getLetterGrade(double grade) {
    if (grade >= 9.0) return 'A+';
    if (grade >= 8.5) return 'A';
    if (grade >= 8.0) return 'A-';
    if (grade >= 7.5) return 'B+';
    if (grade >= 7.0) return 'B';
    if (grade >= 6.5) return 'B-';
    if (grade >= 6.0) return 'C+';
    if (grade >= 5.5) return 'C';
    if (grade >= 5.0) return 'C-';
    if (grade >= 4.0) return 'D';
    return 'F';
  }

  @override
  Widget build(BuildContext context) {
    final semesterData = currentSemesterData;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text(
          'Bảng điểm sinh viên',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            GoRouter.of(context).go('/home/admin');
          },
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header Card
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[600]!, Colors.blue[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Student Info
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${student.id} - ${student.className}',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Dropdowns
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedAcademicYear,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            dropdownColor: Colors.blue[600],
                            items: availableAcademicYears.map((String year) {
                              return DropdownMenuItem<String>(
                                value: year,
                                child: Text(
                                  year,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedAcademicYear = newValue!;
                                selectedSemester = availableSemesters.first;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedSemester,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            dropdownColor: Colors.blue[600],
                            items: availableSemesters.map((String semester) {
                              return DropdownMenuItem<String>(
                                value: semester,
                                child: Text(
                                  semester,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedSemester = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Summary Stats
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Học kỳ hiện tại',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '$selectedSemester',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'GPA cả năm',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${yearlyGPA.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Grades Table
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Môn học',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Tín chỉ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Điểm',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Xếp loại',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Table Content
                  Expanded(
                    child: ListView(
                      children: [
                        if (semesterData != null) ...[
                          ...semesterData.subjects
                              .map(
                                (subject) => Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              subject.code,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blue[600],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              subject.name,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '${subject.credits}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          subject.grade.toStringAsFixed(1),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: _getGradeColor(
                                              subject.grade,
                                            ),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getGradeColor(
                                              subject.grade,
                                            ).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: Text(
                                            _getLetterGrade(subject.grade),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: _getGradeColor(
                                                subject.grade,
                                              ),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),

                          // Summary Row
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Tổng kết học kỳ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${semesterData.subjects.fold(0, (sum, subject) => sum + subject.credits)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    semesterData.gpa.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: _getGradeColor(semesterData.gpa),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getGradeColor(
                                        semesterData.gpa,
                                      ).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      _getLetterGrade(semesterData.gpa),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: _getGradeColor(semesterData.gpa),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

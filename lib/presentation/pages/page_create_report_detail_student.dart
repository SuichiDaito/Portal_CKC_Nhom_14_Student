import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/danh_sach_sinh_vien.dart';
import 'package:portal_ckc/bloc/bloc_event_state/danh_sach_sinh_vien_bloc.dart';
import 'package:portal_ckc/bloc/event/danh_sach_sinh_vien_event.dart';
import 'package:portal_ckc/bloc/state/danh_sach_sinh_vien.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef Student = ListStudent;

class StudentAbsence {
  final Student student;
  final TextEditingController reasonController;
  bool hasReason;

  StudentAbsence({
    required this.student,
    required this.reasonController,
    this.hasReason = false,
  });
}

class CreateAttendanceForm extends StatefulWidget {
  const CreateAttendanceForm({super.key});

  @override
  _CreateAttendanceFormState createState() => _CreateAttendanceFormState();
}

class _CreateAttendanceFormState extends State<CreateAttendanceForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  int? currentUserId;

  String? _selectedWeek = 'Tuần 1';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 7, minute: 0);

  List<Student> allStudents = [];
  List<Student> _filteredStudents = [];
  List<StudentAbsence> _selectedStudents = [];

  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    context.read<ListStudentBloc>().add(FetchListStudent());
    _loadCurrentUserId();
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var studentAbsence in _selectedStudents) {
      studentAbsence.reasonController.dispose();
    }
    _searchController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = prefs.getInt('student_id');
    });
  }

  void _filterStudents(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredStudents = allStudents;
        _showSuggestions = false;
      } else {
        _filteredStudents = allStudents.where((student) {
          return student.sinhVien!.hoSo!.hoTen!.toLowerCase().contains(
                query.toLowerCase(),
              ) ||
              student.sinhVien!.maSv!.toLowerCase().contains(
                query.toLowerCase(),
              );
        }).toList();
        _showSuggestions = true;
      }
    });
  }

  void _selectStudent(Student student) {
    setState(() {
      // Kiểm tra xem sinh viên đã được chọn chưa
      bool alreadySelected = _selectedStudents.any(
        (absence) => absence.student.sinhVien!.id == student.sinhVien!.id,
      );

      if (!alreadySelected) {
        _selectedStudents.add(
          StudentAbsence(
            student: student,
            reasonController: TextEditingController(),
          ),
        );
      }
      _searchController.clear();
      _showSuggestions = false;
    });
  }

  void _removeStudent(StudentAbsence studentAbsence) {
    setState(() {
      studentAbsence.reasonController.dispose();
      _selectedStudents.remove(studentAbsence);
    });
  }

  void _toggleReason(StudentAbsence studentAbsence, bool hasReason) {
    setState(() {
      studentAbsence.hasReason = hasReason;
      if (!hasReason) {
        studentAbsence.reasonController.clear();
      }
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _submitForm(int idLop) {
    if (_formKey.currentState!.validate()) {
      int idTuan = int.parse(_selectedWeek!.replaceAll(RegExp(r'[^0-9]'), ''));

      String _combineDateTime(DateTime date, TimeOfDay time) {
        final combined = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
        return combined.toIso8601String().substring(0, 16);
      }

      final data = {
        'id_tuan': idTuan,
        'ngay': _selectedDate.toIso8601String(),
        'tieu_de': 'Biên bản sinh hoạt lớp',
        'noi_dung': _contentController.text.trim(),
        'thoi_gian_bat_dau': _combineDateTime(_selectedDate, _selectedTime),
        'thoi_gian_ket_thuc': _combineDateTime(
          _selectedDate,
          TimeOfDay(hour: 9, minute: 0),
        ),
        'so_luong_sinh_vien': allStudents.length,
        'vang_mat': _selectedStudents.length,
        'id_sv': currentUserId,
        'sinh_vien_vang': {
          for (var studentAbsence in _selectedStudents)
            '${studentAbsence.student.sinhVien!.id}': {
              'ly_do': studentAbsence.reasonController.text.trim(),
              'loai': studentAbsence.hasReason ? 1 : 0,
            },
        },
      };

      context.read<ListStudentBloc>().add(
        CreatReportEvent(data: data, lopId: idLop),
      );

      context.push('/student/show/report/list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Tạo biên bản sinh hoạt',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocConsumer<ListStudentBloc, ListStudentState>(
        listener: (context, state) {
          if (state is ListStudentStateLoaded) {
            setState(() {
              allStudents = state.studens;
              _filteredStudents = allStudents;
            });
          } else if (state is CreateReportSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.of(context).pop();
          } else if (state is CreateReportError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Week selection
                    Row(
                      children: [
                        Text('Tuần:', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedWeek,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            items:
                                List.generate(
                                      16,
                                      (index) => 'Tuần ${index + 1}',
                                    )
                                    .map(
                                      (week) => DropdownMenuItem(
                                        value: week,
                                        child: Text(week),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedWeek = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Date selection
                    Row(
                      children: [
                        Text('Ngày:', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: _selectDate,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _formatDate(DateTime.now()),
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Time selection
                    Row(
                      children: [
                        Text('Giờ:', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: _selectTime,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _formatTime(_selectedTime),
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24),

                    // Student search section
                    Text(
                      'Tìm và chọn sinh viên vắng:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 12),

                    // Search field
                    TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Nhập tên hoặc MSSV',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onChanged: _filterStudents,
                      validator: (value) {
                        if (_selectedStudents.isEmpty) {
                          return 'Vui lòng chọn ít nhất một sinh viên vắng';
                        }
                        return null;
                      },
                    ),

                    // Student suggestions
                    if (_showSuggestions && _filteredStudents.isNotEmpty)
                      Container(
                        constraints: BoxConstraints(maxHeight: 150),
                        margin: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filteredStudents.length,
                          itemBuilder: (context, index) {
                            final student = _filteredStudents[index];
                            return ListTile(
                              title: Text(student.sinhVien!.hoSo!.hoTen ?? ""),
                              subtitle: Text(student.sinhVien!.maSv ?? ""),
                              onTap: () => _selectStudent(student),
                            );
                          },
                        ),
                      ),

                    SizedBox(height: 16),

                    // Selected students with individual reason fields
                    if (_selectedStudents.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sinh viên vắng và lý do:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),

                          // List of selected students with reason fields
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _selectedStudents.length,
                            itemBuilder: (context, index) {
                              final studentAbsence = _selectedStudents[index];
                              return Card(
                                margin: EdgeInsets.only(bottom: 12),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Student info and remove button
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  studentAbsence
                                                          .student
                                                          .sinhVien!
                                                          .hoSo!
                                                          .hoTen ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  'MSSV: ${studentAbsence.student.sinhVien!.maSv ?? ""}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                            onPressed: () =>
                                                _removeStudent(studentAbsence),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 8),

                                      // Checkbox for reason
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: studentAbsence.hasReason,
                                            onChanged: (value) => _toggleReason(
                                              studentAbsence,
                                              value ?? false,
                                            ),
                                          ),
                                          Text('Có lý do vắng'),
                                        ],
                                      ),

                                      // Reason text field
                                      if (studentAbsence.hasReason)
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: TextFormField(
                                            controller:
                                                studentAbsence.reasonController,
                                            decoration: InputDecoration(
                                              hintText: 'Nhập lý do vắng',
                                              border: OutlineInputBorder(),
                                              contentPadding: EdgeInsets.all(
                                                12,
                                              ),
                                            ),
                                            maxLines: 2,
                                            validator: (value) {
                                              if (studentAbsence.hasReason &&
                                                  (value == null ||
                                                      value.trim().isEmpty)) {
                                                return 'Vui lòng nhập lý do vắng';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                    SizedBox(height: 24),

                    // Content field
                    Text(
                      'Nội dung',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _contentController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Nhập nội dung biên bản',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập nội dung biên bản';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 50),

                    // Submit button
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: allStudents.isNotEmpty
                            ? () => _submitForm(allStudents.first.idLop ?? 0)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.create, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Tạo biên bản',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

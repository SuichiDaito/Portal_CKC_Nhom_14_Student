import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/danh_sach_sinh_vien.dart';
import 'package:portal_ckc/bloc/bloc_event_state/danh_sach_sinh_vien_bloc.dart';
import 'package:portal_ckc/bloc/event/danh_sach_sinh_vien_event.dart';
import 'package:portal_ckc/bloc/state/danh_sach_sinh_vien.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef Student = ListStudent;

class CreateAttendanceForm extends StatefulWidget {
  const CreateAttendanceForm({super.key});

  @override
  _CreateAttendanceFormState createState() => _CreateAttendanceFormState();
}

class _CreateAttendanceFormState extends State<CreateAttendanceForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  int? currentUserId;

  String? _selectedWeek = 'Tuần 1';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 7, minute: 0);

  List<Student> allStudents = [];
  List<Student> _filteredStudents = [];
  List<Student> _selectedStudents = [];

  bool _showReasonField = false;
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    context.read<ListStudentBloc>().add(FetchListStudent());
    _loadCurrentUserId();
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
      if (!_selectedStudents.contains(student)) {
        _selectedStudents.add(student);
      }
      _searchController.clear();
      _showSuggestions = false;
    });
  }

  void _removeStudent(Student student) {
    setState(() {
      _selectedStudents.remove(student);
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
      // if (_selectedStudents.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Vui lòng chọn ít nhất một sinh viên vắng')),
      //   );
      //   return;
      // }

      int idTuan = int.parse(_selectedWeek!.replaceAll(RegExp(r'[^0-9]'), ''));

      // ✅ Tạo danh sách id sinh viên vắng
      final List<int> listIdAbsent = _selectedStudents
          .map((student) => student.sinhVien?.id)
          .whereType<int>()
          .toList();
      String _combineDateTime(DateTime date, TimeOfDay time) {
        final combined = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
        return combined.toIso8601String().substring(
          0,
          16,
        ); // giữ định dạng yyyy-MM-ddTHH:mm
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
          for (var student in _selectedStudents)
            '${student.sinhVien!.id}': {
              'ly_do': _reasonController.text.trim(),
              'loai': _showReasonField ? 1 : 0,
            },
        },
      };

      context.read<ListStudentBloc>().add(
        CreatReportEvent(data: data, lopId: idLop),
      );
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
            Navigator.of(context).pop(); // <-- đóng sau khi tạo thành công
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

                    // Selected students
                    if (_selectedStudents.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sinh viên đã chọn:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _selectedStudents.map((student) {
                              return Chip(
                                label: Text(
                                  '${student.sinhVien!.hoSo!.hoTen ?? ""} (${student.sinhVien!.maSv ?? ""})',
                                ),
                                deleteIcon: Icon(Icons.close, size: 18),
                                onDeleted: () => _removeStudent(student),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),

                    // Reason checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _showReasonField,
                          onChanged: (value) {
                            setState(() {
                              _showReasonField = value ?? false;
                              if (!_showReasonField) {
                                _reasonController.clear();
                              }
                            });
                          },
                        ),
                        Text('Có lý do vắng'),
                      ],
                    ),

                    // Reason field
                    if (_showReasonField)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            'Lý do vắng:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _reasonController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Nhập lý do vắng của sinh viên',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(12),
                            ),
                            validator: (value) {
                              if (_showReasonField &&
                                  (value == null || value.trim().isEmpty)) {
                                return 'Vui lòng nhập lý do vắng';
                              }
                              return null;
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
                            : null, // vô hiệu hóa nút nếu chưa có dữ liệu
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/student_training_program_model.dart';
import 'package:portal_ckc/api/model/training%20point_model.dart';
import 'package:portal_ckc/bloc/bloc_event_state/training_program_bloc.dart';
import 'package:portal_ckc/bloc/event/training_program_event.dart';
import 'package:portal_ckc/bloc/state/training_program_state.dart';
import 'package:portal_ckc/constant/token.dart';
import 'package:portal_ckc/presentation/sections/empty_section.dart';

class TrainingProgramScreen extends StatefulWidget {
  @override
  _TrainingProgramScreenState createState() => _TrainingProgramScreenState();
}

class _TrainingProgramScreenState extends State<TrainingProgramScreen> {
  int? selectedSemester;
  List<int> availableSemesters = [];
  List<int> studentSpecializations = []; // Danh sách chuyên ngành của sinh viên
  int id1 = 0;
  int id2 = 0;

  @override
  void initState() {
    super.initState();
    context.read<TrainingProgramBloc>().add(FetchTrainingProgramEvent());
    getIds();
  }

  Future<void> getIds() async {
    Future<String> stringFuture = ConstraintToken.getIdSpecialized1();
    String string = await stringFuture;

    Future<String> stringFuture2 = ConstraintToken.getIdSpecialized2();
    String string2 = await stringFuture;

    id1 = int.parse(string);
    // id2 = int.parse(string2);
    id2 = 0;

    print('Đã lấy được id chuyên ngành: $string $string2');
  }

  // Lấy danh sách chuyên ngành mà sinh viên có
  void _extractStudentSpecializations(List<TrainingProgram> trainingPrograms) {
    Set<int> specializationSet = {};

    for (var program in trainingPrograms) {
      if (program.idChuyenNganh != null) {
        specializationSet.add(program.idChuyenNganh!);
      }
    }

    studentSpecializations = specializationSet.toList()..sort();
  }

  // Lấy danh sách học kỳ dựa trên chuyên ngành sinh viên có
  void _extractSemesters(List<TrainingProgram> trainingPrograms) {
    Set<int> semesterSet = {};

    // Lấy chuyên ngành sinh viên có
    _extractStudentSpecializations(trainingPrograms);

    // Xác định học kỳ dựa trên chuyên ngành
    if (studentSpecializations.contains(id1)) {
      // Nếu có chuyên ngành 1, thêm học kỳ 1-3
      semesterSet.addAll([1, 2, 3]);
    }

    if (id2 != 0 || id2 != null) {
      if (studentSpecializations.contains(id2)) {
        // Nếu có chuyên ngành 2, thêm học kỳ 4-6
        semesterSet.addAll([4, 5, 6]);
      }
    }

    availableSemesters = semesterSet.toList()..sort();

    // Nếu chưa chọn học kỳ và có dữ liệu, chọn học kỳ đầu tiên
    if (selectedSemester == null && availableSemesters.isNotEmpty) {
      selectedSemester = availableSemesters.first;
    }
  }

  // Xác định chuyên ngành dựa trên học kỳ
  int? _getSpecializationBySemester(int semester) {
    if (semester >= 1 && semester <= 3) {
      return 1;
    } else if (semester >= 4 && semester <= 6) {
      return 2;
    }
    return null;
  }

  // Lọc môn học theo học kỳ được chọn và chuyên ngành tương ứng
  List<ProgramDetail> _filterSubjectsBySemester(
    List<TrainingProgram> trainingPrograms,
  ) {
    if (selectedSemester == null) return [];

    // Xác định chuyên ngành dựa trên học kỳ đã chọn
    int? targetSpecialization = _getSpecializationBySemester(selectedSemester!);
    if (targetSpecialization == null) return [];

    // Tìm chương trình đào tạo của chuyên ngành tương ứng
    final targetProgram = trainingPrograms.firstWhere(
      (program) => program.idChuyenNganh == targetSpecialization,
      orElse: () => TrainingProgram(), // Trả về object rỗng nếu không tìm thấy
    );

    if (targetProgram.chiTietChuongTrinhDaoTao == null) return [];

    // Lọc môn học theo học kỳ
    return targetProgram.chiTietChuongTrinhDaoTao!
        .where((subject) => subject.idHocKy == selectedSemester)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Chương trình đào tạo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocBuilder<TrainingProgramBloc, TrainingProgramState>(
        builder: (context, state) {
          if (state is TrainingProgramStateLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is TrainingProgramStateLoaded) {
            final trainingPrograms = state.trainingPrograms;

            // Cập nhật danh sách học kỳ
            _extractSemesters(trainingPrograms);

            // Lọc môn học theo học kỳ đã chọn
            final filteredSubjects = _filterSubjectsBySemester(
              trainingPrograms,
            );

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Header thông tin chung
                  if (trainingPrograms.isNotEmpty)
                    Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue[400]!, Colors.blue[600]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.list_alt_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Công Nghệ Thông Tin',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Hiển thị số chuyên ngành con
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'CN: ${studentSpecializations.length}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          // Hiển thị các chuyên ngành con
                          if (studentSpecializations.isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: id2 != null
                                  ? Text(
                                      trainingPrograms
                                              .firstWhere(
                                                (p) => p.idChuyenNganh == id2,
                                                orElse: () => TrainingProgram(),
                                              )
                                              .tenChuongTrinhDaoTao ??
                                          'Chuyên ngành ${trainingPrograms[id2].tenChuongTrinhDaoTao}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : Text(
                                      trainingPrograms
                                              .firstWhere(
                                                (p) => p.idChuyenNganh == id1,
                                                orElse: () => TrainingProgram(),
                                              )
                                              .tenChuongTrinhDaoTao ??
                                          'Chuyên ngành ${trainingPrograms.first.tenChuongTrinhDaoTao}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ),
                        ],
                      ),
                    ),

                  // Dropdown chọn học kỳ
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.school, color: Colors.blue[600], size: 20),
                        SizedBox(width: 12),
                        Text(
                          'Chọn học kỳ:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: selectedSemester,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.blue[400]!,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            items: availableSemesters.map((semester) {
                              final specId = _getSpecializationBySemester(
                                semester,
                              );
                              final program = trainingPrograms.firstWhere(
                                (p) => p.idChuyenNganh == specId,
                                orElse: () => TrainingProgram(),
                              );
                              return DropdownMenuItem<int>(
                                value: semester,
                                child: Text(
                                  'Học kỳ $semester',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedSemester = value;
                              });
                            },
                            hint: Text(
                              'Chọn học kỳ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // Danh sách môn học
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Danh sách môn học',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            if (selectedSemester != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Học kỳ $selectedSemester: ${filteredSubjects.length} môn',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 12),
                        filteredSubjects.isEmpty
                            ? Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 40,
                                        color: Colors.grey[400],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Không có môn học nào trong học kỳ này',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: filteredSubjects.length,
                                itemBuilder: (context, subjectIndex) {
                                  final subject =
                                      filteredSubjects[subjectIndex];
                                  return Column(
                                    children: [
                                      SubjectCard(
                                        detailTrainingProgram: subject,
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          } else if (state is TrainingProgramStateError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('NOT FOUND | 404'));
        },
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final ProgramDetail detailTrainingProgram;

  SubjectCard({Key? key, required this.detailTrainingProgram})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                detailTrainingProgram.id.toString(),
                style: TextStyle(
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailTrainingProgram?.monHoc?.tenMon ?? '',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Thuộc Học kỳ: ${detailTrainingProgram.idHocKy}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Số tiết: ${detailTrainingProgram.soTiet}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Tín chỉ: ${detailTrainingProgram.soTinChi}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Loại: ${detailTrainingProgram?.monHoc?.loaiMonHoc == 1 ? 'Tự chọn' : 'Bắt buộc'}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.orange[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

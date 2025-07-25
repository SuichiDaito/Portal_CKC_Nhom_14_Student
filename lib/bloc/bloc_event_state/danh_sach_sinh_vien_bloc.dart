import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/danh_sach_sinh_vien.dart';
import 'package:portal_ckc/bloc/event/danh_sach_sinh_vien_event.dart';
import 'package:portal_ckc/bloc/state/danh_sach_sinh_vien.dart';

class ListStudentBloc extends Bloc<ListStudentEvent, ListStudentState> {
  final _service = CallApiStudent.adminService;

  List<ListStudent> _students = [];

  List<ListStudent> get students => _students;
  ListStudentBloc() : super(ListStudentInitial()) {
    on<FetchListStudent>(_onFetchStudentEvent);
    on<CreatReportEvent>(_onCreateReport);
  }

  Future<void> _onCreateReport(
    CreatReportEvent event,
    Emitter<ListStudentState> emit,
  ) async {
    emit(ListStudentStateLoading());
    try {
      final response = await _service.createBienBan(event.lopId, event.data);
      if (response.isSuccessful) {
        emit(CreateReportSuccess("Tạo biên bản thành công"));
      } else {
        emit(CreateReportError("Tạo biên bản thất bại"));
      }
    } catch (e) {
      emit(CreateReportError("Lỗi khi tạo biên bản: $e"));
    }
  }

  Future<void> _onFetchStudentEvent(
    ListStudentEvent event,
    Emitter emit,
  ) async {
    print('➡️ Đang xử lý lấy danh sách sinh viên');
    emit(ListStudentStateLoading());

    try {
      final response = await _service.getListStudent();

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('danhSachSinhVien')) {
            final listJson = body['danhSachSinhVien'] as List<dynamic>;
            final exams = listJson
                .map(
                  (item) => ListStudent.fromJson(item as Map<String, dynamic>),
                )
                .toList();

            _students = exams;
            emit(ListStudentStateLoaded(exams));
          } else {
            emit(
              ListStudentStateError(
                'Dữ liệu không hợp lệ: data không phải danh sách',
              ),
            );
          }
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(ListStudentStateError(error['message']));
        } else {
          emit(ListStudentStateError('Lỗi không xác định khi lấy dữ liệu'));
        }
      }
    } catch (e) {
      emit(ListStudentStateError('Lỗi kết nối: $e'));
    }
  }
}

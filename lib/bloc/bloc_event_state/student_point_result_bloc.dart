import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/student_point_result.dart';
import 'package:portal_ckc/bloc/event/student_point_event.dart';
import 'package:portal_ckc/bloc/state/student_point_state.dart';

class StudentPointResultBloc
    extends Bloc<StudentPointEvent, StudentResultPointState> {
  final _service = CallApiStudent.adminService;

  StudentPointResultBloc() : super(StudentPointStateInitial()) {
    print('🟡 StudentPointResultBloc CREATED');
    on<FetchPointResultEvent>(_onFetchPointResultEvent);
  }

  Future<void> _onFetchPointResultEvent(
    FetchPointResultEvent event,
    Emitter<StudentResultPointState> emit,
  ) async {
    print('➡️ Đang xử lý lấy danh sách điểm học phần');
    emit(StudentPointStateLoading());

    try {
      final response = await _service.getPointResult();

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('monTheoHocKy')) {
            final listData = body['monTheoHocKy'] as Map<String, dynamic>;
            final results = listData.map(
              (key, value) => MapEntry(
                key,
                (value as List).map((item) => Subject.fromJson(item)).toList(),
              ),
            );

            emit(StudentPointStateLoaded(results));
            print('data response: HK1: ${results[1]}');
          } else {
            emit(
              StudentPointStateError(
                'Dữ liệu không hợp lệ: data không phải danh sách',
              ),
            );
          }
        } else {
          emit(
            StudentPointStateError(
              'Phản hồi không hợp lệ từ server (body không phải Map)',
            ),
          );
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(StudentPointStateError(error['message']));
        } else {
          emit(StudentPointStateError('Lỗi không xác định khi lấy dữ liệu'));
        }
      }
    } catch (e) {
      emit(StudentPointStateError('Lỗi kết nối: $e'));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/exam_model.dart';
import 'package:portal_ckc/bloc/event/exam_event.dart';
import 'package:portal_ckc/bloc/state/exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final _service = CallApiStudent.adminService;

  ExamBloc() : super(ExamStateInitial()) {
    on<FetchExamEvent>(_onFetchExamEvent);
  }

  Future<void> _onFetchExamEvent(ExamEvent event, Emitter emit) async {
    print('➡️ Đang xử lý lấy lịch thi');
    emit(ExamStateLoading());

    try {
      final response = await _service.getExamStudent();

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('data')) {
            final listJson = body['data'] as List<dynamic>;
            final exams = listJson
                .map(
                  (item) => ExamSchedule.fromJson(item as Map<String, dynamic>),
                )
                .toList();

            emit(ExamStateLoaded(exams));
          } else {
            emit(
              ExamStateError('Dữ liệu không hợp lệ: data không phải danh sách'),
            );
          }
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(ExamStateError(error['message']));
        } else {
          emit(ExamStateError('Lỗi không xác định khi lấy dữ liệu'));
        }
      }
    } catch (e) {
      emit(ExamStateError('Lỗi kết nối: $e'));
    }
  }
}

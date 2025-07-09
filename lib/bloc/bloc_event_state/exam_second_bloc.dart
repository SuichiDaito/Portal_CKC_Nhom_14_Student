import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/exam_model.dart';
import 'package:portal_ckc/api/model/exam_second_model.dart';
import 'package:portal_ckc/bloc/event/exam_event.dart';
import 'package:portal_ckc/bloc/event/exam_second_event.dart';
import 'package:portal_ckc/bloc/state/exam_second_state.dart';
import 'package:portal_ckc/bloc/state/exam_state.dart';

class ExamSecondBloc extends Bloc<ExamSecondEvent, ExamSecondState> {
  final _service = CallApiStudent.adminService;

  ExamSecondBloc() : super(ExamSecondStateInitial()) {
    on<FetchExamSecondEvent>(_onFetchExamSecondEvent);
  }

  Future<void> _onFetchExamSecondEvent(ExamSecondEvent event, Emitter emit) async {
    print('➡️ Đang xử lý lấy lịch thi lần hai');
    emit(ExamSecondStateLoading());

    try {
      final response = await _service.getExamsSecond();

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('data')) {
            final listJson = body['data'] as List<dynamic>;
            final exams = listJson
                .map((item) => LichThi.fromJson(item as Map<String, dynamic>))
                .toList();

            emit(ExamSecondStateLoaded(exams));
          } else {
            emit(
              ExamStateError('Dữ liệu không hợp lệ: data không phải danh sách'),
            );
          }
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(ExamSecondStateError(error['message']));
        } else {
          emit(ExamSecondStateError('Lỗi không xác định khi lấy dữ liệu'));
        }
      }
    } catch (e) {
      emit(ExamSecondStateError('Lỗi kết nối: $e'));
    }
  }
}

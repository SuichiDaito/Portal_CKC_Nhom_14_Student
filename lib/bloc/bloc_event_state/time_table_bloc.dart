import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/student_time_table_model.dart';
import 'package:portal_ckc/bloc/event/time_table_event.dart';
import 'package:portal_ckc/bloc/state/student_time_table_state.dart';

class TimeTableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  final _service = CallApiStudent.adminService;

  TimeTableBloc() : super(TimeTableStateInitial()) {
    on<FetchTimeTableEvent>(_onFetchTimeTable);
  }

  Future<void> _onFetchTimeTable(TimeTableEvent event, Emitter emit) async {
    print('➡️ Đang xử lý lấy thời khóa biểu sinh viên');
    emit(TimeTableStateLoading());

    try {
      final response = await _service.getTimeTable();

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
                  (item) => ScheduleData.fromJson(item as Map<String, dynamic>),
                )
                .toList();

            emit(TimeTableStateLoaded(exams));
          } else {
            emit(
              TimeTableStateError(
                'Dữ liệu không hợp lệ: data không phải danh sách',
              ),
            );
          }
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(TimeTableStateError(error['message']));
        } else {
          emit(TimeTableStateError('Lỗi không xác định khi lấy dữ liệu'));
        }
      }
    } catch (e) {
      emit(TimeTableStateError('Lỗi kết nối: $e'));
    }
  }
}

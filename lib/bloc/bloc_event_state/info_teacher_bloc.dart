import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/info_teacher_model.dart';
import 'package:portal_ckc/bloc/event/info_teacher_event.dart';
import 'package:portal_ckc/bloc/state/info_teacher_state.dart';

class InfoTeacherBloc extends Bloc<InfoTeacherEvent, InfoTeacherState> {
  final _service = CallApiStudent.adminService;

  InfoTeacherBloc() : super(InfoTeacherStateInitial()) {
    on<FetchInfoTeacher>(_onFetchInfoTeacher);
  }

  Future<void> _onFetchInfoTeacher(InfoTeacherEvent event, Emitter emit) async {
    print('➡️ Đang xử lý lấy thông tin giảng viên');
    emit(InfoTeacherStateLoading());

    try {
      final response = await _service.getInfoTeacher();

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('data')) {
            final listJson = body['data'] as List<dynamic>;
            final teachers = listJson
                .map((item) => Teacher.fromJson(item as Map<String, dynamic>))
                .toList();

            emit(InfoTeacherStateLoaded(teachers));
          } else {
            emit(
              InfoTeacherStateError(
                'Dữ liệu không hợp lệ: data không phải danh sách',
              ),
            );
          }
        } else {
          emit(
            InfoTeacherStateError(
              'Phản hồi không hợp lệ từ server (body không phải Map)',
            ),
          );
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(InfoTeacherStateError(error['message']));
        } else {
          emit(InfoTeacherStateError('Lỗi không xác định khi lấy dữ liệu'));
        }
      }
    } catch (e) {
      emit(InfoTeacherStateError('Lỗi kết nối: $e'));
    }
  }
}

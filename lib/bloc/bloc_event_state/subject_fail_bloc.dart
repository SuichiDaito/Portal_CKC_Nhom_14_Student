import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/list_subject_student_model.dart';
import 'package:portal_ckc/bloc/event/list_subject_event.dart';
import 'package:portal_ckc/bloc/state/list_subject_fail.dart';

class SubjectFailBloc extends Bloc<ListSubjectEvent, ListSubjectFailState> {
  final _service = CallApiStudent.adminService;

  SubjectFailBloc() : super(ListSubjectFailInitial()) {
    on<FetchListSubjectEvent>(_onFetchData);
  }

  Future<void> _onFetchData(ListSubjectEvent event, Emitter emit) async {
    print('➡️ Đang xử lý lấy danh sách các môn sinh viên rớt');
    emit(ListSubjectFailStateLoading());

    try {
      final response = await _service.requestSignupStudy();

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
                  (item) => DiemHocPhan.fromJson(item as Map<String, dynamic>),
                )
                .toList();

            emit(ListSubjectFailStateLoaded(exams));
          } else {
            emit(
              ListSubjectFailStateError(
                'Dữ liệu không hợp lệ: data không phải danh sách',
              ),
            );
          }
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(ListSubjectFailStateError(error['message']));
        } else {
          emit(ListSubjectFailStateError('Lỗi không xác định khi lấy dữ liệu'));
        }
      }
    } catch (e) {
      emit(ListSubjectFailStateError('Lỗi kết nối: $e'));
    }
  }
}

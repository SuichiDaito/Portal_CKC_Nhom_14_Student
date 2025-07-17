import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/sign_up_class_subject_model.dart';
import 'package:portal_ckc/bloc/event/class_subject_event.dart';
import 'package:portal_ckc/bloc/state/class_subject_state.dart';

class ClassSubjectBloc extends Bloc<ClassSubjectEvent, ClassSubjectState> {
  final _service = CallApiStudent.adminService;

  ClassSubjectBloc() : super(ClassSubjectStateInitial()) {
    on<RequestClassSubjectEvent>(_onRequestClassSubject);
  }

  Future<void> _onRequestClassSubject(
    RequestClassSubjectEvent event,
    Emitter emit,
  ) async {
    print(
      '➡️ Đang xử lý yêu cầu lấy danh sách các lớp mở môn mà sinh viên rớt',
    );
    emit(ClassSubjectStateLoading());
    try {
      final response = await _service.getListClassSubject(event.id_mon_hoc);

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        final classSubject = DangKyHocPhanResponse.fromJson(response.body);

        emit(ClassSubjectStateLoaded(classSubject));
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(ClassSubjectStateError(error['message']));
        } else {
          emit(ClassSubjectStateError('Lấy danh sách các lớp mở '));
        }
      }
    } catch (e, stackTrace) {
      print('❌ Lỗi yêu cầu đổi mật khẩu: $e');
      print('📌 StackTrace: $stackTrace');
      emit(ClassSubjectStateError('Lỗi hệ thống: $e'));
    }
  }
}

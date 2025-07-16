import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/bloc/event/change_response_event.dart';
import 'package:portal_ckc/bloc/state/student_response_change_password.dart';

class ResponseChangePasswordBloc
    extends Bloc<ChangeResponseEvent, StudentResponseChangePasswordStateState> {
  final service = CallApiStudent.adminService;

  ResponseChangePasswordBloc() : super(StudentResponseChangePasswordInitial()) {
    on<FetchResponseChangePassword>(_onRequestChangePassword);
  }

  Future<void> _onRequestChangePassword(
    FetchResponseChangePassword event,
    Emitter emit,
  ) async {
    print('➡️ Đang xử lý yêu cầu đổi mật khẩu');
    emit(StudentResponseChangePasswordLoading());
    try {
      final response = await service.requestPasswordReset({
        'ma_sv': event.idStudent,
        'loai': event.typeAccount,
      });

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('message')) {
            final message = body['message'];
            emit(StudentRequestChangePasswordSuccess(message));
            print(
              'AdminBloc: Emitted StudentRequestChangePasswordSuccess ${StudentRequestChangePasswordSuccess(message)}',
            ); // Debug log
          } else {
            emit(
              StudentRequestChangePasswordFail(
                'Yêu cầu đổi mật khẩu không thành công',
              ),
            );
          }
        } else {
          emit(
            StudentRequestChangePasswordFail('Phản hồi không hợp lệ từ server'),
          );
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(StudentRequestChangePasswordFail(error['message']));
        } else {
          emit(
            StudentRequestChangePasswordFail('Yêu cầu đổi mật khẩu thất bại'),
          );
        }
      }
    } catch (e, stackTrace) {
      print('❌ Lỗi yêu cầu đổi mật khẩu: $e');
      print('📌 StackTrace: $stackTrace');
      emit(StudentRequestChangePasswordFail('Lỗi hệ thống: $e'));
    }
  }
}

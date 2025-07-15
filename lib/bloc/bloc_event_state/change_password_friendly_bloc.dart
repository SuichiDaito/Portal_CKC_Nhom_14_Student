import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/bloc/event/change_password_event.dart';
import 'package:portal_ckc/bloc/state/change_password_friendly_state.dart';

class ChangePasswordFriendlyBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordFriendlyState> {
  final service = CallApiStudent.adminService;

  ChangePasswordFriendlyBloc() : super(ChangePasswordFriendlyStateInitial()) {
    on<RequestChangePass>(_onChangePassword);
  }

  Future<void> _onChangePassword(RequestChangePass event, Emitter emit) async {
    print('➡️ Đang xử lý yêu cầu đổi mật khẩu');
    emit(ChangePasswordFriendlyStateLoading());
    try {
      final response = await service.requestChangePassword({
        'current_password': event.current_password,
        'new_password': event.new_password,
        'new_password_confirmation': event.new_password_confirmation,
      });

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('message')) {
            final message = body['message'];
            emit(ChangePasswordFriendlyStateLoaded(message));
            print(
              'AdminBloc: Emitted StudentRequestChangePasswordSuccess ${ChangePasswordFriendlyStateLoaded(message)}',
            ); // Debug log
          } else {
            emit(
              ChangePasswordFriendlyStateError(
                'Yêu cầu đổi mật khẩu không thành công',
              ),
            );
          }
        } else {
          emit(
            ChangePasswordFriendlyStateError('Phản hồi không hợp lệ từ server'),
          );
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(ChangePasswordFriendlyStateError(error['message']));
        } else {
          emit(
            ChangePasswordFriendlyStateError('Yêu cầu đổi mật khẩu thất bại'),
          );
        }
      }
    } catch (e, stackTrace) {
      print('❌ Lỗi yêu cầu đổi mật khẩu: $e');
      print('📌 StackTrace: $stackTrace');
      emit(ChangePasswordFriendlyStateError('Lỗi hệ thống: $e'));
    }
  }
}

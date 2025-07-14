import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/bloc/event/logount_event.dart';
import 'package:portal_ckc/bloc/state/student_logout.dart';

class LogoutBloc extends Bloc<LogountEvent, StudentLogoutState> {
  final _services = CallApiStudent.adminService;

  LogoutBloc() : super(StudentLogoutInitial()) {
    on<FetchLogout>(_onLogout);
  }

  Future<void> _onLogout(LogountEvent event, Emitter emit) async {
    print('➡️ Đang xử lý đăng xuất');
    emit(StudentLogoutStateLoading());
    try {
      final response = await _services.logout();

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('message')) {
            final message = body['message'];
            emit(StudentLogoutStateLoaded(message));
            print(
              'AdminBloc: Emitted AdminLoaded ${StudentLogoutStateLoaded(message)}',
            ); // Debug log
          } else {
            emit(StudentLogoutStateError('Đăng xuất không thành công'));
          }
        } else {
          emit(StudentLogoutStateError('Phản hồi không hợp lệ từ server'));
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(StudentLogoutStateError(error['message']));
        } else {
          emit(StudentLogoutStateError('Đăng xuất thất bại'));
        }
      }
    } catch (e, stackTrace) {
      print('❌ Lỗi đăng xuất: $e');
      print('📌 StackTrace: $stackTrace');
      emit(StudentLogoutStateError('Lỗi hệ thống: $e'));
    }
  }
}

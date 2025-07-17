import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/bloc/event/delete_report_event.dart';
import 'package:portal_ckc/bloc/event/logount_event.dart';
import 'package:portal_ckc/bloc/event/request_state_event.dart';
import 'package:portal_ckc/bloc/state/delete_report_state.dart';
import 'package:portal_ckc/bloc/state/request_report_state.dart';
import 'package:portal_ckc/bloc/state/student_logout.dart';

class RequestReportBloc extends Bloc<RequestStateEvent, RequestReportState> {
  final _services = CallApiStudent.adminService;

  RequestReportBloc() : super(RequestReportStateInitial()) {
    on<RequestReportFromStudentEvent>(_onRequestReport);
  }

  Future<void> _onRequestReport(
    RequestReportFromStudentEvent event,
    Emitter emit,
  ) async {
    print('➡️ Đang xử lý gửi biên bản cho giáo viên ');
    emit(RequestReportStateLoading());
    try {
      final response = await _services.requestReport(event.id);

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('message')) {
            final message = body['message'];
            emit(RequestReportStateLoaded(message));
            print(
              'StudentBloc: Emitted AdminLoaded ${RequestReportStateLoaded(message)}',
            ); // Debug log
          } else {
            emit(RequestReportStateError('Xóa biên bản không thành công'));
          }
        } else {
          emit(RequestReportStateError('Phản hồi không hợp lệ từ server'));
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(RequestReportStateError(error['message']));
        } else {
          emit(RequestReportStateError('Đăng xuất thất bại'));
        }
      }
    } catch (e, stackTrace) {
      print('❌ Lỗi đăng xuất: $e');
      print('📌 StackTrace: $stackTrace');
      emit(RequestReportStateError('Lỗi hệ thống: $e'));
    }
  }
}

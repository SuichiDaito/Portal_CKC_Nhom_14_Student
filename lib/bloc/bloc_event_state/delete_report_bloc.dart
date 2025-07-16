import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/bloc/event/delete_report_event.dart';
import 'package:portal_ckc/bloc/event/logount_event.dart';
import 'package:portal_ckc/bloc/state/delete_report_state.dart';
import 'package:portal_ckc/bloc/state/student_logout.dart';

class DeleteReportBloc extends Bloc<DeleteReportEvent, DeleteReportState> {
  final _services = CallApiStudent.adminService;

  DeleteReportBloc() : super(DeleteReportStateInitial()) {
    on<DeleteReportListEvent>(_onDeleteReport);
  }

  Future<void> _onDeleteReport(
    DeleteReportListEvent event,
    Emitter emit,
  ) async {
    print('➡️ Đang xử lý xóa biên bản ');
    emit(DeleteReportStateLoading());
    try {
      final response = await _services.deleteReport(event.id);

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('message')) {
            final message = body['message'];
            emit(DeleteReportStateLoaded(message));
            print(
              'StudentBloc: Emitted AdminLoaded ${DeleteReportStateLoaded(message)}',
            ); // Debug log
          } else {
            emit(DeleteReportStateError('Xóa biên bản không thành công'));
          }
        } else {
          emit(DeleteReportStateError('Phản hồi không hợp lệ từ server'));
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(DeleteReportStateError(error['message']));
        } else {
          emit(DeleteReportStateError('Đăng xuất thất bại'));
        }
      }
    } catch (e, stackTrace) {
      print('❌ Lỗi đăng xuất: $e');
      print('📌 StackTrace: $stackTrace');
      emit(DeleteReportStateError('Lỗi hệ thống: $e'));
    }
  }
}

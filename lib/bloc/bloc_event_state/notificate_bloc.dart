import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/notification_model.dart';
import 'package:portal_ckc/bloc/event/student_notificate_event.dart';
import 'package:portal_ckc/bloc/state/notificate_state.dart';

class NotificateBloc extends Bloc<NotificateEvent, NotificateState> {
  final _service = CallApiStudent.adminService;

  NotificateBloc() : super(NotificateStateInitial()) {
    on<FetchNotificateEvent>(_onFetchNotificateEvent);
  }

  Future<void> _onFetchNotificateEvent(
    NotificateEvent event,
    Emitter emit,
  ) async {
    print('➡️ Đang xử lý lấy thông báo');
    emit(NotificateStateLoading());

    try {
      final response = await _service.getNotification();

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('data')) {
            final listJson = body['data'] as List<dynamic>;
            final notification = listJson
                .map((item) => ThongBao.fromJson(item as Map<String, dynamic>))
                .toList();

            emit(NotificateStateLoaded(notification));
          } else {
            emit(
              NotificateStateError(
                'Dữ liệu không hợp lệ: data không phải danh sách',
              ),
            );
          }
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(NotificateStateError(error['message']));
        } else {
          emit(NotificateStateError('Lỗi không xác định khi lấy dữ liệu'));
        }
      }
    } catch (e) {
      emit(NotificateStateError('Lỗi kết nối: $e'));
    }
  }
}

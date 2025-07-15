import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/notification_model.dart';
import 'package:portal_ckc/bloc/event/student_notificate_event.dart';
import 'package:portal_ckc/bloc/state/notificate_state.dart';

class NotificateBloc extends Bloc<NotificateEvent, NotificateState> {
  final _service = CallApiStudent.adminService;

  NotificateBloc() : super(NotificateStateInitial()) {
    on<FetchNotificateEvent>(_onFetchNotificateEvent);
    // on<FetchNotificationDetailEvent>(_onFetchNotificationDetail);
  }

  Future<void> _onFetchNotificateEvent(
    FetchNotificateEvent event,
    Emitter<NotificateState> emit,
  ) async {
    emit(NotificateStateLoading());
    try {
      final response = await _service.getNotification();

      if (response.isSuccessful && response.body != null) {
        final body = response.body as Map<String, dynamic>;
        final listJson = body['data'] as List<dynamic>;

        final notifications = listJson
            .map((e) => ThongBao.fromJson(e as Map<String, dynamic>))
            .toList();

        emit(NotificateStateLoaded(notifications));
      } else {
        emit(
          NotificateStateError('Lỗi API: ${response.error ?? 'Không rõ lỗi'}'),
        );
      }
    } catch (e) {
      emit(NotificateStateError('Lỗi kết nối: $e'));
    }
  }

  // Future<void> _onFetchNotificationDetail(
  //   FetchNotificationDetailEvent event,
  //   Emitter<NotificateState> emit,
  // ) async {
  //   emit(NotificateStateLoading());
  //   try {
  //     final response = await _service.getNotificationDetail(event.id);

  //     if (response.isSuccessful && response.body != null) {
  //       final body = response.body as Map<String, dynamic>;
  //       final thongBao = ThongBao.fromJson(body['data']);
  //       emit(NotificateDetailStateLoaded(thongBao));
  //     } else {
  //       emit(
  //         NotificateStateError('Lỗi API: ${response.error ?? 'Không rõ lỗi'}'),
  //       );
  //     }
  //   } catch (e) {
  //     emit(NotificateStateError('Lỗi kết nối: $e'));
  //   }
  // }
}

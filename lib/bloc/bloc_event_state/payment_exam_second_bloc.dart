import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/bloc/event/payment_exam_second.dart';
import 'package:portal_ckc/bloc/state/payment_exam_second_state.dart';

class PaymentExamSecondBloc
    extends Bloc<PaymentExamSecondEvent, PaymentExamSecondState> {
  final _service = CallApiStudent.adminService;

  PaymentExamSecondBloc() : super(PaymentExamSecondStateInitial()) {
    on<RequestPaymentExamSecond>(_onRequestPaymentExamSecond);
  }

  Future<void> _onRequestPaymentExamSecond(
    RequestPaymentExamSecond event,
    Emitter emit,
  ) async {
    print('➡️ Đang xử lý lấy payment lịch thi lần hai');
    emit(PaymentExamSecondStateLoading());

    try {
      final response = await _service.getPaymentExamSecond(event.id);

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');
        if (body is Map<String, dynamic>) {
          if (body!.containsKey('url')) {
            final String url = body['url'];
            emit(PaymentExamSecondStateLoaded(url));
          }
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(PaymentExamSecondStateError(error['message']));
        } else {
          emit(
            PaymentExamSecondStateError('Lỗi không xác định khi lấy dữ liệu'),
          );
        }
      }
    } catch (e) {
      emit(PaymentExamSecondStateError('Lỗi kết nối: $e'));
    }
  }
}

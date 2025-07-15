import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/bloc/event/payment_class_subject_event.dart';
import 'package:portal_ckc/bloc/state/payment_class_subject.dart';

class PaymentClassSubjectBloc
    extends Bloc<PaymentClassSubjectEvent, PaymentClassSubjectState> {
  final _service = CallApiStudent.adminService;

  PaymentClassSubjectBloc() : super(PaymentClassSubjectStateInitial()) {
    on<RequestPaymentClassSubjectEvent>(_onGetPayment);
  }

  Future<void> _onGetPayment(
    RequestPaymentClassSubjectEvent event,
    Emitter emit,
  ) async {
    print('➡️ Đang xử lý lấy payment đăng ký học phần');
    emit(PaymentClassSubjectStateLoading());

    try {
      final response = await _service.paymentListClassSubject(
        event.id_lop_hoc,
        {'id_mon_hoc': event.id_mon_hoc},
      );

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');
        if (body is Map<String, dynamic>) {
          if (body!.containsKey('url')) {
            final String url = body['url'];
            emit(PaymentClassSubjectStateLoaded(url));
          }
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(PaymentClassSubjectStateError(error['message']));
        } else {
          emit(
            PaymentClassSubjectStateError('Lỗi không xác định khi lấy dữ liệu'),
          );
        }
      }
    } catch (e) {
      emit(PaymentClassSubjectStateError('Lỗi kết nối: $e'));
    }
  }
}

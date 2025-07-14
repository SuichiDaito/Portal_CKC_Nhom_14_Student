import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/student_payment_model.dart';
import 'package:portal_ckc/bloc/event/payment_event.dart';
import 'package:portal_ckc/bloc/event/payment_fee_event.dart';
import 'package:portal_ckc/bloc/state/payment_fee_request_state.dart';
import 'package:portal_ckc/bloc/state/payment_state.dart';

class RequestPaymenFee
    extends Bloc<PaymentRequestFeeEvent, PaymentFeeRequestState> {
  final _service = CallApiStudent.adminService;

  RequestPaymenFee() : super(PaymentFeeRequestStateInitial()) {
    on<RequestPaymentFee>(_onRequestPayment);
  }

  Future<void> _onRequestPayment(RequestPaymentFee event, Emitter emit) async {
    print('➡️ Đang xử lý lấy url đóng tiền học phí');
    emit(PaymentFeeRequestStateLoading());

    try {
      final response = await _service.paymentFeeStudy(event.id, {
        'total_vnpay': 7700000,
      });

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');
        if (body is Map<String, dynamic>) {
          if (body!.containsKey('url')) {
            final String url = body['url'];
            emit(PaymentFeeRequestStateLoaded(url));
          }
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(PaymentFeeRequestStateError(error['message']));
        } else {
          emit(
            PaymentFeeRequestStateError('Lỗi không xác định khi lấy dữ liệu'),
          );
        }
      }
    } catch (e) {
      emit(PaymentFeeRequestStateError('Lỗi kết nối: $e'));
    }
  }
}

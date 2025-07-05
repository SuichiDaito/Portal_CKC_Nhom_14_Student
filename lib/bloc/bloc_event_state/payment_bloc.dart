import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/student_payment_model.dart';
import 'package:portal_ckc/bloc/event/payment_event.dart';
import 'package:portal_ckc/bloc/state/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final _service = CallApiStudent.adminService;

  PaymentBloc() : super(PaymentStateInitial()) {
    on<FetchPaymentEvent>(_onFetchPayment);
  }

  Future<void> _onFetchPayment(PaymentEvent event, Emitter emit) async {
    print('➡️ Đang xử lý lấy học phí');
    emit(PaymentStateLoading());

    try {
      final response = await _service.getPaymentStudentFee({'lop': 7});

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          final paymentResponse = StudentInfoModel.fromJson(
            body as Map<String, dynamic>,
          );

          emit(PaymentStateLoaded(paymentResponse));
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(PaymentStateError(error['message']));
        } else {
          emit(PaymentStateError('Lỗi không xác định khi lấy dữ liệu'));
        }
      }
    } catch (e) {
      emit(PaymentStateError('Lỗi kết nối: $e'));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/bloc/event/sign_up_certificates_event.dart';
import 'package:portal_ckc/bloc/state/sign_up_certificates_state.dart';

class SignUpCertificatesBloc
    extends Bloc<SignUpCertificatesEvent, SignUpCertificatesState> {
  final _service = CallApiStudent.adminService;

  SignUpCertificatesBloc() : super(SignUpCertificatesStateInitial()) {
    on<RequestSignupCertificatesEvent>(_onRequestSignupCertificates);
  }

  Future<void> _onRequestSignupCertificates(
    RequestSignupCertificatesEvent event,
    Emitter emit,
  ) async {
    print('➡️ Đang xử lý yêu cầu danh sách đăng ký giấy');
    emit(SignUpCertificatesStateLoading());
    try {
      final response = await _service.signupCertificates({
        'document_type': event.documentType,
      });

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('message')) {
            final message = body['message'];
            emit(SignUpCertificatesStateLoaded(message));
            print(
              'SignupCertificates: Emitted SignUpCertificatesStateLoaded ${SignUpCertificatesStateLoaded(message)}',
            ); // Debug log
          } else {
            emit(SignUpCertificatesStateError('Dữ liệu không hợp lệ'));
          }
        } else {
          emit(SignUpCertificatesStateError('Phản hồi không hợp lệ từ server'));
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(SignUpCertificatesStateError(error['message']));
        } else {
          emit(SignUpCertificatesStateError('Yêu cầu đổi mật khẩu thất bại'));
        }
      }
    } catch (e, stackTrace) {
      print('❌ Lỗi yêu cầu đổi mật khẩu: $e');
      print('📌 StackTrace: $stackTrace');
      emit(SignUpCertificatesStateError('Lỗi hệ thống: $e'));
    }
  }
}

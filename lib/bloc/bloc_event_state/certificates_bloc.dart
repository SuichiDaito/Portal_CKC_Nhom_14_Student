import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/student_certificates.dart';
import 'package:portal_ckc/bloc/event/certificates_event.dart';
import 'package:portal_ckc/bloc/state/certificates_state.dart';

class CertificatesBloc extends Bloc<CertificatesEvent, CertificatesState> {
  final _services = CallApiStudent.adminService;

  CertificatesBloc() : super(StudentReceiveListCertificatesInitial()) {
    print('🟡 CertificatesBloc CREATED');
    on<StudentReceiveCertificatesEvent>(_onReceiveCertificates);
  }

  Future<void> _onReceiveCertificates(
    StudentReceiveCertificatesEvent event,
    Emitter<CertificatesState> emit,
  ) async {
    print('➡️ Đang xử lý nhận danh sách giấy đã đăng ký');
    emit(StudentReceiveListCertificatesLoading());

    try {
      final response = await _services.getRegisteredCertificates();

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('data')) {
            final listCertificatesJson = body['data'] as List<dynamic>;
            final listCertificates = listCertificatesJson
                .map(
                  (item) => Certificates.fromJson(item as Map<String, dynamic>),
                )
                .toList();

            emit(StudentReceiveListCertificatesSuccess(listCertificates));
          } else {
            emit(
              StudentCertificatesError(
                'Dữ liệu không hợp lệ: data không phải danh sách',
              ),
            );
          }
        } else {
          emit(
            StudentCertificatesError(
              'Phản hồi không hợp lệ từ server (body không phải Map)',
            ),
          );
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(StudentCertificatesError(error['message']));
        } else {
          emit(
            StudentCertificatesError('Nhận danh sách giấy đăng ký thất bại'),
          );
        }
      }
    } catch (e, stackTrace) {
      print('❌ Lỗi nhận danh sách giấy đăng ký: $e');
      print('📌 StackTrace: $stackTrace');
      emit(StudentCertificatesError('Lỗi hệ thống: $e'));
    }
  }

  // Future<void> _onReceiveCertificates(
  //   StudentReceiveCertificatesEvent event,
  //   Emitter emit,
  // ) async {
  //   print('➡️ Đang xử lý nhận danh sách giấy đã đăng ký');
  //   emit(StudentLoading());

  //   try {
  //     final response = await service.getRegisteredCertificates();

  //     if (response.isSuccessful && response.body != null) {
  //       final body = response.body;
  //       print('📦 Status: ${response.statusCode}');
  //       print('📦 Body: ${response.body}');
  //       print('📦 Error: ${response.error}');

  //       if (body is Map<String, dynamic>) {
  //         if (body.containsKey('data')) {
  //           final listCertificatesJson = body['data'] as List<dynamic>;
  //           final listCertificates = listCertificatesJson
  //               .map(
  //                 (item) => Certificates.fromJson(item as Map<String, dynamic>),
  //               )
  //               .toList();

  //           emit(StudentReceiveListCertificatesSuccess(listCertificates));
  //           count++;
  //           print('So lan call lai event nay: ${count}');
  //         } else {
  //           emit(
  //             StudentError('Dữ liệu không hợp lệ: data không phải danh sách'),
  //           );
  //         }
  //       } else {
  //         emit(
  //           StudentError(
  //             'Phản hồi không hợp lệ từ server (body không phải Map)',
  //           ),
  //         );
  //       }
  //     } else {
  //       final error = response.error;
  //       if (error is Map<String, dynamic> && error.containsKey('message')) {
  //         emit(StudentError(error['message']));
  //       } else {
  //         emit(StudentError('Nhận danh sách giấy đăng ký thất bại'));
  //       }
  //     }
  //   } catch (e, stackTrace) {
  //     print('❌ Lỗi nhận danh sách giấy đăng ký: $e');
  //     print('📌 StackTrace: $stackTrace');
  //     emit(StudentError('Lỗi hệ thống: $e'));
  //   }
  // }
}

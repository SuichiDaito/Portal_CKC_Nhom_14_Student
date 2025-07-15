import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/student_certificates.dart';
import 'package:portal_ckc/bloc/event/student_paper_certificates_event.dart';
import 'package:portal_ckc/bloc/state/student_paper_certificates_state.dart';

class PaperCertificatesBloc
    extends Bloc<StudentPaperCertificatesEvent, StudentPaperCertificatesState> {
  final _service = CallApiStudent.adminService;

  PaperCertificatesBloc() : super(StudentPaperCertificatesInitial()) {
    print('🟡 PaperCertificatesBloc CREATED');
    on<PaperCertificatesEvent>(_onFetchPaperCertificates);
  }

  Future<void> _onFetchPaperCertificates(
    StudentPaperCertificatesEvent event,
    Emitter<StudentPaperCertificatesState> emit,
  ) async {
    print('➡️ Đang xử lý lấy danh sách giấy cần đăng ký ');
    emit(StudentPaperCertificatesLoading());

    try {
      final response = await _service.getPaperCertificates();

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('loai_giay')) {
            final listData = body['loai_giay'] as List<dynamic>;
            final papers = listData
                .map((item) => LoaiGiay.fromJson(item as Map<String, dynamic>))
                .toList();

            emit(StudentPaperCertificatesLoaded(papers));
          } else {
            emit(
              StudentPaperCertificatesError(
                'Dữ liệu không hợp lệ: data không phải danh sách',
              ),
            );
          }
        } else {
          emit(
            StudentPaperCertificatesError(
              'Phản hồi không hợp lệ từ server (body không phải Map)',
            ),
          );
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(StudentPaperCertificatesError(error['message']));
        } else {
          emit(
            StudentPaperCertificatesError('Lỗi không xác định khi lấy dữ liệu'),
          );
        }
      }
    } catch (e) {
      emit(StudentPaperCertificatesError('Lỗi kết nối: $e'));
    }
  }
}

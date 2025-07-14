import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/student_report_model.dart';
import 'package:portal_ckc/bloc/event/student_report_response_event.dart';
import 'package:portal_ckc/bloc/state/student_report_response.dart';
import 'package:portal_ckc/presentation/sections/card/feature_card_application.dart';

class StudentReportResponseBloc
    extends Bloc<StudentReportResponseEvent, StudentReportResponseState> {
  final _service = CallApiStudent.adminService;

  StudentReportResponseBloc() : super(StudentReportResponseInitial()) {
    print('🟡 StudentReportResponseBloc CREATED');
    on<FetchReportResponseEvent>(_onFetchReportResponse);
  }

  Future<void> _onFetchReportResponse(
    StudentReportResponseEvent event,
    Emitter emit,
  ) async {
    print('➡️ Đang xử lý lấy danh sách biên bản sinh hoạt');
    emit(StudentReportResponseLoading());

    try {
      final response = await _service.getReportResponse();

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('bienBanSHCN')) {
            final report = body['bienBanSHCN'];
            if (report is Map<String, dynamic>) {
              if (report.containsKey('data')) {
                final json = report['data'] as List<dynamic>;
                final reportResponses = json
                    .map(
                      (item) =>
                          BienBanItem.fromJson(item as Map<String, dynamic>),
                    )
                    .toList();

                emit(StudentReportResponseLoaded(reportResponses));
              }
            }
          } else {
            emit(
              StudentReportResponseError(
                'Dữ liệu không hợp lệ: data không phải danh sách',
              ),
            );
          }
        } else {
          emit(
            StudentReportResponseError(
              'Phản hồi không hợp lệ từ server (body không phải Map)',
            ),
          );
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(StudentReportResponseError(error['message']));
        } else {
          emit(
            StudentReportResponseError('Lỗi không xác định khi lấy dữ liệu'),
          );
        }
      }
    } catch (e) {
      emit(StudentReportResponseError('Lỗi kết nối: $e'));
    }
  }
}

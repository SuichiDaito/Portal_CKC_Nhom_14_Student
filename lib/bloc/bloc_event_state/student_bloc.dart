import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/student_certificates.dart';
import 'package:portal_ckc/api/model/student_login.dart';
import 'package:portal_ckc/api/services/student_service.dart';
import 'package:portal_ckc/bloc/event/student_event.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/constant/token.dart';
import 'package:portal_ckc/presentation/pages/page_class_detail_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentService service;

  StudentBloc()
    : service = CallApiStudent.adminService,
      super(StudentInitial()) {
    print('🟡 StudentBloc CREATED');
    on<StudentLoginEvent>(_onLogin);
  }

  Future<void> _onLogin(StudentLoginEvent event, Emitter emit) async {
    print('➡️ Đang xử lý đăng nhập');
    emit(StudentLoading());
    try {
      final response = await service.login({
        'ma_sv': event.ma_sv,
        'password': event.password,
      });

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('token')) {
            final token = body['token'] as String;

            ConstraintToken.setToken(token);
          }
          if (body.containsKey('sinh_vien')) {
            final studentJson = body['sinh_vien'] as Map<String, dynamic>;
            final student = SinhVien.fromJson(studentJson);

            // 🧠 Lưu ID vào SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setInt('student_id', student.id ?? 0);
            await prefs.setString('student_code', student.maSv ?? '');

            emit(StudentLoaded(student));
            print(
              'AdminBloc: Emitted AdminLoaded ${StudentLoaded(student)}',
            ); // Debug log
          } else {
            emit(StudentError('Phản hồi không hợp lệ: Không có key "user"'));
          }
        } else {
          emit(
            StudentError(
              'Phản hồi không hợp lệ từ server (body không phải Map)',
            ),
          );
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(StudentError(error['message']));
        } else {
          emit(StudentError('Đăng nhập thất bại'));
        }
      }
    } catch (e, stackTrace) {
      print('❌ Lỗi đăng nhập: $e');
      print('📌 StackTrace: $stackTrace');
      emit(StudentError('Lỗi hệ thống: $e'));
    }
  }
}

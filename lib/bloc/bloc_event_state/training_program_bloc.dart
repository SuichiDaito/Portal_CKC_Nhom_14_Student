import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/student_training_program_model.dart';
import 'package:portal_ckc/bloc/event/training_program_event.dart';
import 'package:portal_ckc/bloc/state/training_program_state.dart';

class TrainingProgramBloc
    extends Bloc<TrainingProgramEvent, TrainingProgramState> {
  final _service = CallApiStudent.adminService;

  TrainingProgramBloc() : super(TrainingProgramStateInitial()) {
    on<FetchTrainingProgramEvent>(_onFetchTrainingProgramEvent);
  }

  Future<void> _onFetchTrainingProgramEvent(
    TrainingProgramEvent event,
    Emitter emit,
  ) async {
    print('➡️ Đang xử lý lấy danh sách chương trình đào tạo');
    emit(TrainingProgramStateLoading());

    try {
      final response = await _service.getTrainingProgram();

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('chuong_trinh_dao_tao')) {
            final listJson = body['chuong_trinh_dao_tao'] as List<dynamic>;
            final exams = listJson
                .map(
                  (item) =>
                      ChuongTrinhDaoTao.fromJson(item as Map<String, dynamic>),
                )
                .toList();

            emit(TrainingProgramStateLoaded(exams));
          } else {
            emit(
              TrainingProgramStateError(
                'Dữ liệu không hợp lệ: data không phải danh sách',
              ),
            );
          }
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(TrainingProgramStateError(error['message']));
        } else {
          emit(TrainingProgramStateError('Lỗi không xác định khi lấy dữ liệu'));
        }
      }
    } catch (e) {
      emit(TrainingProgramStateError('Lỗi kết nối: $e'));
    }
  }
}

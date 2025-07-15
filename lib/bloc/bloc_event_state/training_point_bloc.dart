import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/model/training%20point_model.dart';
import 'package:portal_ckc/bloc/event/training_point_event.dart';
import 'package:portal_ckc/bloc/state/training_point_state.dart';

class TrainingPointBloc extends Bloc<TrainingPointEvent, TrainingPointState> {
  final _service = CallApiStudent.adminService;

  TrainingPointBloc() : super(TrainingPointInitial()) {
    print('🟡 TrainingPointBloc CREATED');
    on<FetchTrainingPointsEvent>(_onFetchTrainingPoints);
  }

  Future<void> _onFetchTrainingPoints(
    FetchTrainingPointsEvent event,
    Emitter<TrainingPointState> emit,
  ) async {
    print('➡️ Đang xử lý lấy danh sách điểm rèn luyện');
    emit(TrainingPointLoading());

    try {
      final response = await _service.getTrainingPoints();

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('data')) {
            final listData = body['data'] as List<dynamic>;
            final trainingPoints = listData
                .map(
                  (item) =>
                      ChuongTrinhDaoTao.fromJson(item as Map<String, dynamic>),
                )
                .toList();

            emit(TrainingPointLoaded(trainingPoints));
          } else {
            emit(
              TrainingPointError(
                'Dữ liệu không hợp lệ: data không phải danh sách',
              ),
            );
          }
        } else {
          emit(
            TrainingPointError(
              'Phản hồi không hợp lệ từ server (body không phải Map)',
            ),
          );
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(TrainingPointError(error['message']));
        } else {
          emit(TrainingPointError('Lỗi không xác định khi lấy dữ liệu'));
        }
      }
    } catch (e) {
      emit(TrainingPointError('Lỗi kết nối: $e'));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/bloc/event/student_comment_event.dart';
import 'package:portal_ckc/bloc/state/student_comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final _service = CallApiStudent.adminService;

  CommentBloc() : super(CommentInitial()) {
    on<AddCommentEvent>(_onAddComment);
    on<DeleteCommentEvent>(_onDeleteComment);
  }

  Future<void> _onAddComment(AddCommentEvent event, Emitter emit) async {
    emit(CommentLoading());
    try {
      final response = await _service.postComment(event.thongBaoId, {
        'noi_dung': event.noiDung,
        if (event.parentId != null) 'id_binh_luan_cha': event.parentId,
      });

      if (response.isSuccessful) {
        emit(CommentSuccess());
      } else {
        emit(CommentError('Tạo bình luận thất bại'));
      }
    } catch (e) {
      emit(CommentError('Lỗi: $e'));
    }
  }

  Future<void> _onDeleteComment(DeleteCommentEvent event, Emitter emit) async {
    emit(CommentLoading());
    try {
      final response = await _service.deleteComment(event.commentId);
      if (response.isSuccessful) {
        emit(CommentSuccess());
      } else {
        emit(CommentError('Xoá bình luận thất bại'));
      }
    } catch (e) {
      emit(CommentError('Lỗi: $e'));
    }
  }
}

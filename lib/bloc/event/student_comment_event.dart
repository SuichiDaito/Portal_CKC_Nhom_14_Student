abstract class CommentEvent {}

class AddCommentEvent extends CommentEvent {
  final int thongBaoId;
  final String noiDung;
  final int? parentId;

  AddCommentEvent({
    required this.thongBaoId,
    required this.noiDung,
    this.parentId,
  });
}

class DeleteCommentEvent extends CommentEvent {
  final int commentId;

  DeleteCommentEvent(this.commentId);
}

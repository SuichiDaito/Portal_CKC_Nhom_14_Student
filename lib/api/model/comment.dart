import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Comment {
  final int id;
  final String userName;
  final String content;
  final String timestamp;
  final int? parentId;

  List<Comment> replies;

  Comment({
    required this.id,
    required this.userName,
    required this.content,
    required this.timestamp,
    this.parentId,
    this.replies = const [],
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      parentId: json['id_binh_luan_cha'],
      userName: json['nguoi_binh_luan']?['ho_so']?['ho_ten'] ?? 'Ẩn danh',
      content: json['noi_dung'],
      timestamp: json['created_at'],
    );
  }
}

List<Comment> buildCommentTree(List<Comment> flatList) {
  final Map<int, Comment> lookup = {};
  final List<Comment> rootComments = [];

  for (var comment in flatList) {
    lookup[comment.id] = Comment(
      id: comment.id,
      userName: comment.userName,
      content: comment.content,
      timestamp: comment.timestamp,
      parentId: comment.parentId,
      replies: [],
    );
  }

  for (var comment in flatList) {
    if (comment.parentId != null) {
      final parent = lookup[comment.parentId!];
      parent?.replies.add(lookup[comment.id]!);
    } else {
      rootComments.add(lookup[comment.id]!);
    }
  }

  return rootComments;
}

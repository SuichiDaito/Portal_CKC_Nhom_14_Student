import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Comment {
  final int id;
  final String userName;
  final String content;
  final String timestamp;

  Comment({
    required this.id,
    required this.userName,
    required this.content,
    required this.timestamp,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userName: json['nguoi_binh_luan']['ho_so']['ho_ten'] ?? 'Ẩn danh',
      content: json['noi_dung'],
      timestamp: json['created_at'],
    );
  }
}


//   // factory Comment.fromJson(Map<String, dynamic> json) {
//   //   return Comment(
//   //     postId: json['postId'],
//   //     id: json['id'],
//   //     name: json['name'],
//   //     email: json['email'],
//   //     body: json['body'],
//   //   );
//   // }
// }
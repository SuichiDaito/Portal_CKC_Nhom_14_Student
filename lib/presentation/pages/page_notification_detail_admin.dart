import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/notificate_bloc.dart';
import 'package:portal_ckc/bloc/event/student_notificate_event.dart';
import 'package:portal_ckc/presentation/sections/card/notification_detail_card.dart';
import 'package:portal_ckc/presentation/sections/notification_comment_section.dart';

class NotificationDetailPage extends StatefulWidget {
  final int id;
  final String tuAi;
  final DateTime ngayGui;
  final String tieuDe;
  final String noiDung;

  const NotificationDetailPage({
    super.key,
    required this.id,
    required this.tuAi,
    required this.ngayGui,
    required this.tieuDe,
    required this.noiDung,
  });

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NotificationDetailCard(
              typeNotificationSender: widget.tuAi ?? 'Hệ thống',
              date: _formatDate(widget.ngayGui),
              headerNotification: widget.tieuDe,
              contentNotification: widget.noiDung,
              // lengthComment: tb.chiTiet.length.toString(),
              // files: tb.files
              //     .map((f) => {'ten_file': f.tenFile, 'url': f.url})
              //     .toList(),
            ),

            const SizedBox(height: 16),
            // NotificationCommentSection(
            //   lengthComment: '${comments.length}',
            //   commentController: _commentController,
            //   idThongBao: tb.id,
            //   onPressed: () {
            //     //BÌNH LUẬN MỚI
            //     final content = _commentController.text.trim();
            //     if (content.isNotEmpty) {
            //       context.read<ThongBaoBloc>().add(
            //         CreateCommentEvent(
            //           thongBaoId: widget.id,
            //           noiDung: content,
            //         ),
            //       );

            //       _commentController.clear();
            //     }
            //   },

            //   comments: comments,
            // ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.pop(true),
      ),
      title: const Text(
        'Chi Tiết Thông Báo',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.bookmark_border, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}

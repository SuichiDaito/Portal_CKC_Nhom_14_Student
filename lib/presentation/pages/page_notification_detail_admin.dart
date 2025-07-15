import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/notification_model.dart';
import 'package:portal_ckc/bloc/bloc_event_state/notificate_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_comment_bloc.dart';
import 'package:portal_ckc/bloc/event/student_comment_event.dart';
import 'package:portal_ckc/bloc/event/student_notificate_event.dart';
import 'package:portal_ckc/bloc/state/notificate_state.dart';
import 'package:portal_ckc/bloc/state/student_comment_state.dart';
import 'package:portal_ckc/presentation/sections/card/notification_detail_card.dart';
import 'package:portal_ckc/presentation/sections/notification_comment_section.dart';

class NotificationDetailPage extends StatefulWidget {
  final int id;

  const NotificationDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('Gửi FetchNotificationDetailEvent với id = ${widget.id}');
    context.read<NotificateBloc>().add(FetchNotificationDetailEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: BlocListener<NotificateBloc, NotificateState>(
        listener: (context, state) {
          if (state is NotificateStateError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('❌ ${state.message}')));
          }
        },
        child: BlocListener<CommentBloc, CommentState>(
          listener: (context, commentState) {
            if (commentState is CommentSuccess) {
              context.read<NotificateBloc>().add(FetchNotificateEvent());

              _commentController.clear();
            }
          },
          child: BlocBuilder<NotificateBloc, NotificateState>(
            builder: (context, state) {
              print("======= Bắt đầu BlocBuilder =======");

              if (state is NotificateStateLoading) {
                print("===========Load==========");
                return const Center(child: CircularProgressIndicator());
              } else if (state is NotificateStateLoaded) {
                final allNotifications = state.notifications;

                ThongBao? tb;
                for (var e in allNotifications) {
                  if (e.id == widget.id) {
                    tb = e;
                    break;
                  }
                }

                if (tb == null) {
                  return const Center(
                    child: Text("❌ Không tìm thấy thông báo."),
                  );
                }

                final comments = tb.binhLuans;
                final rootComments = tb.binhLuans
                    .where((e) => e.idBinhLuanCha == null)
                    .toList();

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      NotificationDetailCard(
                        typeNotificationSender: tb.tuAi ?? 'Hệ thống',
                        date: _formatDate(tb.ngayGui),
                        headerNotification: tb.tieuDe,
                        contentNotification: tb.noiDung,
                        lengthComment: tb.chiTiet.length.toString(),
                        files: tb.files
                            .map((f) => {'ten_file': f.tenFile, 'url': f.url})
                            .toList(),
                        id: tb.id,
                      ),
                      const SizedBox(height: 16),
                      NotificationCommentSection(
                        lengthComment: '${comments.length}',
                        commentController: _commentController,
                        idThongBao: tb.id,
                        onPressed: () {
                          final content = _commentController.text.trim();
                          if (content.isNotEmpty) {
                            context.read<CommentBloc>().add(
                              AddCommentEvent(
                                thongBaoId: widget.id,
                                noiDung: content,
                              ),
                            );
                            _commentController.clear();
                          }
                        },
                        comments: comments,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              } else if (state is NotificateStateError) {
                return Center(child: Text('❌ ${state.message}'));
              } else {
                return const Center(
                  child: Text(
                    'Không thể truy cập chức năng này, vui lòng thử lại sau.',
                  ),
                );
              }
            },
          ),
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

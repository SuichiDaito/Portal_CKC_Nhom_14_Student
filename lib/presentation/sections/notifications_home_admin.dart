import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/notification_model.dart';
import 'package:portal_ckc/presentation/pages/page_notification_detail_admin.dart';
import 'package:portal_ckc/presentation/sections/card/notification_card.dart';

class NotificationsHomeAdmin extends StatefulWidget {
  final String typeNotification;
  final List<ThongBao> notifications;
  final VoidCallback? onReload;

  const NotificationsHomeAdmin({
    super.key,
    required this.typeNotification,
    required this.notifications,
    this.onReload,
  });

  @override
  State<NotificationsHomeAdmin> createState() => _NotificationsHomeAdmin();
}

class _NotificationsHomeAdmin extends State<NotificationsHomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.typeNotification,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.notifications.length,
          itemBuilder: (context, index) {
            final tb = widget.notifications[index];
            return Column(
              children: [
                NotificationCard(
                  title: tb.tieuDe,
                  content: tb.noiDung,
                  date: _formatDate(tb.ngayGui),
                  bgColor: Colors.blue[100]!,
                  buttonColor: Colors.blue,

                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 1), () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              NotificationDetailPage(id: tb.id),
                        ),
                      );
                    });
                  },
                ),
                const SizedBox(height: 15),
              ],
            );
          },
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

}

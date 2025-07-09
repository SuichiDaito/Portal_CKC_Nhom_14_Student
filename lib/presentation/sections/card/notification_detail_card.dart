import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/presentation/sections/notification_content_detail.dart';
import 'package:portal_ckc/presentation/sections/notification_footer_detail.dart';
import 'package:portal_ckc/presentation/sections/notification_sender_information_detail.dart';

class NotificationDetailCard extends StatelessWidget {
  final String typeNotificationSender;
  final String date;
  final String headerNotification;
  final String contentNotification;
  // final String lengthComment;
  // final List<Map<String, String>>
  // files; // [{ten_file: 'abc.pdf', url: 'storage/thong_bao/abc.pdf'}, ...]

  const NotificationDetailCard({
    Key? key,
    required this.typeNotificationSender,
    required this.date,
    required this.headerNotification,
    required this.contentNotification,
    // required this.lengthComment,
    // required this.files,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(context),
      body: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationSenderInformationDetail(
              typeNotificationSender: typeNotificationSender,
              date: date,
            ),
            NotificationContentDetail(
              headerNotification: headerNotification,
              linkImage: '',
              contentNotification: contentNotification,
            ),
            // if (files.isNotEmpty)
            //   Padding(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 16.0,
            //       vertical: 8,
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Text(
            //           'File đính kèm:',
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //         const SizedBox(height: 8),
            //         ...files.map(
            //           (file) => GestureDetector(
            //             onTap: () {
            //               // Mở file (hoặc tải xuống) tùy logic của bạn
            //               // Ví dụ mở URL nếu là PDF, Word, v.v.
            //               final url =
            //                   'https://yourdomain.com/storage/${file['url']}';
            //               // sử dụng url_launcher để mở URL
            //             },
            //             child: Text(
            //               file['ten_file'] ?? '',
            //               style: const TextStyle(
            //                 color: Colors.blue,
            //                 decoration: TextDecoration.underline,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // NotificationFooterDetail(lengthComment: lengthComment),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
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
}

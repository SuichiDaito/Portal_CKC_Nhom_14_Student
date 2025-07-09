import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/notification_model.dart';
import 'package:portal_ckc/bloc/bloc_event_state/notificate_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/student_event.dart';
import 'package:portal_ckc/bloc/event/student_notificate_event.dart';
import 'package:portal_ckc/bloc/state/notificate_state.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/presentation/pages/page_notification_detail_admin.dart';
import 'package:portal_ckc/presentation/sections/grid_app_home_admin.dart';
import 'package:portal_ckc/presentation/sections/header_and_card_student_info.dart';
import 'package:portal_ckc/presentation/sections/header_home_admin_section.dart';
import 'package:portal_ckc/presentation/sections/notifications_home_admin.dart';
import 'package:portal_ckc/presentation/sections/user_profile_card_home_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLayoutHomeAdminPage extends StatefulWidget {
  const MainLayoutHomeAdminPage({super.key});
  @override
  State<MainLayoutHomeAdminPage> createState() =>
      _MainLayoutHomeAdminPageState();
}

class _MainLayoutHomeAdminPageState extends State<MainLayoutHomeAdminPage> {
  String selectedFilter = 'Tất cả';
  String? _nameUser;
  List<ThongBao> khoaNoti = [];
  List<ThongBao> phongNoti = [];

  @override
  void initState() {
    super.initState();
    context.read<NotificateBloc>().add(FetchNotificateEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderAndCardStudentInfo(),

            const SizedBox(height: 20),

            _buildFilterTabs(),
            const SizedBox(height: 10),

            // Thông báo
            BlocListener<NotificateBloc, NotificateState>(
              listener: (context, state) {
                if (state is NotificateStateError) {
                  final message = 'Bạn không có quyền truy cập thông báo này';

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: BlocBuilder<NotificateBloc, NotificateState>(
                builder: (context, state) {
                  if (state is NotificateStateLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  } else if (state is NotificateStateLoaded) {
                    final now = DateTime.now();

                    final khoaNoti = state.notifications
                        .where((e) => e.tuAi == 'khoa' && e.trangThai == 1)
                        .toList();
                    final phongNoti = state.notifications
                        .where(
                          (e) => e.tuAi == 'phong_ctct' && e.trangThai == 1,
                        )
                        .toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (selectedFilter == 'Tất cả' ||
                            selectedFilter == 'Khoa')
                          khoaNoti.isNotEmpty
                              ? NotificationsHomeAdmin(
                                  typeNotification: 'Thông báo khoa',
                                  notifications: khoaNoti,
                                  onReload: () {
                                    setState(() {});
                                    context.read<NotificateBloc>().add(
                                      FetchNotificateEvent(),
                                    );
                                  },
                                )
                              : const Text('📭 Chưa có thông báo khoa'),

                        if (selectedFilter == 'Tất cả' ||
                            selectedFilter == 'Phòng Công Tác Chính Trị')
                          phongNoti.isNotEmpty
                              ? NotificationsHomeAdmin(
                                  typeNotification: 'Thông báo phòng ctct',
                                  notifications: phongNoti,
                                  onReload: () {
                                    setState(() {});
                                    context.read<NotificateBloc>().add(
                                      FetchNotificateEvent(),
                                    );
                                  },
                                )
                              : const Text('Chưa có thông báo phòng ctct'),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['Tất cả', 'Khoa', 'Phòng Công Tác Chính Trị'];

    return Container(
      color: const Color.fromARGB(255, 243, 241, 241),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            final isSelected = selectedFilter == filter;
            return Padding(
              padding: EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue[600] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.blue[600]! : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    filter,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// class MainLayoutHomeAdminPage extends StatefulWidget {
//   const MainLayoutHomeAdminPage({super.key});
//   State<MainLayoutHomeAdminPage> createState() => _MainLayoutHomeAdminPage();
// }

// class _MainLayoutHomeAdminPage extends State<MainLayoutHomeAdminPage> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header Section
//           SizedBox(height: 10),
//           HeaderAndCardStudentInfo(),
//           // GridAppHomeAdmin(),
//           SizedBox(height: 15),

//           // Latest Notifications Section
//           NotificationsHomeAdmin(
//             typeNotification: 'Thông báo khoa',
//             contentNotification: 'Thông báo mới nhất',
//             date: '24/06/2025',
//           ),
//         ],
//       ),
//     );
//   }
// }

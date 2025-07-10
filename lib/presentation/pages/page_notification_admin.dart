import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/notificate_bloc.dart';
import 'package:portal_ckc/bloc/event/student_notificate_event.dart';
import 'package:portal_ckc/bloc/state/notificate_state.dart';
import 'package:portal_ckc/presentation/sections/notifications_home_admin.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String selectedFilter = 'Tất cả';

  @override
  void initState() {
    super.initState();
    context.read<NotificateBloc>().add(FetchNotificateEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotificateBloc, NotificateState>(
        builder: (context, state) {
          if (state is NotificateStateLoading) {
            print('➡️ Đang xử lý lấy thông báo');

            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is NotificateStateLoaded) {
            print('Tổng số thông báo: ${state.notifications.length}');
            for (var e in state.notifications) {
              print('tuAi: ${e.tuAi}, trangThai: ${e.trangThai}');
            }

            final khoaNoti = state.notifications
                .where((e) => e.tuAi == 'khoa' && e.trangThai == 1)
                .toList();
            final ctctNoti = state.notifications
                .where((e) => e.tuAi == 'phong_ctct' && e.trangThai == 1)
                .toList();

            return Column(
              children: [
                _buildFilterTabs(),
                Expanded(
                  child: SingleChildScrollView(
                    key: ValueKey(state.notifications.length),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (selectedFilter == 'Tất cả' ||
                            selectedFilter == 'Khoa')
                          NotificationsHomeAdmin(
                            typeNotification: 'Thông báo khoa',
                            key: ValueKey('khoa-${state.notifications.length}'),
                            notifications: khoaNoti,
                            onReload: () {
                              context.read<NotificateBloc>().add(
                                FetchNotificateEvent(),
                              );
                            },
                          ),
                        if (selectedFilter == 'Tất cả' ||
                            selectedFilter == 'Phòng Công Tác Chính Trị')
                          NotificationsHomeAdmin(
                            typeNotification: 'phong_ctct',
                            notifications: ctctNoti,
                            onReload: () {
                              context.read<NotificateBloc>().add(
                                FetchNotificateEvent(),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('Không có dữ liệu'));
        },
      ),
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['Tất cả', 'Khoa', 'Phòng Công Tác Chính Trị'];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            final isSelected = selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
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

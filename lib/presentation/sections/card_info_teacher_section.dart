import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/info_teacher_bloc.dart';
import 'package:portal_ckc/bloc/event/info_teacher_event.dart';
import 'package:portal_ckc/bloc/state/info_teacher_state.dart';

class CardInfoTeacherSection extends StatefulWidget {
  CardInfoTeacherSection({super.key});
  @override
  State<CardInfoTeacherSection> createState() => CardInfo();
}

class CardInfo extends State<CardInfoTeacherSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<InfoTeacherBloc>().add(FetchInfoTeacher());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoTeacherBloc, InfoTeacherState>(
      builder: (context, state) {
        if (state is InfoTeacherStateLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.blue));
        } else if (state is InfoTeacherStateLoaded) {
          final teachers = state.teachers;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with icon
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.blue.shade700,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Thông tin giảng viên',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  'Khoa CNTT',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Lecturer Information
                        _buildInfoRow('Họ và tên:', teachers[index].hoSo.hoTen),
                        const SizedBox(height: 8),
                        _buildInfoRow('Email:', teachers[index].hoSo.email),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          'Số điện thoại:',
                          teachers[index].hoSo.soDienThoai,
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is InfoTeacherStateError) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text('NOT FOUND | 404'));
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

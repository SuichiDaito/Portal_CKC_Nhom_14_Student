import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/student_event.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';

class CardStudentInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.person, color: Colors.white, size: 24),
        SizedBox(width: 8),
        Expanded(
          child: BlocBuilder<StudentBloc, StudentState>(
            builder: (context, state) {
              if (state is StudentLoading) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              } else if (state is StudentLoaded) {
                final student = state.student;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.hoSo!.hoTen,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${student.maSv} - ${student.danhSachSinhVien.last!.lop.tenLop}',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                );
              } else if (state is StudentError) {
                return Center(child: Text(state.message));
              }
              return Center(child: Text('NOT FOUND | 404'));
            },
          ),
        ),
      ],
    );
  }
}

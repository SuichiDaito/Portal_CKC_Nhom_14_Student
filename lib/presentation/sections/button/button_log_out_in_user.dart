import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/logoutn_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/logount_event.dart' show FetchLogout;
import 'package:portal_ckc/bloc/event/student_event.dart';
import 'package:portal_ckc/constant/token.dart';

class ButtonLogOutInUser extends StatelessWidget {
  int id1 = 0;
  int id2 = 0;
  @override
  Widget build(BuildContext context) {
    Future<void> getSetIds() async {
      ConstraintToken.setIdSpecialized1('');
      ConstraintToken.setIdSpecialized2('');

      Future<String> stringFuture = ConstraintToken.getIdSpecialized1();
      String string = await stringFuture;

      Future<String> stringFuture2 = ConstraintToken.getIdSpecialized2();
      String string2 = await stringFuture;

      try {
        id1 = int.parse(string);
      } catch (e) {
        print("Lỗi chuyển đổi: $e");
        id1 = 0;
      }
      try {
        id2 = int.parse(string2);
      } catch (e) {
        print("Lỗi chuyển đổi: $e");
        id2 = 0;
      }
      print('Đã lấy được id chuyên ngành: $string $string2');
    }

    return ElevatedButton.icon(
      onPressed: () {
        context.read<LogoutBloc>().add(FetchLogout());
        context.go('/login');
        getSetIds();
      },
      icon: const Icon(Icons.logout),
      label: const Text('Đăng xuất'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff347433),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    );
  }
}

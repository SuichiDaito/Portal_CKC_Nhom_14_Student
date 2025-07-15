import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/sign_up_certificates_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/sign_up_certificates_event.dart';
import 'package:portal_ckc/bloc/state/sign_up_certificates_state.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/presentation/sections/card/student_card_info.dart';
import 'package:portal_ckc/presentation/sections/certificates_option_card.dart';
import 'package:portal_ckc/presentation/sections/dialogs/snack_bar_scaffold.dart';

class CertificateRegistrationScreen extends StatefulWidget {
  @override
  _CertificateRegistrationScreenState createState() =>
      _CertificateRegistrationScreenState();
}

class _CertificateRegistrationScreenState
    extends State<CertificateRegistrationScreen> {
  List<int> selectedId = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Đăng ký giấy xác nhận',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocConsumer<SignUpCertificatesBloc, SignUpCertificatesState>(
        listener: (context, state) {
          if (state is SignUpCertificatesStateLoaded) {
            SnackBarScaffold.showToast(
              'Đăng ký giấy xác nhận thành công!',
              false,
              context,
            );
            selectedId = [];
            return;
          } else if (state is SignUpCertificatesStateError) {
            SnackBarScaffold.showToast(
              'Đăng ký giấy xác nhận thất bại!',
              true,
              context,
            );
            selectedId = [];
            return;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Student Info Card
                StudentCardInfo(),
                SizedBox(height: 20),
                // Certificate Selection Section
                Text(
                  'Chọn loại giấy cần đăng ký',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(child: CertificatesOptionCard(selectedId: selectedId)),
                // Submit Button
              ],
            ),
          );
        },
      ),
    );
    ;
  }
}

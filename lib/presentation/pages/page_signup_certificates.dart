import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/presentation/sections/card/student_card_info.dart';
import 'package:portal_ckc/presentation/sections/certificates_option_card.dart';

class CertificateRegistrationScreen extends StatefulWidget {
  @override
  _CertificateRegistrationScreenState createState() =>
      _CertificateRegistrationScreenState();
}

class _CertificateRegistrationScreenState
    extends State<CertificateRegistrationScreen> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Student Info Card
              StudentCardInfo(),
              // Certificate Selection Section
              Text(
                'Chọn loại giấy cần đăng ký',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 24),
              CertificatesOptionCard(),
              // Submit Button
            ],
          ),
        ),
      ),
    );
    ;
  }
}

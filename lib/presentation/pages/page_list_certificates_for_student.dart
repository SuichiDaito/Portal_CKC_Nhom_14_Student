import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/bloc/bloc_event_state/certificates_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/certificates_event.dart';
import 'package:portal_ckc/bloc/event/student_event.dart';
import 'package:portal_ckc/bloc/state/certificates_state.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/presentation/sections/card/document_card_certificates.dart';

class DocumentListPage extends StatefulWidget {
  DocumentListPage({super.key});

  @override
  State<DocumentListPage> createState() => _DocumentListPageState();
}

class _DocumentListPageState extends State<DocumentListPage> {
  @override
  void initState() {
    super.initState();
    context.read<CertificatesBloc>().add(StudentReceiveCertificatesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/apps');
          },
        ),
        title: const Text(
          'Danh sách giấy xác nhận',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<CertificatesBloc, CertificatesState>(
        builder: (context, state) {
          if (state is StudentReceiveListCertificatesLoading) {
            print('state is StudentReceiveListCertificatesLoading ${state}');
            return Center(
              child: CircularProgressIndicator(color: Colors.blue[600]),
            );
          } else if (state is StudentReceiveListCertificatesSuccess) {
            print('state is StudentReceiveListCertificatesSuccess ${state}');
            final certificates = state.certificates;
            if (certificates.isEmpty) {
              return Center(
                child: Text(
                  'Không có giấy xác nhận nào.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Danh sách giấy tờ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: certificates.length,
                    itemBuilder: (context, index) {
                      final certificate = certificates[index];
                      return DocumentCard(
                        title: certificate?.loaiGiay?.tenGiay ?? '',
                        dateRegistration: certificate.ngayDangKy != null
                            ? 'Ngày đăng ký: ${certificate?.ngayDangKy}'
                            : 'Ngày đăng ký: Chưa có',
                        dateReceive: certificate.ngayNhan != null
                            ? 'Ngày nhận: ${certificate?.ngayNhan}'
                            : 'Ngày nhận: Chưa có',
                        status: int.parse(certificate.trangThai ?? '0'),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is StudentCertificatesError) {
            print('state is StudentCertificatesError ${state}');
            return Center(
              child: Text(
                'Lỗi khi tải dữ liệu: ${state.message}',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          } else {
            return Center(
              child: Text(
                'NOT FOUND | 404',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            );
          }
        },
      ),
    );
  }
}

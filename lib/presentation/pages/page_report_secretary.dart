import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/student_report_model.dart';
import 'package:portal_ckc/bloc/bloc_event_state/delete_report_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/request_report_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_report_response_bloc.dart';
import 'package:portal_ckc/bloc/event/delete_report_event.dart';
import 'package:portal_ckc/bloc/event/request_state_event.dart';
import 'package:portal_ckc/bloc/event/student_report_response_event.dart';
import 'package:portal_ckc/bloc/state/student_report_response.dart';
import 'package:portal_ckc/presentation/pages/page_report_secretary.dart';

class BienBanListScreen extends StatefulWidget {
  @override
  _BienBanListScreenState createState() => _BienBanListScreenState();
}

class _BienBanListScreenState extends State<BienBanListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<StudentReportResponseBloc>().add(FetchReportResponseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Danh sách biên bản sinh hoạt',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/apps'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Nút tạo biên bản ở trên
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () {
                  context.push('/student/create/report/class');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Tạo biên bản mới',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Danh sách biên bản
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Danh sách biên bản đã tạo',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 25),
              ],
            ),
            const SizedBox(height: 10),
            BlocBuilder<StudentReportResponseBloc, StudentReportResponseState>(
              builder: (context, state) {
                if (state is StudentReportResponseLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                } else if (state is StudentReportResponseLoaded) {
                  final bienBanList = state.reportResponseList;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: bienBanList.length,
                      itemBuilder: (context, index) {
                        final item = bienBanList[index];
                        return BienBanCard(
                          bienBan: item,
                          onEdit: () => _editBienBan(index),
                          onSend: () =>
                              _sendBienBan(bienBanList[index].id ?? 0),
                          onDelete: () => _deleteBienBan(item.id ?? 0),
                        );
                      },
                    ),
                  );
                } else if (state is StudentReportResponseError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('NOT FOUND | 404'));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editBienBan(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Chỉnh sửa: bien bản'),
        backgroundColor: Colors.blue[600],
      ),
    );
  }

  void _sendBienBan(int index) {
    context.read<RequestReportBloc>().add(RequestReportFromStudentEvent(index));

    setState(() {
      context.read<StudentReportResponseBloc>().add(FetchReportResponseEvent());
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Biên bản đã được gửi cho giảng viên'),
        backgroundColor: Colors.green[600],
      ),
    );
  }

  void _deleteBienBan(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa biên bản này?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy', style: TextStyle(color: Colors.grey[600])),
            ),
            TextButton(
              onPressed: () {
                context.read<DeleteReportBloc>().add(
                  DeleteReportListEvent(index),
                );
                setState(() {
                  context.read<StudentReportResponseBloc>().add(
                    FetchReportResponseEvent(),
                  );
                });

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Đã xóa biên bản'),
                    backgroundColor: Colors.red[600],
                  ),
                );
              },
              child: Text('Xóa', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

extension on DeleteReportBloc Function() {
  void add(DeleteReportListEvent deleteReportListEvent) {}
}

class BienBanCard extends StatelessWidget {
  final BienBanItem bienBan;
  final VoidCallback onEdit;
  final VoidCallback onSend;
  final VoidCallback onDelete;

  const BienBanCard({
    Key? key,
    required this.bienBan,
    required this.onEdit,
    required this.onSend,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      bienBan.tieuDe ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    'Ngày tạo: ${formatIsoToDate(bienBan.createdAt ?? "") ?? ""}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getTrangThaiColor(bienBan.trangThai ?? 4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getTrangThaiText(bienBan.trangThai ?? 4),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.edit,
                    label: 'Sửa',
                    onTap: onEdit,
                    color: Colors.blue[600]!,
                  ),
                  _buildActionButton(
                    icon: Icons.send,
                    label: 'Gửi',
                    onTap: onSend,
                    color: Colors.green[600]!,
                  ),
                  _buildActionButton(
                    icon: Icons.delete,
                    label: 'Xóa',
                    onTap: onDelete,
                    color: Colors.red[600]!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTrangThaiColor(int trangThai) {
    switch (trangThai) {
      case 0: // sinh viên tạo
        return Colors.orange[600]!;
      case 1: // gửi giáo viên, giáo viên tạo
        return Colors.blue[600]!;
      case 2: //phòng ctct nhận đc
        return Colors.green[600]!;
      default:
    }
    return Colors.grey; // Default color if none match
  }

  String _getTrangThaiText(int trangThai) {
    switch (trangThai) {
      case 0:
        return 'Đã tạo';
      case 1:
        return 'Đã gửi giáo viên';
      case 2:
        return 'Phòng ctct đã nhận';
      default:
        return 'Không xác định';
    }
  }
}

String? formatIsoToDate(String isoDateStr) {
  DateTime parsedDate = DateTime.parse(
    isoDateStr,
  ).toLocal(); // Chuyển về giờ địa phương nếu cần
  return DateFormat('dd/MM/yyyy').format(parsedDate);
}

import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/pages/page_exam_schedule_admin.dart';

class ExamDutyCard extends StatelessWidget {
  final String nameSubject;
  final String nameLecture1;
  final String nameLecture2;
  final String dateExam;
  final String beginTime;
  final int distanceTime;
  final String nameRoom;
  final int examTimes;
  const ExamDutyCard({
    required this.nameSubject,
    required this.nameLecture1,
    required this.nameLecture2,
    required this.dateExam,
    required this.beginTime,
    required this.distanceTime,
    required this.nameRoom,
    required this.examTimes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue),
            ),
            child: Text(
              nameSubject,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Icon(Icons.supervisor_account, color: Colors.blue[700], size: 18),
              SizedBox(width: 6),
              Text(
                '${nameLecture1} & ${nameLecture2}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Ngày thi: ${dateExam}'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Bắt đầu: ${beginTime} | ${distanceTime} phút'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.meeting_room, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Phòng: ${nameRoom}'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.add_circle_outlined,
                size: 16,
                color: Colors.grey[600],
              ),
              SizedBox(width: 6),
              Text('Lần thi: ${examTimes}'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.check_circle, size: 16, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('Trạng thái: chưa có'),
            ],
          ),
        ],
      ),
    );
  }
}

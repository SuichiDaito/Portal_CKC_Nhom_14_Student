import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/training_point_bloc.dart';
import 'package:portal_ckc/bloc/event/training_point_event.dart';
import 'package:portal_ckc/bloc/state/training_point_state.dart';
import 'package:portal_ckc/presentation/sections/conduct_evaluation_student_section.dart';

class PageConductEvaluationAdmin extends StatefulWidget {
  const PageConductEvaluationAdmin({super.key});

  @override
  State<PageConductEvaluationAdmin> createState() =>
      _PageConductEvaluationAdminState();
}

class _PageConductEvaluationAdminState
    extends State<PageConductEvaluationAdmin> {
  void initState() {
    super.initState();
    // You can add any initialization logic here if needed
    context.read<TrainingPointBloc>().add(FetchTrainingPointsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Bảng điểm rèn luyện',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1976D2),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<TrainingPointBloc, TrainingPointState>(
        builder: (context, state) {
          if (state is TrainingPointLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.blue[600]),
            );
          } else if (state is TrainingPointLoaded) {
            // Handle the loaded state and display the training points
            return ListView.builder(
              itemCount: state.trainingPoints.length,
              itemBuilder: (context, index) {
                final trainingPoint = state.trainingPoints[index];
                return ConductEvaluationStudentSection(
                  month: trainingPoint.month,
                  year: trainingPoint.years.startYear,
                  typePoint: trainingPoint.typePoint,
                );
              },
            );
          } else {
            return Center(child: Text('Không có dữ liệu'));
          }
        },
      ),
    );
  }
}

import 'package:portal_ckc/api/model/student_training_program_model.dart';

abstract class TrainingProgramState {}

class TrainingProgramStateInitial extends TrainingProgramState {}

class TrainingProgramStateLoading extends TrainingProgramState {}

class TrainingProgramStateLoaded extends TrainingProgramState {
  final List<ChuongTrinhDaoTao> trainingPrograms;

  TrainingProgramStateLoaded(this.trainingPrograms);
}

class TrainingProgramStateError extends TrainingProgramState {
  final String message;

  TrainingProgramStateError(this.message);
}

class TrainingProgramStateSuccess extends TrainingProgramState {
  final String message;

  TrainingProgramStateSuccess(this.message);
}

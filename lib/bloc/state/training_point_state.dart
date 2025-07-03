import 'package:portal_ckc/api/model/training%20point_model.dart';

abstract class TrainingPointState {}

class TrainingPointInitial extends TrainingPointState {}

class TrainingPointLoading extends TrainingPointState {}

class TrainingPointLoaded extends TrainingPointState {
  final List<TrainingPointModel> trainingPoints;

  TrainingPointLoaded(this.trainingPoints);
}

class TrainingPointError extends TrainingPointState {
  final String message;

  TrainingPointError(this.message);
}

class TrainingPointSuccess extends TrainingPointState {
  final String message;

  TrainingPointSuccess(this.message);
}

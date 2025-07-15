abstract class StudentLogoutState {}

class StudentLogoutInitial extends StudentLogoutState {}

class StudentLogoutStateLoading extends StudentLogoutState {}

class StudentLogoutStateLoaded extends StudentLogoutState {
  final String message;

  StudentLogoutStateLoaded(this.message);
}

class StudentLogoutStateError extends StudentLogoutState {
  final String message;

  StudentLogoutStateError(this.message);
}

abstract class ChangePasswordFriendlyState {}

class ChangePasswordFriendlyStateInitial extends ChangePasswordFriendlyState {}

class ChangePasswordFriendlyStateLoading extends ChangePasswordFriendlyState {}

class ChangePasswordFriendlyStateLoaded extends ChangePasswordFriendlyState {
  final String message;
  ChangePasswordFriendlyStateLoaded(this.message);
}

class ChangePasswordFriendlyStateError extends ChangePasswordFriendlyState {
  final String message;

  ChangePasswordFriendlyStateError(this.message);
}

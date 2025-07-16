abstract class StudentResponseChangePasswordStateState {}

class StudentResponseChangePasswordInitial
    extends StudentResponseChangePasswordStateState {}

class StudentResponseChangePasswordLoading
    extends StudentResponseChangePasswordStateState {}

class StudentRequestChangePasswordSuccess
    extends StudentResponseChangePasswordStateState {
  final String message;

  StudentRequestChangePasswordSuccess(this.message);
}

class StudentRequestChangePasswordFail
    extends StudentResponseChangePasswordStateState {
  final String message;

  StudentRequestChangePasswordFail(this.message);
}

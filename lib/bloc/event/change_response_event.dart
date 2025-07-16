abstract class ChangeResponseEvent {}

class FetchResponseChangePassword extends ChangeResponseEvent {
  final String idStudent;
  final int typeAccount;

  FetchResponseChangePassword({
    required this.idStudent,
    required this.typeAccount,
  });
}

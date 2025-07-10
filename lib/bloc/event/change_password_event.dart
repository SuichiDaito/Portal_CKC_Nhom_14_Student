abstract class ChangePasswordEvent {}

class RequestChangePass extends ChangePasswordEvent {
  final String current_password;
  final String new_password;
  final String new_password_confirmation;

  RequestChangePass({
    required this.current_password,
    required this.new_password,
    required this.new_password_confirmation,
  });
}

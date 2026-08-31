abstract class UserEvent {}

class LoginRequested extends UserEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class RegisterRequested extends UserEvent {
  final String name;
  final String email;
  final String password;

  RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
  });
}

class ContinueWithGoogleRequested extends UserEvent {}

class LogoutRequested extends UserEvent {}

class ResetPasswordRequested extends UserEvent {
  final String email;

  ResetPasswordRequested({required this.email});
}

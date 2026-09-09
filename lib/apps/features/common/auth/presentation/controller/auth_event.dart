import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';

abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final UserRoles role;
  final String email;
  final String password;

  LoginRequested({
    required this.email,
    required this.password,
    required this.role,
  });
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
  });
}

class ContinueWithGoogleRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class ResetPasswordRequested extends AuthEvent {
  final String email;

  ResetPasswordRequested({required this.email});
}

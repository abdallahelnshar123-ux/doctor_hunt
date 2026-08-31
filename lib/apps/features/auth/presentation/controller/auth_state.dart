
import 'package:equatable/equatable.dart';
import '../../data/models/user/my_user.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends AuthState {}

/// ===================  Auth States  =======================
class LoginWithEmailPasswordLoadingState extends AuthState {}

class LoginWithEmailPasswordErrorState extends AuthState {
  final String message;

  LoginWithEmailPasswordErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class RegisterWithEmailPasswordLoadingState extends AuthState {}

class RegisterWithEmailPasswordErrorState extends AuthState {
  final String message;

  RegisterWithEmailPasswordErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class ContinueWithGoogleLoadingState extends AuthState {}

class ContinueWithGoogleErrorState extends AuthState {
  final String message;

  ContinueWithGoogleErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class LogoutLoadingState extends AuthState {}

class LogoutErrorState extends AuthState {
  final String message;

  LogoutErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class UserAuthenticatedState extends AuthState {
  final MyUser? currentUser;

  UserAuthenticatedState(this.currentUser);

  @override
  List<Object?> get props => [currentUser];
}

class UserUnauthenticatedState extends AuthState {}

// /// ======================   update states   ======================
// class UserDetailsUpdateLoadingState extends AuthState {
//   @override
//   List<Object?> get props => [];
// }
//
// class UserDetailsUpdateSuccessState extends AuthState {
//   @override
//   List<Object?> get props => [];
// }
//
// class UserDetailsUpdateErrorState extends AuthState {
//   final String message;
//
//   UserDetailsUpdateErrorState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }

/// ====================   delete states   =========================

class UserDeleteLoadingState extends AuthState {}

class UserDeleteSuccessState extends AuthState {}

class UserDeleteErrorState extends AuthState {
  final String message;

  UserDeleteErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

/// ===================   reset state   ===========================
class ResetUSerPasswordLoadingState extends AuthState {}

class ResetUserPasswordSuccessState extends AuthState {}

class ResetUSerPasswordErrorState extends AuthState {
  final String message;

  ResetUSerPasswordErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/user/my_user.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/use_case/login_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  final LoginUseCase _loginUseCase;

  AuthBloc(this._repository, this._loginUseCase) : super(UserInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<ContinueWithGoogleRequested>(_onContinueWithGoogleRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }

  //CR Bad Practice: Mutable state 'MyUser? currentUser;' stored directly on the Bloc class instead of inside immutable AuthState.
  MyUser? currentUser;

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginWithEmailPasswordLoadingState());
    final result = await _loginUseCase.login(
      email: event.email,
      password: event.password,
      role: event.role,
    );
    result.fold(
      (failure) => emit(LoginWithEmailPasswordErrorState(failure.message)),
      (user) {
        currentUser = user;
        emit(UserAuthenticatedState(user));
      },
    );
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(RegisterWithEmailPasswordLoadingState());
    //CR Inconsistent Architecture: Only login uses a UseCase while register, logout, google, and reset password call the repository directly from the Bloc.
    final result = await _repository.registerWithEmailAndPassword(
      name: event.name,
      password: event.password,
      email: event.email,
    );

    result.fold(
      (failure) {
        emit(RegisterWithEmailPasswordErrorState(failure.message));
      },
      (user) {
        currentUser = user;
        emit(UserAuthenticatedState(user));
      },
    );
  }

  Future<void> _onContinueWithGoogleRequested(
    ContinueWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(ContinueWithGoogleLoadingState());
    final result = await _repository.continueWithGoogle();

    result.fold(
      (failure) {
        emit(ContinueWithGoogleErrorState(failure.message));
      },
      (user) {
        currentUser = user;
        emit(UserAuthenticatedState(user));
      },
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(LogoutLoadingState());

    var result = await _repository.logout();
    result.fold((failure) => emit(LogoutErrorState(failure.message)), (_) {
      emit(UserUnauthenticatedState());
      currentUser = null;
    });
  }

  Future<void> _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(ResetUSerPasswordLoadingState());

    final result = await _repository.resetPassword(email: event.email);

    result.fold(
      (failure) {
        emit(ResetUSerPasswordErrorState(failure.message));
      },
      (_) {
        emit(ResetUserPasswordSuccessState());
      },
    );
  }
}

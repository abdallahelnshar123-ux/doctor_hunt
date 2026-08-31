import 'package:doctor_hunt/apps/features/auth/data/repo/auth_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/user/my_user.dart';
import 'user_event.dart';
import 'user_state.dart';

@lazySingleton
class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository _repository;

  UserBloc(this._repository) : super(UserInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<ContinueWithGoogleRequested>(_onContinueWithGoogleRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }

  MyUser? currentUser;

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(LoginWithEmailPasswordLoadingState());
    final result = await _repository.loginWithEmailAndPassword(
      email: event.email,
      password: event.password,
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
    Emitter<UserState> emit,
  ) async {
    emit(RegisterWithEmailPasswordLoadingState());
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
    Emitter<UserState> emit,
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
    Emitter<UserState> emit,
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
    Emitter<UserState> emit,
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

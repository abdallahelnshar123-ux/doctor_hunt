import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/user/repo/user_repository.dart';
import '../../../../features/common/auth/domain/entity/user/app_user.dart';
import '../../../../features/common/auth/domain/entity/user/patient.dart';
import '../../../../features/common/auth/domain/repository/auth_repository.dart';
import '../../../data/session/user_session_manager.dart';
import 'user_event.dart';
import 'user_state.dart';

@lazySingleton
class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository _authRepository;
  final UserSessionManager _userSessionManager;
  final UserRepository _userRepository;
  StreamSubscription<AppUserEntity?>? _userSubscription;

  UserBloc(
    this._authRepository,
    this._userSessionManager,
    this._userRepository,
  ) : super(UserDataState(user: _userSessionManager.currentUser)) {
    on<UserStreamUpdatedEvent>(_onUserStreamUpdated);
    on<ToggleFavoriteDoctorEvent>(_onToggleFavoriteDoctor);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);

    _listenToUserSession();
  }

  void _listenToUserSession() {
    _userSubscription = _userSessionManager.userStream.listen((user) {
      if (!isClosed) {
        add(UserStreamUpdatedEvent(user));
      }
    });
  }

  AppUserEntity? get currentUser => state.user;

  void _onUserStreamUpdated(
    UserStreamUpdatedEvent event,
    Emitter<UserState> emit,
  ) {
    emit(UserDataState(user: event.user));
  }

  Future<void> _onToggleFavoriteDoctor(
    ToggleFavoriteDoctorEvent event,
    Emitter<UserState> emit,
  ) async {
    final currentUser = state.user;
    if (currentUser == null) return;
    if (currentUser is! PatientEntity) return;

    // Save previous state for potential rollback
    final previousUser = currentUser;

    // Optimistic local update
    final currentFavs = currentUser.favDoctors;
    final updatedFavs = List<String>.from(currentFavs);
    if (updatedFavs.contains(event.doctorId)) {
      updatedFavs.remove(event.doctorId);
    } else {
      updatedFavs.add(event.doctorId);
    }

    final optimisticUser = PatientEntity(
      id: currentUser.id,
      email: currentUser.email,
      name: currentUser.name,
      provider: currentUser.provider,
      image: currentUser.image,
      phone: currentUser.phone,
      favDoctors: updatedFavs,
      disabled: currentUser.disabled,
    );

    // Emit optimistic state immediately
    emit(UserDataState(user: optimisticUser));
    _userSessionManager.updateUser(optimisticUser);

    // Call repository to sync with Firestore
    final result = await _authRepository.toggleFavoriteDoctor(
      event.doctorId,
      previousUser,
    );

    result.fold(
      (failure) {
        // Rollback state and set error on failure
        emit(
          UserDataState(user: previousUser, favoriteError: failure.message),
        );
        _userSessionManager.updateUser(previousUser);
      },
      (serverUser) {
        _userSessionManager.updateUser(serverUser);
      },
    );
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfileEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState(user: state.user));

    final result = await _userRepository.updateUserProfile(
      user: event.user,
      image: event.image,
    );

    result.fold(
      (failure) {
        emit(UserErrorState(user: state.user, message: failure.message));
      },
      (updatedUser) {
        _userSessionManager.updateUser(updatedUser);
        emit(UserDataState(user: updatedUser));
      },
    );
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

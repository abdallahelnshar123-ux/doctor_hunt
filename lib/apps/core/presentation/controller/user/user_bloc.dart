import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

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
  StreamSubscription<AppUserEntity?>? _userSubscription;

  UserBloc(this._authRepository, this._userSessionManager)
    : super(UserState(user: _userSessionManager.currentUser)) {
    on<UserStreamUpdatedEvent>(_onUserStreamUpdated);
    on<ToggleFavoriteDoctorEvent>(_onToggleFavoriteDoctor);

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
    emit(
      state.copyWith(
        user: event.user,
        clearUser: event.user == null,
        clearError: true,
      ),
    );
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
    );

    // Emit optimistic state immediately
    emit(state.copyWith(user: optimisticUser, clearError: true));
    // also update session manager for optimistic update
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
          state.copyWith(user: previousUser, favoriteError: failure.message),
        );
        _userSessionManager.updateUser(previousUser);
      },
      (serverUser) {
        // Updated state already handled via repository stream/emit
        _userSessionManager.updateUser(serverUser);
      },
    );
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

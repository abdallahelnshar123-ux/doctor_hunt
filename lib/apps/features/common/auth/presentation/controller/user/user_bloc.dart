import 'dart:async';

import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user/user_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/my_user.dart';
import '../../../data/models/user/patient_info.dart';
import '../../../data/repo/auth_repository.dart';

@lazySingleton
class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository _authRepository;
  StreamSubscription<MyUser?>? _userSubscription;

  UserBloc(this._authRepository)
    : super(UserState(user: _authRepository.currentUser)) {
    on<UserStreamUpdatedEvent>(_onUserStreamUpdated);
    on<ToggleFavoriteDoctorEvent>(_onToggleFavoriteDoctor);

    _userSubscription = _authRepository.userStream.listen((user) {
      add(UserStreamUpdatedEvent(user));
    });
  }

  MyUser? get currentUser => state.user;

  void _onUserStreamUpdated(
    UserStreamUpdatedEvent event,
    Emitter<UserState> emit,
  ) {
    emit(state.copyWith(user: event.user, clearError: true));
  }

  Future<void> _onToggleFavoriteDoctor(
    ToggleFavoriteDoctorEvent event,
    Emitter<UserState> emit,
  ) async {
    final currentUser = state.user;
    if (currentUser == null) return;

    // Save previous state for potential rollback
    final previousUser = currentUser;

    // Optimistic local update
    final currentFavs = currentUser.patientInfo?.favDoctors ?? [];
    final updatedFavs = List<String>.from(currentFavs);
    if (updatedFavs.contains(event.doctorId)) {
      updatedFavs.remove(event.doctorId);
    } else {
      updatedFavs.add(event.doctorId);
    }

    final updatedPatientInfo = (currentUser.patientInfo ?? const PatientInfo())
        .copyWith(favDoctors: updatedFavs);
    final optimisticUser = currentUser.copyWith(
      patientInfo: updatedPatientInfo,
    );

    // Emit optimistic state immediately
    emit(state.copyWith(user: optimisticUser, clearError: true));

    // Call repository to sync with Firestore
    final result = await _authRepository.toggleFavoriteDoctor(event.doctorId);

    result.fold(
      (failure) {
        // Rollback state and set error on failure
        emit(
          state.copyWith(user: previousUser, favoriteError: failure.message),
        );
      },
      (serverUser) {
        // Updated state already handled via repository stream/emit
      },
    );
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

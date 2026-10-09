import 'dart:io';

import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/patient/patient_profile_screen/data/repo/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/session/user_session_manager.dart';
import '../../../../common/auth/data/models/user/my_user.dart';

part 'admin_profile_event.dart';
part 'admin_profile_state.dart';

@injectable
class AdminProfileBloc extends Bloc<AdminProfileEvent, AdminProfileState> {
  final UserRepository _repository;
  final UserSessionManager _userSessionManager;

  AdminProfileBloc(this._repository, this._userSessionManager)
    : super(AdminProfileInitial()) {
    on<AdminProfileUpdateRequested>(_onUpdateProfileRequested);
    on<PickAdminProfileImageRequested>(_onPickImageRequested);
  }

  Future<void> _onUpdateProfileRequested(
    AdminProfileUpdateRequested event,
    Emitter<AdminProfileState> emit,
  ) async {
    emit(AdminProfileLoading());

    final result = await _repository.updateUserProfile(
      user: event.user,
      image: event.image,
    );

    result.fold((failure) => emit(AdminProfileUpdateError(failure.message)), (
      updatedUser,
    ) {
      _userSessionManager.updateUser(updatedUser);
      emit(AdminProfileUpdateSuccess(updatedUser));
    });
  }

  Future<void> _onPickImageRequested(
    PickAdminProfileImageRequested event,
    Emitter<AdminProfileState> emit,
  ) async {
    final result = await _repository.pickUserImage();
    result.fold((failure) {
      if (failure is! CancelledByUserFailure) {
        emit(PickAdminImageErrorState(failure.message));
      }
    }, (image) => emit(PickAdminImageSuccessState(image)));
  }
}

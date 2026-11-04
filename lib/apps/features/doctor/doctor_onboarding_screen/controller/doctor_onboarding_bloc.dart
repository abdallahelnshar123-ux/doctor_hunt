import 'package:doctor_hunt/apps/core/data/session/user_session_manager.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/doctor/domain/repository/doctor_repository.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'doctor_onboarding_event.dart';
import 'doctor_onboarding_state.dart';

@injectable
class DoctorOnboardingBloc
    extends Bloc<DoctorOnboardingEvent, DoctorOnboardingState> {
  final DoctorRepository _doctorRepository;
  final UserSessionManager _userSessionManager;

  DoctorOnboardingBloc(
    this._doctorRepository,
    this._userSessionManager,
  ) : super(DoctorOnboardingInitial()) {
    on<PickDoctorOnboardingImageRequested>(_onPickImageRequested);
    on<SaveDoctorOnboardingRequested>(_onSaveDoctorOnboardingRequested);
  }

  Future<void> _onPickImageRequested(
    PickDoctorOnboardingImageRequested event,
    Emitter<DoctorOnboardingState> emit,
  ) async {
    final result = await _doctorRepository.pickDoctorImage();
    result.fold(
      (failure) => emit(PickDoctorOnboardingImageErrorState(failure.message)),
      (image) => emit(PickDoctorOnboardingImageSuccessState(image)),
    );
  }

  Future<void> _onSaveDoctorOnboardingRequested(
    SaveDoctorOnboardingRequested event,
    Emitter<DoctorOnboardingState> emit,
  ) async {
    emit(DoctorOnboardingLoading());

    final currentUser = _userSessionManager.currentUser;
    if (currentUser == null || currentUser is! DoctorEntity) {
      emit(DoctorOnboardingError(t.errors.userNotAuthenticated));
      return;
    }

    final updatedDoctor = currentUser.copyWith(
      phone: event.phone,
      consultationFee: event.consultationFee,
      availability: event.availability,
    );

    // 1. Update Profile (Image + Phone + Fee)
    final profileResult = await _doctorRepository.updateDoctorProfile(
      doctor: updatedDoctor,
      image: event.image,
    );

    final profileFailed = profileResult.fold(
      (failure) {
        emit(DoctorOnboardingError(failure.message));
        return true;
      },
      (_) => false,
    );

    if (profileFailed) return;

    // 2. Update Availability
    final availabilityResult = await _doctorRepository.updateAvailability(
      doctorId: currentUser.id,
      availability: event.availability,
    );

    await availabilityResult.fold(
      (failure) async => emit(DoctorOnboardingError(failure.message)),
      (_) async {
        final refreshed = await _doctorRepository.getDoctorById(currentUser.id);
        refreshed.fold(
          (_) => _userSessionManager.updateUser(updatedDoctor),
          (freshDoctor) => _userSessionManager.updateUser(freshDoctor),
        );
        emit(DoctorOnboardingSuccess());
      },
    );
  }
}

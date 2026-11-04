import 'package:doctor_hunt/apps/core/data/session/user_session_manager.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/doctor/domain/repository/doctor_repository.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'doctor_profile_event.dart';
import 'doctor_profile_state.dart';

@injectable
class DoctorProfileBloc
    extends Bloc<DoctorProfileEvent, DoctorProfileState> {
  final DoctorRepository _doctorRepository;
  final UserSessionManager _userSessionManager;

  DoctorProfileBloc(
    this._doctorRepository,
    this._userSessionManager,
  ) : super(UpdateDoctorDetailsInitial()) {
    on<UpdateDoctorDetailsRequested>(_onUpdateDoctorDetailsRequested);
    on<PickDoctorUpdateImageRequested>(_onPickDoctorImageRequested);
  }

  Future<void> _onUpdateDoctorDetailsRequested(
    UpdateDoctorDetailsRequested event,
    Emitter<DoctorProfileState> emit,
  ) async {
    emit(UpdateDoctorDetailsLoading());

    final currentUser = _userSessionManager.currentUser;
    if (currentUser == null || currentUser is! DoctorEntity) {
      emit(UpdateDoctorDetailsError(t.errors.userNotAuthenticated));
      return;
    }

    final updatedDoctor = currentUser.copyWith(
      name: event.name ?? currentUser.name,
      specialty: event.specialty ?? currentUser.specialty,
      consultationFee: event.consultationFee ?? currentUser.consultationFee,
      phone: event.phone ?? currentUser.phone,
      active: event.active ?? currentUser.active,
    );

    final result = await _doctorRepository.updateDoctorProfile(
      doctor: updatedDoctor,
      image: event.image,
    );

    await result.fold(
      (failure) async => emit(UpdateDoctorDetailsError(failure.message)),
      (_) async {
        final refreshed = await _doctorRepository.getDoctorById(currentUser.id);
        refreshed.fold(
          (_) => _userSessionManager.updateUser(updatedDoctor),
          (freshDoctor) => _userSessionManager.updateUser(freshDoctor),
        );
        emit(UpdateDoctorDetailsSuccess());
      },
    );
  }

  Future<void> _onPickDoctorImageRequested(
    PickDoctorUpdateImageRequested event,
    Emitter<DoctorProfileState> emit,
  ) async {
    final result = await _doctorRepository.pickDoctorImage();
    result.fold(
      (failure) => emit(PickDoctorUpdateImageErrorState(failure.message)),
      (image) => emit(PickDoctorUpdateImageSuccessState(image)),
    );
  }
}

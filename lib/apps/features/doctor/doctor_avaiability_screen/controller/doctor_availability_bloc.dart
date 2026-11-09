import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_availability.dart';
import 'package:doctor_hunt/apps/core/data/session/user_session_manager.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/doctor/domain/repository/doctor_repository.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'doctor_availability_event.dart';
import 'doctor_availability_state.dart';

@injectable
class DoctorAvailabilityBloc
    extends Bloc<DoctorAvailabilityEvent, DoctorAvailabilityState> {
  final DoctorRepository _doctorRepository;
  final UserSessionManager _userSessionManager;

  DoctorAvailabilityBloc(this._doctorRepository, this._userSessionManager)
    : super(DoctorAvailabilityInitial()) {
    on<UpdateAvailabilityConfigEvent>(_onUpdateAvailabilityConfig);
  }

  Future<void> _onUpdateAvailabilityConfig(
    UpdateAvailabilityConfigEvent event,
    Emitter<DoctorAvailabilityState> emit,
  ) async {
    emit(DoctorAvailabilityLoading());

    final currentUser = _userSessionManager.currentUser;
    if (currentUser == null || currentUser is! DoctorEntity) {
      emit(DoctorAvailabilityError(t.errors.userNotAuthenticated));
      return;
    }

    final availability = DoctorAvailability(
      workingDays: event.workingDays,
      startTime: event.startTime,
      endTime: event.endTime,
      slotDuration: event.slotDuration,
    );

    final updatedDoctor = currentUser.copyWith(availability: availability);

    final result = await _doctorRepository.updateAvailability(
      doctorId: currentUser.id,
      availability: availability,
    );

    result.fold((failure) => emit(DoctorAvailabilityError(failure.message)), (
      _,
    ) {
      _userSessionManager.updateUser(updatedDoctor);
      emit(DoctorAvailabilitySuccess());
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/models/doctor/doctor_availability.dart';
import '../../../add_doctor_screen/data/repo/doctor_repository.dart';
import 'doctor_availability_event.dart';
import 'doctor_availability_state.dart';

@injectable
class DoctorAvailabilityBloc
    extends Bloc<DoctorAvailabilityEvent, DoctorAvailabilityState> {
  final DoctorRepository _doctorRepository;

  DoctorAvailabilityBloc(this._doctorRepository)
    : super(DoctorAvailabilityInitial()) {
    on<UpdateAvailabilityConfigEvent>(_onUpdateAvailabilityConfig);
  }

  Future<void> _onUpdateAvailabilityConfig(
    UpdateAvailabilityConfigEvent event,
    Emitter<DoctorAvailabilityState> emit,
  ) async {
    emit(DoctorAvailabilityLoading());

    final updatedDoctor = event.doctor.copyWith(
      availability: DoctorAvailability(
        workingDays: event.workingDays,
        startTime: event.startTime,
        endTime: event.endTime,
        slotDuration: event.slotDuration,
      ),
    );

    final result = await _doctorRepository.updateDoctorDetails(
      doctor: updatedDoctor,
    );

    result.fold(
      (failure) => emit(DoctorAvailabilityError(failure.message)),
      (_) => emit(DoctorAvailabilitySuccess()),
    );
  }
}

import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/repo/doctor_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'patient_doctors_event.dart';
part 'patient_doctors_state.dart';

@injectable
class PatientDoctorsBloc extends Bloc<PatientDoctorsEvent, PatientDoctorsState> {
  final DoctorRepository _doctorRepository;

  PatientDoctorsBloc(this._doctorRepository) : super(PatientDoctorsInitial()) {
    on<PatientDoctorsRequested>(_onPatientDoctorsRequested);
  }

  Future<void> _onPatientDoctorsRequested(
    PatientDoctorsRequested event,
    Emitter<PatientDoctorsState> emit,
  ) async {
    emit(PatientDoctorsLoading());

    await emit.forEach(
      _doctorRepository.getDoctors(adminId: null),
      onData: (result) => result.fold(
        (failure) => PatientDoctorsError(failure.message),
        (doctorsList) => PatientDoctorsSuccess(doctors: doctorsList),
      ),
      onError: (error, stackTrace) => PatientDoctorsError(error.toString()),
    );
  }
}

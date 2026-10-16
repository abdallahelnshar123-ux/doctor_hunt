import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/repo/doctor_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'patient_doctors_event.dart';
part 'patient_doctors_state.dart';

EventTransformer<T> _debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

@injectable
class PatientDoctorsBloc extends Bloc<PatientDoctorsEvent, PatientDoctorsState> {
  final DoctorRepository _doctorRepository;

  PatientDoctorsBloc(this._doctorRepository) : super(PatientDoctorsInitial()) {
    on<PatientDoctorsRequested>(_onPatientDoctorsRequested);
    on<SearchPatientDoctorsRequested>(
      _onSearchPatientDoctorsRequested,
      transformer: _debounce(const Duration(milliseconds: 300)),
    );

    add(PatientDoctorsRequested());
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
        (doctorsList) {
          final topRated = List<Doctor>.from(doctorsList)
            ..sort((a, b) => b.rating.rating.compareTo(a.rating.rating));

          return PatientDoctorsSuccess(
            doctors: doctorsList,
            topRatedDoctors: topRated,
          );
        },
      ),
      onError: (error, stackTrace) => PatientDoctorsError(error.toString()),
    );
  }

  void _onSearchPatientDoctorsRequested(
    SearchPatientDoctorsRequested event,
    Emitter<PatientDoctorsState> emit,
  ) {
    if (state is PatientDoctorsSuccess) {
      final currentState = state as PatientDoctorsSuccess;
      if (event.query == currentState.searchQuery) return;

      final trimmedQuery = event.query.trim().toLowerCase();
      final List<Doctor> filtered;

      if (trimmedQuery.isEmpty) {
        filtered = currentState.doctors;
      } else {
        filtered = currentState.doctors.where((doctor) {
          final nameMatches = doctor.name.toLowerCase().contains(trimmedQuery);
          final specialtyMatches =
              doctor.specialty.name.toLowerCase().contains(trimmedQuery);
          return nameMatches || specialtyMatches;
        }).toList();
      }

      emit(currentState.copyWith(
        searchQuery: event.query,
        searchResults: filtered,
      ));
    }
  }
}

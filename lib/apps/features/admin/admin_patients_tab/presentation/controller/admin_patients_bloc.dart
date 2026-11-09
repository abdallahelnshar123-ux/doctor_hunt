import 'package:doctor_hunt/apps/features/admin/admin_patients_tab/data/repo/admin_patients_repository.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/patient.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'admin_patients_event.dart';
part 'admin_patients_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

@injectable
class AdminPatientsBloc extends Bloc<AdminPatientsEvent, AdminPatientsState> {
  final AdminPatientsRepository _patientsRepository;

  AdminPatientsBloc(this._patientsRepository) : super(AdminPatientsInitial()) {
    on<AdminGetPatientsRequested>(_onGetPatientsRequested);
    on<AdminSearchPatientsRequested>(
      _onSearchPatientsRequested,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<AdminUpdatePatientStatusLocally>(_onUpdatePatientStatusLocally);
  }

  void _onUpdatePatientStatusLocally(
    AdminUpdatePatientStatusLocally event,
    Emitter<AdminPatientsState> emit,
  ) {
    final currentState = state;
    if (currentState is AdminPatientsSuccess) {
      final updatedAll = currentState.allPatients.map((patient) {
        if (patient.id == event.patientId) {
          return patient.copyWith(disabled: event.disabled);
        }
        return patient;
      }).toList();

      final updatedSearch = currentState.searchPatients?.map((patient) {
        if (patient.id == event.patientId) {
          return patient.copyWith(disabled: event.disabled);
        }
        return patient;
      }).toList();

      emit(
        currentState.copyWith(
          allPatients: updatedAll,
          searchPatients: updatedSearch,
        ),
      );
    }
  }

  Future<void> _onGetPatientsRequested(
    AdminGetPatientsRequested event,
    Emitter<AdminPatientsState> emit,
  ) async {
    final currentState = state;
    List<PatientEntity>? currentPatients;

    if (currentState is AdminPatientsSuccess) {
      currentPatients = currentState.allPatients;
    }

    emit(const AdminPatientsLoading());

    final result = await _patientsRepository.getPatients();

    result.fold(
      (failure) {
        if (currentPatients != null) {
          emit(
            AdminPatientsSuccess(
              allPatients: currentPatients,
              errorMessage: failure.message,
            ),
          );
        } else {
          emit(AdminPatientsError(failure.message));
        }
      },
      (patientsList) {
        emit(AdminPatientsSuccess(allPatients: patientsList));
      },
    );
  }

  Future<void> _onSearchPatientsRequested(
    AdminSearchPatientsRequested event,
    Emitter<AdminPatientsState> emit,
  ) async {
    final currentState = state;
    if (currentState is AdminPatientsSuccess) {
      if (event.query == currentState.searchQuery) return;
      final allPatients = currentState.allPatients;

      if (event.query.trim().isEmpty) {
        emit(currentState.copyWith(clearSearch: true));
        return;
      }

      final searchPatients = allPatients.where((patient) {
        final lowerQuery = event.query.toLowerCase();
        return patient.name.toLowerCase().contains(lowerQuery) ||
            patient.email.toLowerCase().contains(lowerQuery);
      }).toList();

      emit(
        currentState.copyWith(
          searchQuery: event.query,
          searchPatients: searchPatients,
        ),
      );
    }
  }
}

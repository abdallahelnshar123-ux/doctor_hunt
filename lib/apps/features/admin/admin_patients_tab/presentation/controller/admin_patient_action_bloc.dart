import 'package:doctor_hunt/apps/features/admin/admin_patients_tab/data/repo/admin_patients_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'admin_patient_action_event.dart';
part 'admin_patient_action_state.dart';

@injectable
class AdminPatientActionBloc
    extends Bloc<AdminPatientActionEvent, AdminPatientActionState> {
  final AdminPatientsRepository _patientsRepository;

  AdminPatientActionBloc(this._patientsRepository)
    : super(AdminPatientActionInitial()) {
    on<TogglePatientDisabledStatusRequested>(
      _onTogglePatientDisabledStatusRequested,
    );
    on<TogglePatientActiveStatusRequested>(
      _onTogglePatientActiveStatusRequested,
    );
  }

  Future<void> _onTogglePatientDisabledStatusRequested(
    TogglePatientDisabledStatusRequested event,
    Emitter<AdminPatientActionState> emit,
  ) async {
    emit(TogglePatientActiveStatusLoading());

    final result = await _patientsRepository.updatePatientDisabledStatus(
      patientId: event.patientId,
      disabled: event.disabled,
    );

    result.fold(
      (failure) => emit(TogglePatientActiveStatusError(failure.message)),
      (_) => emit(TogglePatientActiveStatusSuccess()),
    );
  }

  Future<void> _onTogglePatientActiveStatusRequested(
    TogglePatientActiveStatusRequested event,
    Emitter<AdminPatientActionState> emit,
  ) async {
    emit(TogglePatientActiveStatusLoading());

    final result = await _patientsRepository.updatePatientDisabledStatus(
      patientId: event.patientId,
      disabled: !event.active,
    );

    result.fold(
      (failure) => emit(TogglePatientActiveStatusError(failure.message)),
      (_) => emit(TogglePatientActiveStatusSuccess()),
    );
  }
}

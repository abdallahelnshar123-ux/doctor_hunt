import 'package:doctor_hunt/apps/features/doctor/domain/repository/doctor_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'admin_doctor_action_event.dart';
part 'admin_doctor_action_state.dart';

@injectable
class AdminDoctorActionBloc
    extends Bloc<AdminDoctorActionEvent, AdminDoctorActionState> {
  final DoctorRepository _doctorRepository;

  AdminDoctorActionBloc(this._doctorRepository)
    : super(AdminDoctorActionInitial()) {
    on<ToggleDoctorActiveStatusRequested>(_onToggleDoctorActiveStatusRequested);
    on<ToggleDoctorDisabledStatusRequested>(
      _onToggleDoctorDisabledStatusRequested,
    );
  }

  Future<void> _onToggleDoctorDisabledStatusRequested(
    ToggleDoctorDisabledStatusRequested event,
    Emitter<AdminDoctorActionState> emit,
  ) async {
    emit(ToggleDoctorActiveStatusLoading());

    final result = await _doctorRepository.updateDoctorDisabledStatus(
      doctorId: event.doctorId,
      disabled: event.disabled,
    );

    result.fold(
      (failure) => emit(ToggleDoctorActiveStatusError(failure.message)),
      (_) => emit(ToggleDoctorActiveStatusSuccess()),
    );
  }

  Future<void> _onToggleDoctorActiveStatusRequested(
    ToggleDoctorActiveStatusRequested event,
    Emitter<AdminDoctorActionState> emit,
  ) async {
    emit(ToggleDoctorActiveStatusLoading());

    final result = await _doctorRepository.updateDoctorActiveStatus(
      doctorId: event.doctorId,
      active: event.active,
    );

    result.fold(
      (failure) => emit(ToggleDoctorActiveStatusError(failure.message)),
      (_) => emit(ToggleDoctorActiveStatusSuccess()),
    );
  }
}

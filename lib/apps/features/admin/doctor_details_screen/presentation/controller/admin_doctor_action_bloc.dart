import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../add_doctor_screen/data/repo/doctor_repository.dart';

part 'admin_doctor_action_event.dart';
part 'admin_doctor_action_state.dart';

@injectable
class AdminDoctorActionBloc
    extends Bloc<AdminDoctorActionEvent, AdminDoctorActionState> {
  final DoctorRepository _doctorRepository;

  AdminDoctorActionBloc(this._doctorRepository)
    : super(AdminDoctorActionInitial()) {
    on<ToggleDoctorActiveStatusRequested>(_onToggleDoctorActiveStatusRequested);
    on<DeleteDoctorRequested>(_onDeleteDoctorRequested);
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

  Future<void> _onDeleteDoctorRequested(
    DeleteDoctorRequested event,
    Emitter<AdminDoctorActionState> emit,
  ) async {
    emit(DeleteDoctorLoading());

    final result = await _doctorRepository.deleteDoctor(
      doctorId: event.doctorId,
    );

    result.fold(
      (failure) => emit(DeleteDoctorError(failure.message)),
      (_) => emit(DeleteDoctorSuccess()),
    );
  }
}

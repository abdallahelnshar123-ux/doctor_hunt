import 'dart:io';

import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/repo/doctor_repository.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/widget/specialty_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';
@injectable
class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRepository _repository;

  DoctorBloc(this._repository) : super(DoctorInitial()) {
    on<AddDoctorRequested>(_onAddDoctorRequested);
    on<PickDoctorImageRequested>(_onPickDoctorImageRequested);
  }

  Future<void> _onAddDoctorRequested(
    AddDoctorRequested event,
    Emitter<DoctorState> emit,
  ) async {
    emit(AddDoctorLoadingState());
  }

  Future<void> _onPickDoctorImageRequested(
    PickDoctorImageRequested event,
    Emitter<DoctorState> emit,
  ) async {
    final result = await _repository.pickDoctorImage();
    result.fold(
      (failure) => emit(PickDoctorImageErrorState(failure.message)),
      (result) => result.fold(
        () => emit(PickDoctorImageCancelledState()),
        (image) => emit(PickDoctorImageSuccessState(image)),
      ),
    );
  }
}

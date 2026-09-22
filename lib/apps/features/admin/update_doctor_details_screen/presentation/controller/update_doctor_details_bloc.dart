import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/models/doctor/doctor.dart';
import '../../../add_doctor_screen/data/repo/doctor_repository.dart';

part 'update_doctor_details_event.dart';
part 'update_doctor_details_state.dart';

@injectable
class UpdateDoctorDetailsBloc
    extends Bloc<UpdateDoctorDetailsEvent, UpdateDoctorDetailsState> {
  final DoctorRepository _doctorRepository;

  UpdateDoctorDetailsBloc(this._doctorRepository)
    : super(UpdateDoctorDetailsInitial()) {
    on<UpdateDoctorDetailsRequested>(_onUpdateDoctorDetailsRequested);
    on<DeleteDoctorRequested>(_onDeleteDoctorRequested);
    on<PickDoctorUpdateImageRequested>(_onPickDoctorImageRequested);
  }

  Future<void> _onUpdateDoctorDetailsRequested(
    UpdateDoctorDetailsRequested event,
    Emitter<UpdateDoctorDetailsState> emit,
  ) async {
    emit(UpdateDoctorDetailsLoading());

    final result = await _doctorRepository.updateDoctorDetails(
      doctor: event.doctor,
      image: event.image,
    );

    result.fold(
      (failure) => emit(UpdateDoctorDetailsError(failure.message)),
      (_) => emit(UpdateDoctorDetailsSuccess()),
    );
  }

  Future<void> _onDeleteDoctorRequested(
    DeleteDoctorRequested event,
    Emitter<UpdateDoctorDetailsState> emit,
  ) async {
    emit(DeleteDoctorFromEditLoading());

    final result = await _doctorRepository.deleteDoctor(
      doctorId: event.doctorId,
    );

    result.fold(
      (failure) => emit(DeleteDoctorFromEditError(failure.message)),
      (_) => emit(DeleteDoctorFromEditSuccess()),
    );
  }

  Future<void> _onPickDoctorImageRequested(
    PickDoctorUpdateImageRequested event,
    Emitter<UpdateDoctorDetailsState> emit,
  ) async {
    final result = await _doctorRepository.pickDoctorImage();
    result.fold(
      (failure) => emit(PickDoctorUpdateImageErrorState(failure.message)),
      (image) => emit(PickDoctorUpdateImageSuccessState(image)),
    );
  }
}

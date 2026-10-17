import 'dart:io';

import 'package:doctor_hunt/apps/core/data/doctor/repo/doctor_repository.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/rating.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'add_doctors_event.dart';
part 'add_doctors_state.dart';

@injectable
class AddDoctorsBloc extends Bloc<AddDoctorsEvent, AddDoctorsState> {
  final DoctorRepository _doctorRepository;

  AddDoctorsBloc(this._doctorRepository) : super(DoctorInitial()) {
    on<AddDoctorRequested>(_onAddDoctorRequested);
    on<PickDoctorImageRequested>(_onPickDoctorImageRequested);
  }

  Future<void> _onAddDoctorRequested(
    AddDoctorRequested event,
    Emitter<AddDoctorsState> emit,
  ) async {
    emit(AddDoctorLoadingState());

    var result = await _doctorRepository.addDoctor(
      doctor: Doctor(
        id: '',
        name: event.name,
        adminId: event.adminId,
        specialty: event.specialty,
        active: event.active,
        consultationFee: event.consultationFee,
        rating: const Rating(rating: 0.0, reviews: []),
      ),
      image: event.image,
    );

    result.fold(
      (l) => emit(AddDoctorErrorState(l.message)),
      (r) => emit(AddDoctorSuccessState()),
    );
  }

  Future<void> _onPickDoctorImageRequested(
    PickDoctorImageRequested event,
    Emitter<AddDoctorsState> emit,
  ) async {
    final result = await _doctorRepository.pickDoctorImage();
    result.fold((failure) {
      if (failure is! CancelledByUserFailure) {
        emit(PickDoctorImageErrorState(failure.message));
      }
    }, (image) => emit(PickDoctorImageSuccessState(image)));
  }
}

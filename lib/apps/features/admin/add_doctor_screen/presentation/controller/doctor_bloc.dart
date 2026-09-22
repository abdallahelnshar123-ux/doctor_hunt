import 'dart:io';

import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/repo/doctor_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/auth/domain/entity/user/my_user.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

@injectable
class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRepository _doctorRepository;

  DoctorBloc(this._doctorRepository) : super(DoctorInitial()) {
    on<AddDoctorRequested>(_onAddDoctorRequested);
    on<PickDoctorImageRequested>(_onPickDoctorImageRequested);
    on<GetDoctorsRequested>(_onGetDoctorsRequested);
    on<FilterDoctorsRequested>(_onFilterDoctorsRequested);
  }

  Future<void> _onFilterDoctorsRequested(
    FilterDoctorsRequested event,
    Emitter<DoctorState> emit,
  ) async {
    final currentState = state;
    if (currentState is GetDoctorsSuccessState) {
      if (event.selectedSpecialty == currentState.selectedSpecialty) return;

      if (event.selectedSpecialty == null) {
        emit(
          GetDoctorsSuccessState(
            allDoctors: currentState.allDoctors,
            specialtyCounts: currentState.specialtyCounts,
            activeDoctorsCount: currentState.activeDoctorsCount,
            selectedSpecialty: null,
            filteredDoctors: null,
          ),
        );
        return;
      } else {
        List<Doctor> filtered = [];

        filtered = currentState.allDoctors
            .where((d) => d.specialty == event.selectedSpecialty)
            .toList();

        emit(
          currentState.copyWith(
            filteredDoctors: filtered,
            selectedSpecialty: event.selectedSpecialty,
          ),
        );
      }
    }
  }

  Future<void> _onAddDoctorRequested(
    AddDoctorRequested event,
    Emitter<DoctorState> emit,
  ) async {
    emit(AddDoctorLoadingState());

    var result = await _doctorRepository.addDoctor(
      doctor: Doctor(
        id: '',
        name: event.name,
        adminId: event.adminId,
        specialty: event.specialty,
        active: event.active,
      ),
      image: event.image,
    );

    result.fold(
      (l) => emit(AddDoctorErrorState(l.message)),
      (r) => emit(AddDoctorSuccessState()),
    );
  }

  Future<void> _onGetDoctorsRequested(
    GetDoctorsRequested event,
    Emitter<DoctorState> emit,
  ) async {
    emit(GetDoctorsLoadingState());
    await emit.forEach(
      _doctorRepository.getDoctors(
        adminId: event.role == UserRoles.admin ? event.userId : null,
      ),
      onData: (result) => result.fold(
        (failure) => GetDoctorsErrorState(failure.message),
        (doctorsList) {
          int activeCount = 0;
          final Map<Specialty, int> counts = {};

          for (var doctor in doctorsList) {
            if (doctor.active) {
              activeCount++;
            }
            final specialtyName = doctor.specialty;
            counts[specialtyName] = (counts[specialtyName] ?? 0) + 1;
          }

          final List<Map<Specialty, int>> specialtyCounts = counts.entries
              .map((e) => {e.key: e.value})
              .toList();

          return GetDoctorsSuccessState(
            allDoctors: doctorsList,
            specialtyCounts: specialtyCounts,
            activeDoctorsCount: activeCount,
          );
        },
      ),
      onError: (error, stackTrace) => GetDoctorsErrorState(error.toString()),
    );
  }

  Future<void> _onPickDoctorImageRequested(
    PickDoctorImageRequested event,
    Emitter<DoctorState> emit,
  ) async {
    final result = await _doctorRepository.pickDoctorImage();
    result.fold((failure) {
      if (failure is! CancelledByUserFailure) {
        emit(PickDoctorImageErrorState(failure.message));
      }
    }, (image) => emit(PickDoctorImageSuccessState(image)));
  }
}

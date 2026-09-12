import 'dart:io';

import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/repo/doctor_repository.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/use_cases/get_doctors_use_case.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'doctor_event.dart';

part 'doctor_state.dart';

@injectable
class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRepository _repository;
  final GetDoctorsUseCase _getDoctorsUseCase;
  List<Doctor> allDoctors = [];
  String _selectedSpecialty = '';

  DoctorBloc(this._repository, this._getDoctorsUseCase) : super(DoctorInitial()) {
    _selectedSpecialty = t.admin.doctors_tab.all;
    on<AddDoctorRequested>(_onAddDoctorRequested);
    on<PickDoctorImageRequested>(_onPickDoctorImageRequested);
    on<GetDoctorsRequested>(_onGetDoctorsRequested);
    on<FilterDoctorsRequested>(_onFilterDoctorsRequested);
  }

  Future<void> _onFilterDoctorsRequested(
    FilterDoctorsRequested event,
    Emitter<DoctorState> emit,
  ) async {
    _selectedSpecialty = event.specialty;
    if (state is GetDoctorsSuccessState) {
      emit(_buildSuccessState(allDoctors));
    }
  }

  Future<void> _onAddDoctorRequested(
    AddDoctorRequested event,
    Emitter<DoctorState> emit,
  ) async {
    emit(AddDoctorLoadingState());

    var result = await _repository.addDoctor(
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
      _getDoctorsUseCase(userId: event.userId, role: event.role),
      onData: (result) => result.fold(
        (failure) => GetDoctorsErrorState(failure.message),
        (doctorsList) {
          allDoctors = doctorsList;
          return _buildSuccessState(doctorsList);
        },
      ),
      onError: (error, stackTrace) => GetDoctorsErrorState(error.toString()),
    );
  }

  GetDoctorsSuccessState _buildSuccessState(List<Doctor> doctorsList) {
    int activeCount = 0;
    final Map<String, int> counts = {};

    for (var doctor in doctorsList) {
      if (doctor.active) {
        activeCount++;
      }
      final specialtyName = doctor.specialty.name;
      counts[specialtyName] = (counts[specialtyName] ?? 0) + 1;
    }

    final List<Map<String, int>> specialtyCounts = [
      {t.admin.doctors_tab.all: doctorsList.length},
      ...counts.entries.map((e) => {e.key: e.value}),
    ];

    List<Doctor> filtered = doctorsList;
    if (_selectedSpecialty != t.admin.doctors_tab.all) {
      filtered = doctorsList
          .where((d) => d.specialty.name == _selectedSpecialty)
          .toList();
    }

    return GetDoctorsSuccessState(
      filtered,
      specialtyCounts,
      activeCount,
      _selectedSpecialty,
    );
  }

  Future<void> _onPickDoctorImageRequested(
    PickDoctorImageRequested event,
    Emitter<DoctorState> emit,
  ) async {
    final result = await _repository.pickDoctorImage();
    result.fold((failure) {
      if (failure is! CancelledByUserFailure) {
        emit(PickDoctorImageErrorState(failure.message));
      }
    }, (image) => emit(PickDoctorImageSuccessState(image)));
  }
}

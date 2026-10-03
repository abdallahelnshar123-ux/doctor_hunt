import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/auth/data/models/user/my_user.dart';
import '../../data/repo/patient_profile_repository.dart';

part 'patient_profile_event.dart';
part 'patient_profile_state.dart';

@injectable
class PatientProfileBloc
    extends Bloc<PatientProfileEvent, PatientProfileState> {
  final PatientProfileRepository _repository;

  PatientProfileBloc(this._repository) : super(PatientProfileInitial()) {
    on<PatientProfileUpdateRequested>(_onUpdateProfileRequested);
    on<PickPatientProfileImageRequested>(_onPickImageRequested);
  }

  Future<void> _onUpdateProfileRequested(
    PatientProfileUpdateRequested event,
    Emitter<PatientProfileState> emit,
  ) async {
    emit(PatientProfileLoading());

    final result = await _repository.updatePatientProfile(
      user: event.user,
      image: event.image,
    );

    result.fold(
      (failure) => emit(PatientProfileUpdateError(failure.message)),
      (updatedUser) => emit(PatientProfileUpdateSuccess(updatedUser)),
    );
  }

  Future<void> _onPickImageRequested(
    PickPatientProfileImageRequested event,
    Emitter<PatientProfileState> emit,
  ) async {
    final result = await _repository.pickPatientImage();
    result.fold(
      (failure) => emit(PickPatientImageErrorState(failure.message)),
      (image) => emit(PickPatientImageSuccessState(image)),
    );
  }
}

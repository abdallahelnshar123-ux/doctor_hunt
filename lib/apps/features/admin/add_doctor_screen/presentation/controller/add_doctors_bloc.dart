import 'package:doctor_hunt/apps/features/common/specialties/data/models/specialty_model.dart';
import 'package:doctor_hunt/apps/features/doctor/domain/repository/doctor_repository.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/rating.dart';
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
  }

  Future<void> _onAddDoctorRequested(
    AddDoctorRequested event,
    Emitter<AddDoctorsState> emit,
  ) async {
    emit(AddDoctorLoadingState());

    var result = await _doctorRepository.addDoctor(
      doctor: DoctorEntity(
        id: '',
        email: event.email,
        provider: UserAuthProvider.emailPassword,
        name: event.name,
        adminId: event.adminId,
        specialty: event.specialty,
        active: event.active,
        // consultationFee: event.consultationFee,
        rating: const Rating(rating: 0.0, reviews: []),
      ),
      // image: event.image,
      password: event.password,
    );

    result.fold(
      (l) => emit(AddDoctorErrorState(l.message)),
      (r) => emit(AddDoctorSuccessState()),
    );
  }
}

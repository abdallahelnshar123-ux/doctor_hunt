import 'package:doctor_hunt/apps/features/common/specialties/data/models/specialty_model.dart';
import 'package:doctor_hunt/apps/features/common/specialties/data/repo/specialty_repository.dart';
import 'package:doctor_hunt/apps/features/common/specialties/presentation/controller/specialties_event.dart';
import 'package:doctor_hunt/apps/features/common/specialties/presentation/controller/specialties_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SpecialtiesBloc extends Bloc<SpecialtiesEvent, SpecialtiesState> {
  final SpecialtyRepository _repository;

  SpecialtiesBloc(this._repository) : super(const SpecialtiesState()) {
    on<GetSpecialtiesEvent>(_onGetSpecialties);
    on<AddSpecialtyEvent>(_onAddSpecialty);
    on<UpdateSpecialtyEvent>(_onUpdateSpecialty);
    add(GetSpecialtiesEvent());
  }

  Future<void> _onGetSpecialties(
    GetSpecialtiesEvent event,
    Emitter<SpecialtiesState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SpecialtiesStatus.loading,
        clearActionMessage: true,
        clearFailure: true,
      ),
    );

    final result = await _repository.getSpecialties();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SpecialtiesStatus.failure,
          failureMessage: failure.message,
        ),
      ),
      (specialties) => emit(
        state.copyWith(
          status: SpecialtiesStatus.success,
          specialties: specialties,
        ),
      ),
    );
  }

  Future<void> _onAddSpecialty(
    AddSpecialtyEvent event,
    Emitter<SpecialtiesState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SpecialtiesStatus.loading,
        clearActionMessage: true,
        clearFailure: true,
      ),
    );

    final result = await _repository.addSpecialty(en: event.en, ar: event.ar);

    result.fold(
      (failure) {
        debugPrint('===============================');
        debugPrint(failure.message);
        debugPrint('===============================');

        emit(
          state.copyWith(
            status: SpecialtiesStatus.failure,
            failureMessage: failure.message,
          ),
        );
      },
      (newSpecialty) {
        final updatedList = List<SpecialtyModel>.from(state.specialties)
          ..add(newSpecialty);
        emit(
          state.copyWith(
            status: SpecialtiesStatus.success,
            specialties: updatedList,
            actionSuccessMessage: 'Specialty added successfully',
          ),
        );
      },
    );
  }

  Future<void> _onUpdateSpecialty(
    UpdateSpecialtyEvent event,
    Emitter<SpecialtiesState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SpecialtiesStatus.loading,
        clearActionMessage: true,
        clearFailure: true,
      ),
    );

    final result = await _repository.updateSpecialty(event.specialty);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SpecialtiesStatus.failure,
          failureMessage: failure.message,
        ),
      ),
      (updatedSpecialty) {
        final updatedList = state.specialties.map((item) {
          return item.id == updatedSpecialty.id ? updatedSpecialty : item;
        }).toList();

        emit(
          state.copyWith(
            status: SpecialtiesStatus.success,
            specialties: updatedList,
            actionSuccessMessage: 'Specialty updated successfully',
          ),
        );
      },
    );
  }
}

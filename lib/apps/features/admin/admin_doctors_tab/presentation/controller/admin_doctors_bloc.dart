import 'package:doctor_hunt/apps/core/data/doctor/repo/doctor_repository.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'admin_doctors_event.dart';
part 'admin_doctors_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

@injectable
class AdminDoctorsBloc extends Bloc<AdminDoctorsEvent, AdminDoctorsState> {
  final DoctorRepository _doctorRepository;

  AdminDoctorsBloc(this._doctorRepository) : super(AdminDoctorsInitial()) {
    on<AdminGetDoctorsRequested>(_onGetDoctorsRequested);
    on<AdminFilterDoctorsRequested>(_onFilterDoctorsRequested);
    on<AdminSearchDoctorsRequested>(
      _onSearchDoctorsRequested,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
  }

  Future<void> _onGetDoctorsRequested(
    AdminGetDoctorsRequested event,
    Emitter<AdminDoctorsState> emit,
  ) async {
    emit(AdminDoctorsLoading());
    await emit.forEach(
      _doctorRepository.getDoctors(adminId: event.adminId),
      onData: (result) => result.fold(
        (failure) => AdminDoctorsError(failure.message),
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

          // Maintain the existing filter and search state if currently in success state
          if (state is AdminDoctorsSuccess) {
            final currentState = state as AdminDoctorsSuccess;
            final updatedFilteredDoctors = _applyFilterAndSearch(
              doctorsList,
              currentState.selectedSpecialty,
            );
            return currentState.copyWith(
              allDoctors: doctorsList,
              specialtyCounts: specialtyCounts,
              activeDoctorsCount: activeCount,
              filteredDoctors: updatedFilteredDoctors,
            );
          }

          return AdminDoctorsSuccess(
            allDoctors: doctorsList,
            specialtyCounts: specialtyCounts,
            activeDoctorsCount: activeCount,
          );
        },
      ),
      onError: (error, stackTrace) => AdminDoctorsError(error.toString()),
    );
  }

  Future<void> _onFilterDoctorsRequested(
    AdminFilterDoctorsRequested event,
    Emitter<AdminDoctorsState> emit,
  ) async {
    final currentState = state;
    if (currentState is AdminDoctorsSuccess) {
      if (event.selectedSpecialty == currentState.selectedSpecialty) return;

      final updatedFilteredDoctors = _applyFilterAndSearch(
        currentState.allDoctors,
        event.selectedSpecialty,
      );

      emit(
        currentState.copyWith(
          selectedSpecialty: event.selectedSpecialty,
          filteredDoctors: updatedFilteredDoctors,
          clearSpecialty: event.selectedSpecialty == null,
        ),
      );
    }
  }

  Future<void> _onSearchDoctorsRequested(
    AdminSearchDoctorsRequested event,
    Emitter<AdminDoctorsState> emit,
  ) async {
    final currentState = state;
    if (currentState is AdminDoctorsSuccess) {
      if (event.query == currentState.searchQuery) return;
      final allDoctors = currentState.allDoctors;

      if (event.query.trim().isEmpty) {
        emit(
          currentState.copyWith(
            searchQuery: event.query,
            searchDoctors: allDoctors,
          ),
        );
        return;
      }

      final searchDoctors = allDoctors.where((doctor) {
        final lowerQuery = event.query.toLowerCase();
        return doctor.name.toLowerCase().contains(lowerQuery) ||
            doctor.specialty.name.toLowerCase().contains(lowerQuery);
      }).toList();

      // bool matchesQuery = true;
      // if (query.trim().isNotEmpty) {
      //   final lowerQuery = query.toLowerCase();
      //
      // }

      // final updatedFilteredDoctors = _applyFilterAndSearch(
      //   currentState.allDoctors,
      //   currentState.selectedSpecialty,
      //   event.query,
      // );

      emit(
        currentState.copyWith(
          searchQuery: event.query,
          searchDoctors: searchDoctors,
        ),
      );
    }
  }

  List<Doctor>? _applyFilterAndSearch(
    List<Doctor> allDoctors,
    Specialty? specialty,
  ) {
    if (specialty == null) return null;

    return allDoctors.where((doctor) {
      bool matchesSpecialty = true;
      matchesSpecialty = doctor.specialty == specialty;

      // if (specialty ) {
      //   matchesSpecialty = doctor.specialty == specialty;
      // }
      //
      // bool matchesQuery = true;
      // if (query.trim().isNotEmpty) {
      //   final lowerQuery = query.toLowerCase();
      //   matchesQuery =
      //       doctor.name.toLowerCase().contains(lowerQuery) ||
      //       doctor.specialty.name.toLowerCase().contains(lowerQuery);
      // }

      return matchesSpecialty;
    }).toList();
  }
}

part of 'doctor_bloc.dart';

@immutable
sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}

final class AddDoctorLoadingState extends DoctorState {}

final class AddDoctorSuccessState extends DoctorState {}

final class AddDoctorErrorState extends DoctorState {
  final String message;

  AddDoctorErrorState(this.message);
}

/// =========================  pick image states ==========================

final class PickDoctorImageSuccessState extends DoctorState {
  final File image;

  PickDoctorImageSuccessState(this.image);
}

final class PickDoctorImageCancelledState extends DoctorState {
  PickDoctorImageCancelledState();
}

final class PickDoctorImageErrorState extends DoctorState {
  final String message;

  PickDoctorImageErrorState(this.message);
}

/// =========================  get doctors states ==========================

final class GetDoctorsLoadingState extends DoctorState {}

final class GetDoctorsSuccessState extends DoctorState {
  final List<Doctor> allDoctors;
  final List<Map<Specialty, int>> specialtyCounts;
  final int activeDoctorsCount;
  final Specialty? selectedSpecialty;
  final List<Doctor>? filteredDoctors;

  GetDoctorsSuccessState({
    required this.allDoctors,
    required this.specialtyCounts,
    required this.activeDoctorsCount,
    this.selectedSpecialty,
    this.filteredDoctors,
  });

  GetDoctorsSuccessState copyWith({
    List<Doctor>? allDoctors,
    List<Map<Specialty, int>>? specialtyCounts,
    int? activeDoctorsCount,
    Specialty? selectedSpecialty,
    List<Doctor>? filteredDoctors,
  }) {
    return GetDoctorsSuccessState(
      allDoctors: allDoctors ?? this.allDoctors,
      specialtyCounts: specialtyCounts ?? this.specialtyCounts,
      activeDoctorsCount: activeDoctorsCount ?? this.activeDoctorsCount,
      selectedSpecialty: selectedSpecialty,
      filteredDoctors: filteredDoctors,
    );
  }
}

final class GetDoctorsErrorState extends DoctorState {
  final String message;

  GetDoctorsErrorState(this.message);
}

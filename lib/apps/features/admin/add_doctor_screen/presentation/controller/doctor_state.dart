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
  final List<Doctor> doctors;
  //CR use enum: Represent specialties with Map<Specialties, int> or a dedicated enum filter model rather than List<Map<String, int>> with localized strings.
  final List<Map<String, int>> specialtyCounts;
  final int activeDoctorsCount;
  //CR use enum: Use 'Specialties?' (nullable where null = All) or an enum filter rather than raw String.
  final String selectedSpecialty;

  GetDoctorsSuccessState(
    this.doctors,
    this.specialtyCounts,
    this.activeDoctorsCount,
    this.selectedSpecialty,
  );
}

final class GetDoctorsErrorState extends DoctorState {
  final String message;

  GetDoctorsErrorState(this.message);
}

part of 'add_doctors_bloc.dart';

@immutable
sealed class AddDoctorsState {}

final class DoctorInitial extends AddDoctorsState {}

final class AddDoctorLoadingState extends AddDoctorsState {}

final class AddDoctorSuccessState extends AddDoctorsState {}

final class AddDoctorErrorState extends AddDoctorsState {
  final String message;

  AddDoctorErrorState(this.message);
}

/// =========================  pick image states ==========================

final class PickDoctorImageSuccessState extends AddDoctorsState {
  final File image;

  PickDoctorImageSuccessState(this.image);
}

final class PickDoctorImageCancelledState extends AddDoctorsState {
  PickDoctorImageCancelledState();
}

final class PickDoctorImageErrorState extends AddDoctorsState {
  final String message;

  PickDoctorImageErrorState(this.message);
}

/// =========================  get doctors states ==========================

// final class GetDoctorsLoadingState extends AddDoctorsState {}
//
// final class GetDoctorsSuccessState extends AddDoctorsState {
//   final List<Doctor> allDoctors;
//   final List<Map<Specialty, int>> specialtyCounts;
//   final int activeDoctorsCount;
//   final Specialty? selectedSpecialty;
//   final List<Doctor>? filteredDoctors;
//
//   GetDoctorsSuccessState({
//     required this.allDoctors,
//     required this.specialtyCounts,
//     required this.activeDoctorsCount,
//     this.selectedSpecialty,
//     this.filteredDoctors,
//   });
//
//   GetDoctorsSuccessState copyWith({
//     List<Doctor>? allDoctors,
//     List<Map<Specialty, int>>? specialtyCounts,
//     int? activeDoctorsCount,
//     Specialty? selectedSpecialty,
//     List<Doctor>? filteredDoctors,
//   }) {
//     return GetDoctorsSuccessState(
//       allDoctors: allDoctors ?? this.allDoctors,
//       specialtyCounts: specialtyCounts ?? this.specialtyCounts,
//       activeDoctorsCount: activeDoctorsCount ?? this.activeDoctorsCount,
//       selectedSpecialty: selectedSpecialty,
//       filteredDoctors: filteredDoctors,
//     );
//   }
// }
//
// final class GetDoctorsErrorState extends AddDoctorsState {
//   final String message;
//
//   GetDoctorsErrorState(this.message);
// }

part of 'add_doctors_bloc.dart';

@immutable
abstract class AddDoctorsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddDoctorRequested extends AddDoctorsEvent {
  final String name;
  final Specialty specialty;
  final String adminId;
  final File image;
  final bool active;
  final double consultationFee;

  AddDoctorRequested({
    required this.name,
    required this.specialty,
    required this.image,
    required this.adminId,
    required this.consultationFee,
    this.active = true,
  });

  @override
  List<Object?> get props => [
        name,
        specialty,
        adminId,
        image,
        active,
        consultationFee,
      ];
}

class PickDoctorImageRequested extends AddDoctorsEvent {}

// class GetDoctorsRequested extends AddDoctorsEvent {
//   final String adminId;
//
//   GetDoctorsRequested({required this.adminId});
// }
//
// class FilterDoctorsRequested extends AddDoctorsEvent {
//   final Specialty? selectedSpecialty;
//
//   FilterDoctorsRequested(this.selectedSpecialty);
// }

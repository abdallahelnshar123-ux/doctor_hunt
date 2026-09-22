part of 'doctor_bloc.dart';

@immutable
sealed class DoctorEvent {}

class AddDoctorRequested extends DoctorEvent {
  final String name;
  final Specialty specialty;
  final String adminId;
  final File image;
  final bool active;

  AddDoctorRequested({
    required this.name,
    required this.specialty,
    required this.image,
    required this.adminId,
    this.active = true,
  });
}

class PickDoctorImageRequested extends DoctorEvent {}

class GetDoctorsRequested extends DoctorEvent {
  final String userId;
  final UserRoles role;

  GetDoctorsRequested({required this.userId, required this.role});
}

class FilterDoctorsRequested extends DoctorEvent {
  final Specialty? selectedSpecialty;

  FilterDoctorsRequested(this.selectedSpecialty);
}

part of 'doctor_bloc.dart';

@immutable
sealed class DoctorEvent {}

class AddDoctorRequested extends DoctorEvent {
  final String name;
  final Specialties specialty;
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

//CR use enum: Use strongly-typed enum or filter type (e.g. SpecialtyFilter / Specialties?) instead of loose String for filtering.
class FilterDoctorsRequested extends DoctorEvent {
  final String specialty;

  FilterDoctorsRequested(this.specialty);
}

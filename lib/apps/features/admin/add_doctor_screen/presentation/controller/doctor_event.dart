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

class GetDoctorsRequested extends DoctorEvent {}

class FilterDoctorsRequested extends DoctorEvent {
  final String specialty;

  FilterDoctorsRequested(this.specialty);
}

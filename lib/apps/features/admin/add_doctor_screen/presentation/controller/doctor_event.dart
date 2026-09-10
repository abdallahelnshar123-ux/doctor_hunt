part of 'doctor_bloc.dart';

@immutable
sealed class DoctorEvent {}

class AddDoctorRequested extends DoctorEvent {
  final Specialties specialty;
  final String name;
  final String imageUrl;

  AddDoctorRequested({
    required this.name,
    required this.specialty,
    required this.imageUrl,
  });
}
class PickDoctorImageRequested extends DoctorEvent {}

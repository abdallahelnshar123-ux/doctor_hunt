part of 'add_doctors_bloc.dart';

@immutable
abstract class AddDoctorsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddDoctorRequested extends AddDoctorsEvent {
  final String name;
  final String email;
  final String password;
  final Specialty specialty;
  final String adminId;
  final File image;
  final bool active;
  final double consultationFee;

  AddDoctorRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.specialty,
    required this.image,
    required this.adminId,
    required this.consultationFee,
    this.active = true,
  });

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    specialty,
    adminId,
    image,
    active,
    consultationFee,
  ];
}

class PickDoctorImageRequested extends AddDoctorsEvent {}

part of 'patient_profile_bloc.dart';

abstract class PatientProfileEvent extends Equatable {
  const PatientProfileEvent();

  @override
  List<Object?> get props => [];
}

class PatientProfileUpdateRequested extends PatientProfileEvent {
  final MyUser user;
  final File? image;

  const PatientProfileUpdateRequested({
    required this.user,
    this.image,
  });

  @override
  List<Object?> get props => [user, image];
}

class PickPatientProfileImageRequested extends PatientProfileEvent {
  const PickPatientProfileImageRequested();
}

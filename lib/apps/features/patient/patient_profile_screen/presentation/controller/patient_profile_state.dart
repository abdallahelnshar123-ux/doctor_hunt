part of 'patient_profile_bloc.dart';

abstract class PatientProfileState extends Equatable {
  const PatientProfileState();

  @override
  List<Object?> get props => [];
}

class PatientProfileInitial extends PatientProfileState {}

class PatientProfileLoading extends PatientProfileState {}

class PatientProfileUpdateSuccess extends PatientProfileState {
  final MyUser user;

  const PatientProfileUpdateSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class PatientProfileUpdateError extends PatientProfileState {
  final String message;

  const PatientProfileUpdateError(this.message);

  @override
  List<Object?> get props => [message];
}

class PickPatientImageSuccessState extends PatientProfileState {
  final File image;

  const PickPatientImageSuccessState(this.image);

  @override
  List<Object?> get props => [image];
}

class PickPatientImageErrorState extends PatientProfileState {
  final String message;

  const PickPatientImageErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

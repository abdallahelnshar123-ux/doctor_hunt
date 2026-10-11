part of 'patient_doctors_bloc.dart';

abstract class PatientDoctorsState extends Equatable {
  const PatientDoctorsState();

  @override
  List<Object?> get props => [];
}

class PatientDoctorsInitial extends PatientDoctorsState {}

class PatientDoctorsLoading extends PatientDoctorsState {}

class PatientDoctorsSuccess extends PatientDoctorsState {
  final List<Doctor> doctors;

  const PatientDoctorsSuccess({required this.doctors});

  @override
  List<Object?> get props => [doctors];
}

class PatientDoctorsError extends PatientDoctorsState {
  final String message;

  const PatientDoctorsError(this.message);

  @override
  List<Object?> get props => [message];
}

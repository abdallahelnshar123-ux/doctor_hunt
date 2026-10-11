part of 'patient_doctors_bloc.dart';

abstract class PatientDoctorsEvent extends Equatable {
  const PatientDoctorsEvent();

  @override
  List<Object?> get props => [];
}

class PatientDoctorsRequested extends PatientDoctorsEvent {
  const PatientDoctorsRequested();
}

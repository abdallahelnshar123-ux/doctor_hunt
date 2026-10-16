part of 'patient_doctors_bloc.dart';

abstract class PatientDoctorsEvent extends Equatable {
  const PatientDoctorsEvent();

  @override
  List<Object?> get props => [];
}

class PatientDoctorsRequested extends PatientDoctorsEvent {
  const PatientDoctorsRequested();
}

class SearchPatientDoctorsRequested extends PatientDoctorsEvent {
  final String query;

  const SearchPatientDoctorsRequested(this.query);

  @override
  List<Object?> get props => [query];
}

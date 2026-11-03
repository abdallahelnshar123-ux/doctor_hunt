part of 'admin_patients_bloc.dart';

abstract class AdminPatientsEvent extends Equatable {
  const AdminPatientsEvent();

  @override
  List<Object> get props => [];
}

class AdminGetPatientsRequested extends AdminPatientsEvent {}

class AdminSearchPatientsRequested extends AdminPatientsEvent {
  final String query;

  const AdminSearchPatientsRequested(this.query);

  @override
  List<Object> get props => [query];
}

class AdminUpdatePatientStatusLocally extends AdminPatientsEvent {
  final String patientId;
  final bool active;

  const AdminUpdatePatientStatusLocally({
    required this.patientId,
    required this.active,
  });

  @override
  List<Object> get props => [patientId, active];
}

part of 'admin_patient_action_bloc.dart';

@immutable
sealed class AdminPatientActionEvent extends Equatable {
  const AdminPatientActionEvent();

  @override
  List<Object?> get props => [];
}

class TogglePatientDisabledStatusRequested extends AdminPatientActionEvent {
  final String patientId;
  final bool disabled;

  const TogglePatientDisabledStatusRequested({
    required this.patientId,
    required this.disabled,
  });

  @override
  List<Object?> get props => [patientId, disabled];
}

class TogglePatientActiveStatusRequested extends AdminPatientActionEvent {
  final String patientId;
  final bool active;

  const TogglePatientActiveStatusRequested({
    required this.patientId,
    required this.active,
  });

  @override
  List<Object?> get props => [patientId, active];
}

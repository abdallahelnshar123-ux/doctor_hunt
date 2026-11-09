part of 'admin_doctor_action_bloc.dart';

@immutable
sealed class AdminDoctorActionEvent {}

class ToggleDoctorDisabledStatusRequested extends AdminDoctorActionEvent {
  final String doctorId;
  final bool disabled;

  ToggleDoctorDisabledStatusRequested({
    required this.doctorId,
    required this.disabled,
  });
}

class ToggleDoctorActiveStatusRequested extends AdminDoctorActionEvent {
  final String doctorId;
  final bool active;

  ToggleDoctorActiveStatusRequested({
    required this.doctorId,
    required this.active,
  });
}

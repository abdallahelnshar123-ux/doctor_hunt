part of 'admin_doctor_action_bloc.dart';

@immutable
sealed class AdminDoctorActionEvent {}

class ToggleDoctorActiveStatusRequested extends AdminDoctorActionEvent {
  final String doctorId;
  final bool active;

  ToggleDoctorActiveStatusRequested({
    required this.doctorId,
    required this.active,
  });
}

class DeleteDoctorRequested extends AdminDoctorActionEvent {
  final String doctorId;

  DeleteDoctorRequested({required this.doctorId});
}

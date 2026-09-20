part of 'admin_doctor_action_bloc.dart';

@immutable
sealed class AdminDoctorActionState {}

final class AdminDoctorActionInitial extends AdminDoctorActionState {}

final class ToggleDoctorActiveStatusLoading extends AdminDoctorActionState {}

final class ToggleDoctorActiveStatusSuccess extends AdminDoctorActionState {}

final class ToggleDoctorActiveStatusError extends AdminDoctorActionState {
  final String message;

  ToggleDoctorActiveStatusError(this.message);
}

final class DeleteDoctorLoading extends AdminDoctorActionState {}

final class DeleteDoctorSuccess extends AdminDoctorActionState {}

final class DeleteDoctorError extends AdminDoctorActionState {
  final String message;

  DeleteDoctorError(this.message);
}

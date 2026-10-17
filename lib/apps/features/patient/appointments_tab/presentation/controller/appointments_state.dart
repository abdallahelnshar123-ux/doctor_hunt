part of 'appointments_bloc.dart';

sealed class AppointmentsState extends Equatable {
  const AppointmentsState();

  @override
  List<Object> get props => [];
}

final class AppointmentsInitial extends AppointmentsState {}

final class AppointmentsLoading extends AppointmentsState {}

final class AppointmentsSuccess extends AppointmentsState {
  final List<Appointment> appointments;

  const AppointmentsSuccess(this.appointments);

  @override
  List<Object> get props => [appointments];
}

final class AppointmentsError extends AppointmentsState {
  final String message;

  const AppointmentsError(this.message);

  @override
  List<Object> get props => [message];
}

final class AddReviewLoading extends AppointmentsState {
  final String appointmentId;

  const AddReviewLoading(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

final class AddReviewSuccess extends AppointmentsState {
  final String appointmentId;

  const AddReviewSuccess(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

final class AddReviewError extends AppointmentsState {
  final String message;
  final String appointmentId;

  const AddReviewError(this.message, this.appointmentId);

  @override
  List<Object> get props => [message, appointmentId];
}

final class CancelAppointmentLoading extends AppointmentsState {
  final String appointmentId;

  const CancelAppointmentLoading(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

final class CancelAppointmentSuccess extends AppointmentsState {
  final String appointmentId;

  const CancelAppointmentSuccess(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

final class CancelAppointmentError extends AppointmentsState {
  final String message;
  final String appointmentId;

  const CancelAppointmentError(this.message, this.appointmentId);

  @override
  List<Object> get props => [message, appointmentId];
}

import 'package:equatable/equatable.dart';

abstract class AppointmentActionState extends Equatable {
  const AppointmentActionState();

  @override
  List<Object> get props => [];
}

class AppointmentActionInitial extends AppointmentActionState {}

class AppointmentActionLoading extends AppointmentActionState {
  final String appointmentId;

  const AppointmentActionLoading(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

class AppointmentActionSuccess extends AppointmentActionState {
  final String appointmentId;

  const AppointmentActionSuccess(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

class AppointmentActionError extends AppointmentActionState {
  final String message;
  final String appointmentId;

  const AppointmentActionError(this.message, this.appointmentId);

  @override
  List<Object> get props => [message, appointmentId];
}

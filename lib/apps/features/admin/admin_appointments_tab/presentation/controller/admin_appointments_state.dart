import 'package:equatable/equatable.dart';

import '../../../../patient/appointments_tab/data/models/appointment/appointment.dart';

abstract class AdminAppointmentsState extends Equatable {
  const AdminAppointmentsState();

  @override
  List<Object?> get props => [];
}

class AdminAppointmentsInitial extends AdminAppointmentsState {}

class AdminAppointmentsLoadingState extends AdminAppointmentsState {}

class AdminAppointmentsLoadedState extends AdminAppointmentsState {
  final List<Appointment> appointments;

  const AdminAppointmentsLoadedState(this.appointments);

  @override
  List<Object?> get props => [appointments];
}

class AdminAppointmentsErrorState extends AdminAppointmentsState {
  final String message;

  const AdminAppointmentsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class AdminUpdateAppointmentLoadingState extends AdminAppointmentsState {
  final String appointmentId;

  const AdminUpdateAppointmentLoadingState(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}

class AdminUpdateAppointmentSuccessState extends AdminAppointmentsState {
  final String appointmentId;

  const AdminUpdateAppointmentSuccessState(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}

class AdminUpdateAppointmentErrorState extends AdminAppointmentsState {
  final String message;

  final String appointmentId;

  const AdminUpdateAppointmentErrorState(this.message, this.appointmentId);

  @override
  List<Object?> get props => [message, appointmentId];
}
